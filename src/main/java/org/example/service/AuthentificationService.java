package org.example.service;

import org.example.models.Admin;
import org.example.models.Adherent;
import org.example.repository.AdminRepository;
import org.example.repository.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthentificationService {

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    public Object seConnecter(String email, String motDePasse) {
        Admin admin = adminRepository.findByEmailAndMotDePasse(email, motDePasse);
        if (admin != null) return admin;

        Adherent adherent = adherentRepository.findByEmailAndMotDePasse(email, motDePasse);
        return adherent; // peut être null
    }
}
