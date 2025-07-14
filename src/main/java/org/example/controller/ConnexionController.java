package org.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import org.example.models.Adherent;
import org.example.models.Admin;
import org.example.models.TypeAdherent;
import org.example.repository.TypeAdherentRepository;
import org.example.service.AuthentificationService;

@Controller
public class ConnexionController {

    @Autowired
    private AuthentificationService authService;

    @Autowired
    private TypeAdherentRepository typeAdherentRepository;

    @GetMapping("/login")
    public String afficherLogin(Model model) {
        model.addAttribute("email", "");
        model.addAttribute("motDePasse", "");
        List<TypeAdherent> typesAdherent = typeAdherentRepository.findAll();
        model.addAttribute("typesAdherent", typesAdherent);
        return "login";
    }

    @GetMapping("/signin")
    public String afficherSignin(Model model) {
        List<TypeAdherent> typesAdherent = typeAdherentRepository.findAll();
        model.addAttribute("typesAdherent", typesAdherent);
        return "login";
    }

    @PostMapping("/signin")
    public String inscription(@RequestParam("email") String email,
            @RequestParam("role") String role,
            @RequestParam("motDePasse") String motDePasse,
            Model model) {
        if (role == "adherent") {
            return "adherent/signin";
        }

        model.addAttribute("message", "Inscription en cours");
        return "register";
    }

    @PostMapping("/login")
    public String traiterLogin(@RequestParam("email") String email,
            @RequestParam("motDePasse") String motDePasse,
            Model model,
            HttpSession session) {
        Object utilisateur = authService.seConnecter(email, motDePasse);

        if (utilisateur instanceof Admin) {
            Admin admin = (Admin) utilisateur; // Transtypage ici
            session.setAttribute("admin", admin);
            return "redirect:/admin/dashboard";

        } else if (utilisateur instanceof Adherent) {
            Adherent adherent = (Adherent) utilisateur; // Transtypage ici
            session.setAttribute("adherent", adherent);
            return "redirect:/adherent/accueil";

        } else {
            model.addAttribute("erreur", "Identifiants incorrects");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String deconnexion(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
