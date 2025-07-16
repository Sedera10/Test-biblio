package org.example.repository;

import org.example.models.Exemplaire;
import org.example.models.Pret;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

// @Repository
public interface PretRepository extends JpaRepository<Pret, Integer> {
    @Query("""
        SELECT p FROM Pret p
        WHERE p.exemplaire.id = :idExemplaire
        AND :dateFin BETWEEN p.dateDebut AND p.dateRetour
    """)
    List<Pret> findChevauchements(@Param("idExemplaire") int idExemplaire, @Param("dateFin") LocalDate dateFin);


    @Query("""
        SELECT p FROM Pret p
        WHERE p.adherent.id = :idAdherent
        AND p.dateRetour >= CURRENT_DATE
    """)
    List<Pret> findPretsActifsParAdherent(@Param("idAdherent") int idAdherent);


    List<Pret> findByAdherent_Id(Integer idAdherent);
    List<Pret> findByDateDebutGreaterThanEqual(LocalDate dateDebut);
    List<Pret> findByDateDebutBetween(LocalDate debut, LocalDate fin);
    List<Pret> findByRendu(boolean rendu);
    List<Pret> findByAdherent_IdAndDateDebutGreaterThanEqual(Integer idAdherent, LocalDate dateDebut);
    List<Pret> findByAdherent_IdAndDateDebutBetween(Integer idAdherent, LocalDate debut, LocalDate fin);
    List<Pret> findByAdherent_IdAndDateDebutBetweenAndRendu(Integer idAdherent, LocalDate debut, LocalDate fin, boolean rendu);

    boolean existsByAdherent_IdAndRenduFalseAndDateRetourBefore(Integer idAdherent, LocalDate dateLimite);
    
    @Query("""
        SELECT COUNT(p) FROM Pret p
        WHERE p.adherent.id = :idAdherent AND p.rendu = false
    """)
    long countPretsEnCoursParAdherent(@Param("idAdherent") Integer idAdherent);

    boolean existsByExemplaireAndRenduFalse(Exemplaire exemplaire);


}


