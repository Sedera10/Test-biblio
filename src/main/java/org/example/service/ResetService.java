package org.example.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.example.models.Exemplaire;
import org.example.models.Livre;
import org.example.models.Prolongement;
import org.example.models.ReglePret;
import org.example.models.TypeAdherent;
import org.example.models.TypePret;
import org.example.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ResetService {

    @Autowired private PretRepository pretRepository;
    @Autowired private ReservationRepository reservationRepository;
    @Autowired private RenduRepository renduRepository;
    @Autowired private ExemplaireRepository exemplaireRepository;
    @Autowired private LivreRepository livreRepository;
    @Autowired private AdherentRepository adherentRepository;
    @Autowired private TypeAdherentRepository typeAdherentRepository;
    @Autowired private ProlongementRepository prolongementRepository;
    @Autowired private ReglePretRepository reglePretRepository;
    @Autowired private InscriptionRepository inscriptionRepository;
    @Autowired private EntityManager entityManager;

    @Transactional
    public void reset() {
        // Supprimer les données dépendantes d'abord
        renduRepository.deleteAll();
        exemplaireRepository.deleteAll();
        reservationRepository.deleteAll();
        pretRepository.deleteAll(); // supprimer les prêts après réservations/rendus
        prolongementRepository.deleteAll(); // si tu en as un
        inscriptionRepository.deleteAll();
        livreRepository.deleteAll();
        adherentRepository.deleteAll();

        entityManager.createNativeQuery("ALTER SEQUENCE adherent_id_adherent_seq RESTART WITH 1").executeUpdate();
        entityManager.createNativeQuery("ALTER SEQUENCE livre_id_livre_seq RESTART WITH 1").executeUpdate();
        entityManager.createNativeQuery("ALTER SEQUENCE exemplaire_id_exemplaire_seq RESTART WITH 1").executeUpdate();
        entityManager.createNativeQuery("ALTER SEQUENCE pret_id_pret_seq RESTART WITH 1").executeUpdate();
        entityManager.createNativeQuery("ALTER SEQUENCE reservation_id_reservation_seq RESTART WITH 1").executeUpdate();
        entityManager.createNativeQuery("ALTER SEQUENCE inscription_id_seq RESTART WITH 1").executeUpdate();

        // reglePretRepository.save(new ReglePret("Etudiant", "surplace", 2));
        // reglePretRepository.save(new ReglePret("Etudiant", "domicile", 7));
        // reglePretRepository.save(new ReglePret("Professeur", "domicile", 14));
        // reglePretRepository.save(new ReglePret("Professeur", "surplace", 3));

        // Ajouter des livres si besoin
        // Livre livre1 = new Livre("Excellence", "Paul Dupon", "Cristien", "902-124-538-20", 18, true);
        // Livre livre2 = new Livre("L'amour", "Francois", "Black", "123-325-0926-475", null, true);
        // livreRepository.saveAll(List.of(livre1, livre2));

        // Exemplaire ex1 = new Exemplaire("neuf", true, livre1);
        // Exemplaire ex2 = new Exemplaire("neuf", true, livre1);
        // Exemplaire ex3 = new Exemplaire("neuf", true, livre2);
        // exemplaireRepository.saveAll(List.of(ex1, ex2, ex3));
    }
}

