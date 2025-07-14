package org.example.repository;

import org.example.models.Adherent;
import org.example.models.Inscription;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InscriptionRepository extends JpaRepository<Inscription, Integer> {
    // Récupère la dernière inscription (la plus récente) d’un adhérent
    Inscription findTopByAdherentOrderByDateFinDesc(Adherent adherent);
}
