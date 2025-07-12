package org.example.controller;

import org.example.service.PretService;
import org.example.models.Adherent;
import org.example.models.Pret;
import org.example.repository.AdherentRepository;
import org.example.repository.PretRepository;
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
        boolean dispo = pretService.prolongerPret(idPret, nouvelleDate);
        if (dispo) {
            redirectAttributes.addFlashAttribute("message", "Prolongement réussi !");
        } else {
            redirectAttributes.addFlashAttribute("message", "Impossible de prolonger : le livre est réservé ou déjà prêt !");
        }
        return "redirect:/pret/liste";
    }
}

