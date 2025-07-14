package org.example.repository;

import org.example.models.RegleReservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegleReservationRepository extends JpaRepository<RegleReservation, Integer> {
    RegleReservation findByTypeAdherent_Nom(String nom);
}
