package org.example.repository;

import org.example.models.Adherent;

import java.time.LocalDate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

// @Repository
public interface AdherentRepository extends JpaRepository<Adherent, Integer> {
    Adherent findByEmailAndMotDePasse(String email, String motDePasse);
    
    @Query("SELECT a.dateFinPenalite FROM Adherent a WHERE a.id = :idAdherent")
    LocalDate findDateFinPenalite(@Param("idAdherent") Integer idAdherent);

}