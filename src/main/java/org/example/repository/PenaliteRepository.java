package org.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import org.example.models.Penalite;

public interface PenaliteRepository extends JpaRepository<Penalite, Integer> {

    @Query("""
        SELECT CASE 
            WHEN COUNT(p) > 0 THEN true 
            ELSE false 
        END 
        FROM Penalite p 
        WHERE p.pret.adherent.id = :idAdherent
        AND p.pret.dateRetour IS NOT NULL 
        AND p.pret.dateRetour > p.pret.dateDebut
        AND p.applique = false
    """)
    boolean hasRetardNonApplique(@Param("idAdherent") Integer idAdherent);
}

