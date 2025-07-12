package org.example.controller;

import org.example.models.Exemplaire;
import org.example.models.Livre;
import org.example.service.LivreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.Set;
import java.util.List;

@Controller
@RequestMapping("/livres")
public class LivreController {

    @Autowired
    private LivreService livreService;

    // Afficher le formulaire
    @GetMapping("/ajouter")
    public String afficherFormulaireAjout(Model model) {
        model.addAttribute("livre", new Livre());
        return "ajouter_livre";
    }

    // Traitement du formulaire
    @PostMapping("/ajouter")
    public String ajouterLivre(
            @ModelAttribute Livre livre,
            @RequestParam("nbExemplaires") int nbExemplaires,
            @RequestParam("pretDomicile") boolean pretDomicile,
            Model model) {

        livre.setPretDomicile(pretDomicile);

        Set<Exemplaire> exemplaires = new HashSet<>();

        for (int i = 0; i < nbExemplaires; i++) {
            Exemplaire exemplaire = new Exemplaire();
            exemplaire.setEtat("neuf");
            exemplaire.setDisponible(true);
            exemplaire.setLivre(livre);
            exemplaires.add(exemplaire);
        }

        livre.setExemplaires(exemplaires);
        livreService.saveOrUpdate(livre);

        model.addAttribute("message", "Livre ajouté avec succès !");
        return "redirect:/livres/ajouter";
    }


    // Afficher tous les livres
    @GetMapping("/liste")
    public String listeLivres(Model model) {
        List<Livre> livres = livreService.getAll();
        List<Integer> nombresExemplaires = livres.stream()
            .map(l -> livreService.getAllExemplaires(l.getId()).size())
            .toList();

        model.addAttribute("livres", livres);
        model.addAttribute("nombresExemplaires", nombresExemplaires);

        return "liste_livres";
    }

}
