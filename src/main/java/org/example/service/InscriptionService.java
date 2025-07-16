package org.example.service;

import org.example.models.Adherent;
import org.example.models.Inscription;
import org.example.repository.InscriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class InscriptionService {

    @Autowired
    private InscriptionRepository inscriptionRepository;

    public Inscription getDerniereInscription(Adherent adherent) {
        return inscriptionRepository.findTopByAdherentOrderByDateFinDesc(adherent);
    }

    public boolean estAbonne(Adherent adherent) {
        Inscription derniere = getDerniereInscription(adherent);
        return derniere != null && derniere.getDateFin().isAfter(LocalDate.now());
    }
     public boolean estAbonne(Adherent adherent,LocalDate daty) {
        Inscription derniere = getDerniereInscription(adherent);
        return derniere != null && derniere.getDateFin().isAfter(daty);
    }

    public void enregistrerInscription(Inscription inscription) {
        inscriptionRepository.save(inscription);
    }
}
