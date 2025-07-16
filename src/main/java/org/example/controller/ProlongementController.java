package org.example.controller;

import org.example.service.PretService;
import org.example.models.Adherent;
import org.example.models.Pret;
import org.example.models.Prolongement;
import org.example.repository.AdherentRepository;
import org.example.repository.PretRepository;
import org.example.repository.ProlongementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/prolongement")
public class ProlongementController {

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private ProlongementRepository prolongementRepository;

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private PretService pretService;

    @GetMapping("/form")
    public String afficherFormulaireProlongement(@RequestParam("idPret") int idPret, @RequestParam("idAdherent") int idAdherent, Model model) {
        Pret pret = pretRepository.findById(idPret).orElseThrow();
        Adherent client = adherentRepository.findById(idAdherent).orElseThrow();
        model.addAttribute("pret", pret);
        model.addAttribute("adherent", client);
        return "prolongement_form";
    }

    @PostMapping("/valider")
    public String validerProlongement(@RequestParam("idPret") int idPret,
                                      @RequestParam("nouvelleDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate nouvelleDate,
                                      RedirectAttributes redirectAttributes) {
        Pret pret = pretRepository.findById(idPret).orElse(null);
        int nombreProlongements = prolongementRepository.countProlongementsActifsByAdherent(pret.getAdherent().getId());
        int quotaProlongement = pret.getAdherent().getTypeAdherent().getProlongementMax();

        pretService.verifierPenaliteAvantPret(pret.getAdherent().getId());

        try {
            String dispo = pretService.prolongerPret(idPret, nouvelleDate);
            redirectAttributes.addFlashAttribute("message", dispo);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", e.getMessage());
        }
        
        if (nombreProlongements >= quotaProlongement) {
            redirectAttributes.addFlashAttribute("erreur", "Quota de prolongements atteint pour l'adhérent.");
            return "/prolongement/form";
        }

        return "redirect:/pret/liste";
    }
}

