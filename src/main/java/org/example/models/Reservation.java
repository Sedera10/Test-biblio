package org.example.models;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reservation")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;

    @ManyToOne
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;

    @ManyToOne
    @JoinColumn(name = "type_pret", nullable = false)
    private TypePret typePret;

    @Column(name = "date_reservation", nullable = false)
    private LocalDate dateReservation;

    @Column(name = "date_fin_reservation")
    private LocalDate dateFinReservation;

    // === Constructeurs ===

    public Reservation() {}

    public Reservation(Adherent adherent, Livre livre, TypePret typePret, LocalDate dateReservation, LocalDate dateFinReservation) {
        this.adherent = adherent;
        this.livre = livre;
        this.typePret = typePret;
        this.dateReservation = dateReservation;
        this.dateFinReservation = dateFinReservation;
    }

    // === Getters et Setters ===

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Adherent getAdherent() {
        return adherent;
    }

    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public TypePret getTypePret() {
        return typePret;
    }

    public void setTypePret(TypePret typePret) {
        this.typePret = typePret;
    }

    public LocalDate getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(LocalDate dateReservation) {
        this.dateReservation = dateReservation;
    }

    public LocalDate getDateFinReservation() {
        return dateFinReservation;
    }

    public void setDateFinReservation(LocalDate dateFinReservation) {
        this.dateFinReservation = dateFinReservation;
    }
}
