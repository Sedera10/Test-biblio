package org.example.service;

import java.time.LocalDate;

import org.example.dto.DetailAdherentDTO;
import org.example.models.Adherent;
import org.example.models.TypeAdherent;
import org.example.repository.PretRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdherentService {

    @Autowired
    private PretRepository pretRepository;

    public DetailAdherentDTO buildDetail(Adherent adherent) {
        TypeAdherent type = adherent.getTypeAdherent();
        Integer quotaMax = type.getQuotaMax();
        long nbPrets = pretRepository.countPretsEnCoursParAdherent(adherent.getId());

        DetailAdherentDTO dto = new DetailAdherentDTO();
        dto.setId(adherent.getId());
        dto.setNom(adherent.getNom());
        dto.setEmail(adherent.getEmail());
        dto.setTypeAdherent(type.getNom());
        dto.setQuotaMax(quotaMax);
        dto.setNombrePretEnCours(nbPrets);
        dto.setResteQuota(quotaMax - nbPrets);
        dto.setDateFinPenalite(adherent.getDateFinPenalite());

        // penalisé si aujourd'hui < dateFinPenalite
        boolean penalise = adherent.getDateFinPenalite() != null &&
                           LocalDate.now().isBefore(adherent.getDateFinPenalite());
        dto.setPenalise(penalise);

        return dto;
    }
}
