package org.example.repository;

import org.example.models.Prolongement;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProlongementRepository extends JpaRepository<Prolongement, Integer> {
    @Query("""
        SELECT pr FROM Prolongement pr
        WHERE pr.pret.exemplaire.id = :idExemplaire
        AND pr.nouvelleDate >= :dateFin
    """)
    List<Prolongement> findConflits(@Param("idExemplaire") int idExemplaire, @Param("dateFin") LocalDate dateFin);

    @Query("""
        SELECT COUNT(p) FROM Prolongement p
        WHERE p.pret.adherent.id = :idAdherent
        AND p.pret.id NOT IN (
            SELECT r.pret.id FROM Rendu r
        )
    """)
    int countProlongementsActifsByAdherent(@Param("idAdherent") int idAdherent);

}

