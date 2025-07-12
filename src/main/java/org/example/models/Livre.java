package org.example.models;

import javax.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "livre")
public class Livre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_livre")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String titre;

    @Column(length = 100)
    private String auteur;

    @Column(length = 100)
    private String editeur;

    @Column(length = 20, unique = true)
    private String isbn;

    @Column(name = "limite_age")
    private Integer limiteAge = 0;

    @Column(name = "pret_domicile")
    private boolean pretDomicile = true;

    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Exemplaire> exemplaires = new HashSet<>();

    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Reservation> reservations;

    // === Constructeurs ===

    public Livre() {}

    public Livre(String titre, String auteur, String editeur, String isbn, Integer limiteAge, boolean pretDomicile) {
        this.titre = titre;
        this.auteur = auteur;
        this.editeur = editeur;
        this.isbn = isbn;
        this.limiteAge = limiteAge;
        this.pretDomicile = pretDomicile;
    }

    // === Getters et Setters ===

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public String getEditeur() {
        return editeur;
    }

    public void setEditeur(String editeur) {
        this.editeur = editeur;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Integer getLimiteAge() {
        return limiteAge;
    }

    public void setLimiteAge(Integer limiteAge) {
        this.limiteAge = limiteAge;
    }

    public boolean isPretDomicile() {
        return pretDomicile;
    }

    public void setPretDomicile(boolean pretDomicile) {
        this.pretDomicile = pretDomicile;
    }

    public Set<Exemplaire> getExemplaires() {
        return exemplaires;
    }

    public void setExemplaires(Set<Exemplaire> exemplaires) {
        this.exemplaires = exemplaires;
    }

    public Set<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(Set<Reservation> reservations) {
        this.reservations = reservations;
    }
}
