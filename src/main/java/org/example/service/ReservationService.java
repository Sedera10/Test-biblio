package org.example.service;

import org.example.models.Exemplaire;
import org.example.models.Reservation;
import org.example.repository.AdherentRepository;
import org.example.repository.ExemplaireRepository;
import org.example.repository.LivreRepository;
import org.example.repository.ReservationRepository;
import org.example.repository.TypePretRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private TypePretRepository typePretRepository;

    public boolean effectuerReservation(int idAdherent, int idLivre, String typePretStr, LocalDate dateDebut, LocalDate dateFin) {
        List<Exemplaire> disponibles = exemplaireRepository
            .findExemplairesDisponiblesAvecReservationEtPret(idLivre, dateDebut, dateFin);

        if (disponibles.isEmpty()) {
            return false;
        }

        Reservation reservation = new Reservation();
        reservation.setAdherent(adherentRepository.findById(idAdherent).orElseThrow());
        reservation.setLivre(livreRepository.findById(idLivre).orElseThrow());
        reservation.setDateReservation(dateDebut);
        reservation.setDateFinReservation("domicile".equals(typePretStr) ? dateFin : null);
        reservation.setTypePret(typePretRepository.findById(typePretStr).orElseThrow());

        reservationRepository.save(reservation);
        return true;
    }

}
