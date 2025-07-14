package org.example.controller;

import org.example.models.ReglePret;
import org.example.models.RegleReport;
import org.example.repository.ReglePretRepository;
import org.example.repository.RegleReportRepository;
import org.example.repository.PretRepository;
import org.example.repository.LivreRepository;
import org.example.repository.AdherentRepository;
import org.example.repository.ReservationRepository;
import org.example.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private RegleReportRepository regleReportRepository;

    @Autowired
    private ReglePretRepository reglePretRepository;

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/dashboard")
    public String afficherDashboard(Model model) {
        long totalPrets = pretRepository.count();
        long totalLivres = livreRepository.count();
        long totalAdherents = adherentRepository.count();
        long reservationsActives = reservationRepository.countByDateFinReservationIsNull();

        model.addAttribute("totalPrets", totalPrets);
        model.addAttribute("totalLivres", totalLivres);
        model.addAttribute("totalAdherents", totalAdherents);
        model.addAttribute("reservationsActives", reservationsActives);
        model.addAttribute("reservations", reservationRepository.findAll());

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

    @PostMapping("/reservations/valider")
    public String validerReservation(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        try {
            reservationService.validerReservation(id);
            redirectAttributes.addFlashAttribute("message", "Réservation approuvée !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "Erreur : " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/reservations/annuler")
    public String annulerReservation(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        reservationRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Réservation annulée.");
        return "redirect:/admin/dashboard";
    }

}
