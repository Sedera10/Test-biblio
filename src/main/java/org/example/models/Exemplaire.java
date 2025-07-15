package org.example.models;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Set;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_exemplaire")
    private Integer id;

    @Column(length = 50)
    private String etat;

    @Column(nullable = false)
    private boolean disponible = true;

    // Relation Exemplaire → Livre (plusieurs exemplaires pour un livre)
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;

    // Relation Exemplaire → Prêt (un exemplaire peut être prêté plusieurs fois)
    @OneToMany(mappedBy = "exemplaire", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private Set<Pret> prets;

    // === Constructeurs ===

    public Exemplaire() {}

    public Exemplaire(String etat, boolean disponible, Livre livre) {
        this.etat = etat;
        this.disponible = disponible;
        this.livre = livre;
    }

    // === Getters et Setters ===

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public Set<Pret> getPrets() {
        return prets;
    }

    public void setPrets(Set<Pret> prets) {
        this.prets = prets;
    }
}
