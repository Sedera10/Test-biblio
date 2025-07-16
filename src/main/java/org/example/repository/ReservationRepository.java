package org.example.repository;

import org.example.models.Livre;
import org.example.models.Reservation;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

// @Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    @Query("""
            SELECT r FROM Reservation r
                WHERE r.livre.id = :idLivre
                AND (
                    r.dateReservation <= :dateFin
                    AND (r.dateFinReservation IS NULL OR r.dateFinReservation >= CURRENT_DATE)
                )
            """)
    List<Reservation> findConflits(@Param("idLivre") int idLivre, @Param("dateFin") LocalDate dateFin);

    long countByDateFinReservationIsNull();

    List<Reservation> findByAdherent_Id(Integer idAdherent);

    List<Reservation> findByAdherent_IdAndValideTrue(Integer idAdherent);

    long countByAdherent_IdAndValideTrue(Integer idAdherent);

    boolean existsByLivreAndValideTrue(Livre livre);


}
