package org.example.service;

import java.time.LocalDate;

import org.example.dto.DetailAdherentDTO;
import org.example.models.Adherent;
import org.example.models.Inscription;
import org.example.models.TypeAdherent;
import org.example.repository.InscriptionRepository;
import org.example.repository.PretRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdherentService {

    @Autowired
    private PretRepository pretRepository;

   @Autowired
    private InscriptionRepository inscriptionRepository;

    public DetailAdherentDTO buildDetail(Adherent adherent) {
        LocalDate today = LocalDate.now();

        // Quota
        int quotaMax = adherent.getTypeAdherent().getQuotaMax();
        long nombrePret = pretRepository.countPretsEnCoursParAdherent(adherent.getId());
        long resteQuota = quotaMax - nombrePret;

        // Pénalité
        boolean penalise = adherent.getDateFinPenalite() != null
                && !adherent.getDateFinPenalite().isBefore(today);

        // Abonnement (via inscription la plus récente)
        LocalDate dateFinInscription = null;
        Inscription inscription = inscriptionRepository.findTopByAdherentOrderByDateFinDesc(adherent);
        if (inscription != null) {
            dateFinInscription = inscription.getDateFin();
        }
        boolean isAbonne = dateFinInscription != null && !dateFinInscription.isBefore(today);

        return new DetailAdherentDTO(
                adherent.getId(),
                adherent.getNom(),
                adherent.getEmail(),
                adherent.getTypeAdherent().getNom(),
                quotaMax,
                nombrePret,
                resteQuota,
                penalise,
                adherent.getDateFinPenalite(),
                isAbonne
        );
    }

    // public boolean isAbonne(Adherent adherent) {
    //     return adherent.getInscriptions().stream()
    //         .map(Inscription::getDateFin)
    //         .max(LocalDate::compareTo)  // dernière date de fin
    //         .map(dateFin -> !dateFin.isBefore(LocalDate.now()))
    //         .orElse(false);
    // }

}
