package org.example.controller;

import org.example.models.ReglePret;
import org.example.models.RegleReport;
import org.example.repository.ReglePretRepository;
import org.example.repository.RegleReportRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private RegleReportRepository regleReportRepository;

    @Autowired
    private ReglePretRepository reglePretRepository;

    @GetMapping("/dashboard")
    public String afficherLogin(Model model) {
        
        return "home";
    }

    @GetMapping("/config")
    public String afficherConfiguration(Model model) {
        // Récupère ou initialise la règle de report
        RegleReport regleReport = regleReportRepository.findById(1L).orElseGet(() -> {
            RegleReport r = new RegleReport();
            r.setId(1L);
            r.setChoix("apres");
            return regleReportRepository.save(r);
        });

        model.addAttribute("regleReport", regleReport);
        model.addAttribute("reglePrets", reglePretRepository.findAll());

        return "config";
    }

    @PostMapping("/config/calendrier")
    public String modifierRegleReport(@RequestParam("choix") String choix) {
        RegleReport regle = regleReportRepository.findById(1L).orElse(new RegleReport());
        regle.setId(1L);
        regle.setChoix(choix);
        regleReportRepository.save(regle);
        return "redirect:/admin/config";
    }

    @PostMapping("/config/updateReglePret")
    public String modifierReglePret(@RequestParam("id") int id, @RequestParam("dureeJours") int dureeJours) {
        ReglePret regle = reglePretRepository.findById(id).orElseThrow(() -> new RuntimeException("Règle introuvable"));
        regle.setDureeJours(dureeJours);
        reglePretRepository.save(regle);
        return "redirect:/admin/config";
    }

}

