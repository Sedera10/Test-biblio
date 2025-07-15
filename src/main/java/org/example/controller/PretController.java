package org.example.controller;
import org.example.models.Pret;
import org.example.models.Adherent;
import org.example.service.PretService;
import org.example.repository.AdherentRepository;
import org.example.repository.LivreRepository;
import org.example.repository.TypePretRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/pret")
public class PretController {

    @Autowired
    private PretService pretService;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private TypePretRepository typePretRepository;


    @GetMapping("/form")
    public String showForm(Model model) {
        model.addAttribute("pret", new Pret());
        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("typeprets", typePretRepository.findAll());
        return "form_pret";
    }

    @PostMapping("/valider")
    public String validerPret(
            @RequestParam("idAdherent") int idAdherent,
            @RequestParam("idLivre") int idLivre,
            @RequestParam("typePret") String typePret,
            @RequestParam(value = "datePret", required = false)  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate datePret,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {
            // ➤ Vérifie si l'adhérent est pénalisé ou a un prêt en retard
            pretService.verifierPenaliteAvantPret(idAdherent);

            // ➤ Tente de faire le prêt
            String message = pretService.effectuerPret(idAdherent, idLivre, typePret,datePret);
            redirectAttributes.addFlashAttribute("message", message);
        } catch (IllegalStateException ex) {
            // ➤ Si pénalité ou retard détecté, affiche l'erreur
            redirectAttributes.addFlashAttribute("erreur", ex.getMessage());
        }

        return "redirect:/pret/form";
    }


    @GetMapping("/liste")
    public String listerPretsAvecFiltre(
            @RequestParam(name = "idAdherent", required = false) Integer idAdherent,
            @RequestParam(name = "dateDebut", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
            @RequestParam(name = "dateFin", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
            @RequestParam(name = "etat", required = false) String etat,
            Model model
    ) {
        List<Adherent> adherents = adherentRepository.findAll();
        model.addAttribute("adherents", adherents);

        List<Pret> prets = pretService.rechercher(idAdherent, dateDebut, dateFin, etat);
        model.addAttribute("prets", prets);

        return "liste_pret";
    }

    @PostMapping("/rendre")
    public String rendrePret(@RequestParam("idPret") int idPret, 
                        @RequestParam("dateRendu") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateRendu,
                        RedirectAttributes redirectAttributes) {
        boolean rendu = pretService.rendrePret(idPret,dateRendu);

        if (rendu) {
            redirectAttributes.addFlashAttribute("message", "Livre rendu avec succès.");
        } else {
            redirectAttributes.addFlashAttribute("message", "Erreur : prêt introuvable.");
        }

        return "redirect:/pret/liste";
    }

}
