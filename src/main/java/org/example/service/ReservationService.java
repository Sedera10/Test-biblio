package org.example.service;

import org.example.models.Adherent;
import org.example.models.Exemplaire;
import org.example.models.Inscription;
import org.example.models.Livre;
import org.example.models.ReglePret;
import org.example.models.RegleReservation;
import org.example.models.Reservation;
import org.example.models.TypePret;
import org.example.repository.AdherentRepository;
import org.example.repository.ExemplaireRepository;
import org.example.repository.InscriptionRepository;
import org.example.repository.LivreRepository;
import org.example.repository.ReglePretRepository;
import org.example.repository.RegleReservationRepository;
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

    @Autowired
    private InscriptionRepository inscriptionRepository;

    @Autowired
    private RegleReservationRepository regleReservationRepository;

    @Autowired
    private ReglePretRepository reglePretRepository;

    @Autowired
    private InscriptionService inscriptionService;

    public boolean effectuerReservation(int idAdherent, int idLivre, String typePretStr, LocalDate dateDebut,
            LocalDate dateFin) {
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

    public void validerReservation(int idReservation) {
        Reservation reservation = reservationRepository.findById(idReservation)
                .orElseThrow(() -> new RuntimeException("Réservation introuvable"));

        Adherent adherent = reservation.getAdherent();

        if (!inscriptionService.estAbonne(adherent)) {
            throw new RuntimeException("L'adhérent n'est pas abonné.");
        }

        if (adherent.getDateFinPenalite() != null && !adherent.getDateFinPenalite().isBefore(LocalDate.now())) {
            throw new RuntimeException("L'adhérent a une pénalité en cours.");
        }

        RegleReservation reservationC = regleReservationRepository
                .findByTypeAdherent_Nom(adherent.getTypeAdherent().getNom());
        long quota = reservationC.getQuotaMax();
        long nombreReserv = reservationRepository.countByAdherent_IdAndValideTrue(adherent.getId());
        if (nombreReserv >= quota) {
            throw new RuntimeException("Quota de réservation atteint.");
        }

        if (!isExemplaireDisponible(reservation.getLivre(), reservation.getDateReservation())) {
            throw new RuntimeException("Aucun exemplaire disponible pour les dates indiquées.");
        }

        reservation.setValide(true);
        reservationRepository.save(reservation);
    }

    public boolean peutValiderReservation(Reservation reservation) {
        Adherent adherent = reservation.getAdherent();

        // 1. Vérifier l'abonnement actif
        Inscription inscription = inscriptionRepository.findTopByAdherentOrderByDateFinDesc(adherent);
        if (inscription == null || inscription.getDateFin().isBefore(LocalDate.now())) {
            throw new IllegalStateException("L'abonnement n'est plus valide.");
        }

        // 2. Vérifier la pénalité
        if (adherent.getDateFinPenalite() != null && !adherent.getDateFinPenalite().isBefore(LocalDate.now())) {
            throw new IllegalStateException("Pénalité en cours.");
        }

        // 3. Vérifier le quota
        RegleReservation regle = regleReservationRepository.findByTypeAdherent_Nom(adherent.getTypeAdherent().getNom());
        long nbActuelles = reservationRepository.countByAdherent_IdAndValideTrue(adherent.getId());
        if (nbActuelles >= regle.getQuotaMax()) {
            throw new IllegalStateException("Quota de réservation dépassé.");
        }

        // 4. Vérifier la disponibilité d’un exemplaire
        if (!isExemplaireDisponible(reservation.getLivre(), reservation.getDateReservation())) {
            throw new IllegalStateException("Aucun exemplaire disponible pour ces dates.");
        }

        return true;
    }

    public boolean isExemplaireDisponible(Livre livre, LocalDate dateDebut) {
        int idLivre = livre.getId();

        boolean dispoPret = !exemplaireRepository.findDisponiblesSelonPret(idLivre, dateDebut).isEmpty();
        boolean dispoReservation = !exemplaireRepository.findDisponiblesSelonReservation(idLivre, dateDebut).isEmpty();

        return dispoPret && dispoReservation;
    }

}
