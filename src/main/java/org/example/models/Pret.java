package org.example.models;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "pret")
public class Pret {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pret")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire exemplaire;

    @ManyToOne
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;

    @Column(name = "date_debut", nullable = false)
    private LocalDate dateDebut;

    @Column(name = "date_retour")
    private LocalDate dateRetour;

    @ManyToOne
    @JoinColumn(name = "type_pret", referencedColumnName = "type")
    private TypePret typePret;

    @Column(name = "rendu")
    private boolean rendu = false;  // false par défaut

    // Constructors
    public Pret() {}

    public Pret(Exemplaire exemplaire, Adherent adherent, LocalDate dateDebut, TypePret typePret) {
        this.exemplaire = exemplaire;
        this.adherent = adherent;
        this.dateDebut = dateDebut;
        this.typePret = typePret;
    }

    // Getters & Setters
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public Exemplaire getExemplaire() {
        return exemplaire;
    }
    public void setExemplaire(Exemplaire exemplaire) {
        this.exemplaire = exemplaire;
    }

    public Adherent getAdherent() {
        return adherent;
    }
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }

    public LocalDate getDateDebut() {
        return dateDebut;
    }
    public void setDateDebut(LocalDate dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDate getDateRetour() {
        return dateRetour;
    }
    public void setDateRetour(LocalDate dateRetour) {
        this.dateRetour = dateRetour;
    }

    public TypePret getTypePret() {
        return typePret;
    }
    public void setTypePret(TypePret typePret) {
        this.typePret = typePret;
    }

    public boolean isRendu() {
        return rendu;
    }
    
    public void setRendu(boolean rendu) {
        this.rendu = rendu;
    }
    
}
