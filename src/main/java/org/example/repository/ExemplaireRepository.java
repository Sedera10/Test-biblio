package org.example.repository;

import org.example.models.Exemplaire;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

// @Repository
public interface ExemplaireRepository extends JpaRepository<Exemplaire, Integer> {
    List<Exemplaire> findByDisponibleTrue(); // uniquement les exemplaires dispo
    List<Exemplaire> findByLivre_Id(Integer idLivre);
    Exemplaire findFirstByLivre_IdAndDisponibleTrue(Integer idLivre);

    @Query("""
    SELECT e FROM Exemplaire e
        WHERE e.livre.id = :idLivre AND NOT EXISTS (
            SELECT 1 FROM Pret p
            WHERE p.exemplaire = e
            AND CURRENT_DATE BETWEEN p.dateDebut AND p.dateRetour
        )
    """)
    List<Exemplaire> findExemplairesDisponiblesParLivre(@Param("idLivre") int idLivre);

    @Query("""
        SELECT e FROM Exemplaire e
        WHERE e.livre.id = :idLivre
        AND NOT EXISTS (
            SELECT 1 FROM Pret p
            WHERE p.exemplaire = e AND (
                :dateDebut BETWEEN p.dateDebut AND p.dateRetour OR
                :dateFin BETWEEN p.dateDebut AND p.dateRetour OR
                p.dateDebut BETWEEN :dateDebut AND :dateFin
            )
        )
        AND NOT EXISTS (
            SELECT 1 FROM Reservation r
            WHERE r.livre = e.livre AND (
                :dateDebut BETWEEN r.dateReservation AND COALESCE(r.dateFinReservation, r.dateReservation) OR
                :dateFin BETWEEN r.dateReservation AND COALESCE(r.dateFinReservation, r.dateReservation) OR
                r.dateReservation BETWEEN :dateDebut AND :dateFin
            )
        )
    """)
    List<Exemplaire> findExemplairesDisponiblesAvecReservationEtPret(
        @Param("idLivre") int idLivre,
        @Param("dateDebut") LocalDate dateDebut,
        @Param("dateFin") LocalDate dateFin
    );

}