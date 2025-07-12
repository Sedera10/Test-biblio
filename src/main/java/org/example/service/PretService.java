package org.example.service;

import org.example.models.Adherent;
import org.example.models.Exemplaire;
import org.example.models.Livre;
import org.example.models.Penalite;
import org.example.models.Pret;
import org.example.models.Prolongement;
import org.example.models.ReglePret;
import org.example.models.Reservation;
import org.example.models.TypePret;
import org.example.repository.AdherentRepository;
import org.example.repository.ExemplaireRepository;
import org.example.repository.LivreRepository;
import org.example.repository.PenaliteRepository;
import org.example.repository.PretRepository;
import org.example.repository.ProlongementRepository;
import org.example.repository.ReglePretRepository;
import org.example.repository.ReservationRepository;
import org.example.repository.TypePretRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PretService {

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private TypePretRepository typePretRepository;

    @Autowired
    private ReglePretRepository reglePretRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private ProlongementRepository prolongementRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;

    @Autowired
    private CalendrierService calendrierService;

    public void enregistrerPret(Pret pret) {
        pretRepository.save(pret);
    }

    public Optional<Pret> getPretById(int idPret) {
        return pretRepository.findById(idPret);
    }

    public List<Pret> getAll() {
        return pretRepository.findAll();
    }

    public String effectuerPret(int idAdherent, int idLivre, String typePret) {
        Adherent adherent = adherentRepository.findById(idAdherent).orElse(null);
        if (adherent == null) return "Adhérent introuvable";

        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return "Livre introuvable";
    
        List<Exemplaire> disponibles = exemplaireRepository.findExemplairesDisponiblesParLivre(idLivre);
        if (disponibles.isEmpty()) return "Aucun exemplaire disponible";
        Exemplaire exemplaireDispo = disponibles.get(0);
    
        boolean domicile = typePret.equalsIgnoreCase("DOMICILE");
        if (domicile && !livre.isPretDomicile()) {
            return "Ce livre n'est pas autorisé pour un prêt à domicile";
        }
        
        // ReglePret regle = reglePretRepository
        //     .findByTypeAdherentAndTypePret(adherent.getTypeAdherent().getNom(), typePret);
        ReglePret regle = reglePretRepository.findRegle(adherent.getTypeAdherent().getNom(), typePret);
        if (regle == null) return "Aucune règle de prêt définie";
    
        LocalDate debut = LocalDate.now();
        LocalDate retour = debut.plusDays(regle.getDureeJours());
    
        exemplaireDispo.setDisponible(false);
        exemplaireRepository.save(exemplaireDispo);

        LocalDate dateRetourAjustee = calendrierService.ajusterDate(retour);
    
        Pret pret = new Pret();
        pret.setAdherent(adherent);
        pret.setExemplaire(exemplaireDispo);
        pret.setDateDebut(debut);
        pret.setDateRetour(dateRetourAjustee);
        TypePret typePretEntity = typePretRepository.findById(typePret).orElse(null);
        if (typePretEntity == null) return "Type de prêt inconnu";
        pret.setTypePret(typePretEntity);

        pretRepository.save(pret);
    
        return "Prêt enregistré. Retour prévu le : " + retour;
    }

    public boolean estExemplaireDisponiblePourProlongement(Exemplaire exemplaire, LocalDate nouvelleDateFin) {
        int idLivre = exemplaire.getLivre().getId();

        // 1. Vérifie les réservations sur ce livre après aujourd’hui jusqu'à nouvelleDate
        List<Reservation> conflits = reservationRepository.findConflits(idLivre, nouvelleDateFin);
        if (!conflits.isEmpty()) return false;

        // 2. Vérifie les prêts en conflit sur cet exemplaire
        List<Pret> pretsConflits = pretRepository.findChevauchements(exemplaire.getId(), nouvelleDateFin);
        if (!pretsConflits.isEmpty()) return false;

        // 3. Vérifie les prolongements en conflit (via les prêts)
        List<Prolongement> conflitsProlong = prolongementRepository.findConflits(exemplaire.getId(), nouvelleDateFin);
        return conflitsProlong.isEmpty();
    }

    public boolean prolongerPret(int idPret, LocalDate nouvelleDate) {
        Optional<Pret> optionalPret = pretRepository.findById(idPret);
        if (optionalPret.isEmpty()) return false;

        Pret pret = optionalPret.get();
        Exemplaire exemplaire = pret.getExemplaire();
        LocalDate ancienneDate = pret.getDateRetour();

        // Vérifie la disponibilité de l'exemplaire
        if (!estExemplaireDisponiblePourProlongement(exemplaire, nouvelleDate)) {
            return false;
        }

        // Enregistre le prolongement
        Prolongement prolongement = new Prolongement(pret, ancienneDate, nouvelleDate);
        prolongementRepository.save(prolongement);

        // Met à jour la date de retour dans le prêt
        pret.setDateRetour(nouvelleDate);
        pretRepository.save(pret);

        return true;
    }

    public List<Pret> rechercher(Integer idAdherent, LocalDate dateDebut, LocalDate dateFin, String etat) {
        boolean filtrerAdherent = idAdherent != null;
        boolean filtrerDateDebut = dateDebut != null;
        boolean filtrerDateFin = dateFin != null;
        boolean filtrerEtat = etat != null && (etat.equals("rendu") || etat.equals("non_rendu"));
    
        boolean rendu = etat != null && etat.equals("rendu");
    
        // Cas complet avec tous les filtres
        if (filtrerAdherent && filtrerDateDebut && filtrerDateFin && filtrerEtat) {
            return pretRepository.findByAdherent_IdAndDateDebutBetweenAndRendu(idAdherent, dateDebut, dateFin, rendu);
        }
    
        // Cas avec Adherent + dateDebut + dateFin
        if (filtrerAdherent && filtrerDateDebut && filtrerDateFin) {
            return pretRepository.findByAdherent_IdAndDateDebutBetween(idAdherent, dateDebut, dateFin);
        }
    
        // Cas avec dateDebut + dateFin
        if (!filtrerAdherent && filtrerDateDebut && filtrerDateFin) {
            return pretRepository.findByDateDebutBetween(dateDebut, dateFin);
        }
    
        // Cas avec dateDebut seule
        if (filtrerDateDebut && !filtrerDateFin) {
            return pretRepository.findByDateDebutGreaterThanEqual(dateDebut);
        }
    
        // Cas avec etat seulement
        if (filtrerEtat && !filtrerAdherent && !filtrerDateDebut && !filtrerDateFin) {
            return pretRepository.findByRendu(rendu);
        }
    
        // Cas avec adherent seul
        if (filtrerAdherent && !filtrerDateDebut && !filtrerDateFin && !filtrerEtat) {
            return pretRepository.findByAdherent_Id(idAdherent);
        }
    
        // Tous les prêts
        return pretRepository.findAll();
    }
         
    public boolean rendrePret(int idPret) {
        Optional<Pret> optionalPret = getPretById(idPret);
    
        if (optionalPret.isPresent()) {
            Pret pret = optionalPret.get();
    
            // Marquer comme rendu
            pret.setRendu(true);
            pretRepository.save(pret);
    
            // Rendre l'exemplaire disponible
            Exemplaire exemplaire = pret.getExemplaire();
            exemplaire.setDisponible(true);
            exemplaireRepository.save(exemplaire);
    
            // Vérifier s’il y a eu un retard
            LocalDate dateRetourTheorique = pret.getDateRetour();
            LocalDate dateRetourReelle = LocalDate.now();
    
            if (dateRetourTheorique != null && dateRetourReelle.isAfter(dateRetourTheorique)) {
                int joursDeRetard = dateRetourTheorique.until(dateRetourReelle).getDays();
    
                Adherent adherent = pret.getAdherent();
                int joursPenalite = adherent.getTypeAdherent().getJoursPenalite();
    
                // Calcul de la nouvelle date de fin de pénalité
                LocalDate ancienneFin = adherent.getDateFinPenalite();
                LocalDate base = (ancienneFin != null && ancienneFin.isAfter(dateRetourReelle))
                        ? ancienneFin : dateRetourReelle;
                LocalDate nouvelleFin = base.plusDays(joursPenalite);
    
                // Mettre à jour l’adhérent
                adherent.setDateFinPenalite(nouvelleFin);
                adherentRepository.save(adherent);
    
                // Enregistrer la pénalité
                Penalite penalite = new Penalite();
                penalite.setPret(pret);
                penalite.setMotif("Retard de " + joursDeRetard + " jour(s)");
                penalite.setApplique(true);
                penaliteRepository.save(penalite);
            }
    
            return true;
        }
    
        return false;
    }
    
    public LocalDate calculerDateRetourTheorique(Pret pret) {
        String typeAdh = pret.getAdherent().getTypeAdherent().getNom();
        String typePret = pret.getTypePret().getType();
    
        ReglePret regleOpt = reglePretRepository.findByTypeAdherentAndTypePret(typeAdh, typePret);
    
        if (regleOpt == null) {
            throw new RuntimeException("Règle de prêt introuvable pour : " + typeAdh + " / " + typePret);
        }
    
        int duree = regleOpt.getDureeJours();
        return pret.getDateDebut().plusDays(duree);
    }

    public void verifierEtAppliquerPenalite(Pret pret) {
        if (pret.isRendu() && pret.getDateRetour() != null 
                && pret.getDateRetour().isAfter(calculerDateRetourTheorique(pret))) {
    
            Adherent adherent = pret.getAdherent();
            int joursPenalite = adherent.getTypeAdherent().getJoursPenalite();
            LocalDate dateFinActuelle = adherent.getDateFinPenalite() != null
                    ? adherent.getDateFinPenalite()
                    : LocalDate.now();
    
            LocalDate nouvelleFin = pret.getDateRetour().isAfter(dateFinActuelle)
                    ? pret.getDateRetour().plusDays(joursPenalite)
                    : dateFinActuelle.plusDays(joursPenalite);
    
            adherent.setDateFinPenalite(nouvelleFin);
            adherentRepository.save(adherent);
    
            Penalite penalite = new Penalite();
            penalite.setPret(pret);
            penalite.setMotif("Retard de retour");
            penalite.setApplique(false);
            penaliteRepository.save(penalite);
        }
    }    
    
    public void verifierPenaliteAvantPret(Integer idAdherent) {
        Adherent adherent = adherentRepository.findById(idAdherent)
            .orElseThrow(() -> new RuntimeException("Adhérent introuvable"));
    
        if (adherent.getDateFinPenalite() != null && adherent.getDateFinPenalite().isAfter(LocalDate.now())) {
            throw new IllegalStateException("Adhérent sous pénalité jusqu’au " + adherent.getDateFinPenalite());
        }
    
        boolean aPretNonRenduEnRetard = pretRepository.existsByAdherent_IdAndRenduFalseAndDateRetourBefore(idAdherent,LocalDate.now());
        if (aPretNonRenduEnRetard) {
            throw new IllegalStateException("Adhérent a un prêt en retard non encore rendu");
        }
    } 
}