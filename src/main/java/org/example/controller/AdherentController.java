package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("adherent")
public class AdherentController {
    
    @GetMapping("/accueil")
    public String accueil() {
        return "redirect:/livres/liste";
    }
    
}
