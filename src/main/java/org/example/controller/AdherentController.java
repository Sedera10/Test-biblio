package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.example.models.Adherent;
import org.example.repository.AdherentRepository;
import org.example.repository.TypeAdherentRepository;
import org.example.service.InscriptionService;
import org.example.models.Inscription;
import org.example.models.TypeAdherent;
import org.springframework.ui.Model;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("adherent")
public class AdherentController {

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private TypeAdherentRepository typeAdherentRepository;

    @Autowired
    private InscriptionService inscriptionService;

    @GetMapping("/accueil")
    public String accueil() {
        return "redirect:/livres/liste";
    }

    @GetMapping("/liste")
    public String listeAdherents(Model model) {
        List<Adherent> adherents = adherentRepository.findAll();
        model.addAttribute("adherents", adherents);
        return "adherent_liste";
    }

    // Inscription
    @PostMapping("/inscription")
    public String postSignin(HttpServletRequest request, Model model) {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String typeNom = request.getParameter("typeAdherent");

        if (nom == null || email == null || motDePasse == null || typeNom == null) {
            model.addAttribute("erreur", "Tous les champs sont obligatoires.");
            return "login";
        }

        if (adherentRepository.findByEmail(email) != null) {
            model.addAttribute("erreur", "Un compte avec cet email existe déjà.");
            return "login";
        }

        TypeAdherent type = typeAdherentRepository.findByNom(typeNom);
        if (type == null) {
            model.addAttribute("erreur", "Type d’adhérent invalide.");
            return "login";
        }

        // Créer l’adhérent
        Adherent adherent = new Adherent();
        adherent.setNom(nom);
        adherent.setEmail(email);
        adherent.setMotDePasse(motDePasse);
        adherent.setTypeAdherent(type);
        adherent.setInscription(LocalDate.now());

        adherentRepository.save(adherent);

        // Créer l'inscription
        Inscription inscription = new Inscription();
        inscription.setAdherent(adherent);
        inscription.setDateDebut(LocalDate.now());
        inscription.setDateFin(LocalDate.now().plusDays(30));

        inscriptionService.enregistrerInscription(inscription);

        model.addAttribute("message", "Inscription réussie. Veuillez vous connecter.");
        return "redirect:/login";
    }

    // Reinscription
    @GetMapping("reinscription")
    public String goToPageInscription(Model model, HttpSession session) {
        List<Adherent> adherents = adherentRepository.findAll();
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent != null && !inscriptionService.estAbonne(adherent)) {
            model.addAttribute("message", "Votre abonnement est expiré, veuillez vous réinscrire.");
            return "reinscription";
        }
        model.addAttribute("adherents", adherents);
        return "reinscription";
    }

    @PostMapping("/reinscription")
    public String reinscrire(@RequestParam("id") int idAdherent, Model model) {
        Adherent adherent = adherentRepository.findById(idAdherent).orElse(null);

        if (adherent.getTypeAdherent().getNom().equalsIgnoreCase("visiteur")) {
            model.addAttribute("message", "Les visiteurs ne peuvent pas se réinscrire.");
            return "reinscription";
        }

        Inscription derniereInscription = inscriptionService.getDerniereInscription(adherent);
        if (derniereInscription.getDateFin().isAfter(LocalDate.now())) {
            model.addAttribute("message", "L’abonnement est encore actif.");
            return "reinscription";
        }

        // Réinscription
        Inscription nouvelle = new Inscription();
        nouvelle.setAdherent(adherent);
        nouvelle.setDateDebut(derniereInscription.getDateFin());
        nouvelle.setDateFin(derniereInscription.getDateFin().plusDays(30));
        inscriptionService.enregistrerInscription(nouvelle);

        model.addAttribute("message", "Réinscription effectuée avec succès !");
        return "redirect:/adherent/reinscription";
    }

}
