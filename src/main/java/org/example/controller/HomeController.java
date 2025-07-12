package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HomeController {
    @GetMapping("/index")
    public String listEmployes(Model model) {    
        return "index"; 
    }

    @GetMapping("/admin/login")
    public String login(Model model){
        return "login";
    }
}
