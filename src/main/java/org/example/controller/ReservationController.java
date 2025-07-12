package org.example.controller;

import org.example.service.ReservationService;
import org.example.repository.AdherentRepository;
import org.example.repository.LivreRepository;
import org.example.repository.TypePretRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import java.time.LocalDate;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private TypePretRepository typePretRepository;

    @GetMapping("/form")
    public String afficherFormulaire(Model model) {
        model.addAttribute("adherents", adherentRepository.findAll());
        model.addAttribute("livres", livreRepository.findAll());
        model.addAttribute("typesPret", typePretRepository.findAll());

        return "form_reservation"; // nom du fichier JSP
    }

    @PostMapping("/reserver")
    public String reserver(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        int idAdherent = Integer.parseInt(request.getParameter("idAdherent"));
        int idLivre = Integer.parseInt(request.getParameter("idLivre"));
        String typePret = request.getParameter("typePret");
        LocalDate dateDebut = LocalDate.parse(request.getParameter("dateReservation"));
        LocalDate dateFin = typePret.equals("domicile") ? LocalDate.parse(request.getParameter("dateFinReservation")) : dateDebut;

        boolean success = reservationService.effectuerReservation(idAdherent, idLivre, typePret, dateDebut, dateFin);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Réservation effectuée avec succès !");
        } else {
            redirectAttributes.addFlashAttribute("message", "Aucun exemplaire disponible pour ces dates.");
        }

        return "redirect:/reservation/form";
    }
}
