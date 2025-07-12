package org.example.models;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "typeadherent")
public class TypeAdherent {

    @Id
    @Column(length = 50)
    private String nom;

    @Column(name = "quota_max")
    private Integer quotaMax;

    @OneToMany(mappedBy = "typeAdherent", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Adherent> adherents;

    @OneToMany(mappedBy = "typeAdherent", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ReglePret> reglePrets;

    @Column(name = "jours_penalite")
    private Integer joursPenalite;

    // === Constructeurs ===
    public TypeAdherent() {}

    public TypeAdherent(String nom, Integer quotaMax) {
        this.nom = nom;
        this.quotaMax = quotaMax;
    }

    // === Getters & Setters ===
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getQuotaMax() {
        return quotaMax;
    }

    public void setQuotaMax(Integer quotaMax) {
        this.quotaMax = quotaMax;
    }

    public Set<Adherent> getAdherents() {
        return adherents;
    }

    public void setAdherents(Set<Adherent> adherents) {
        this.adherents = adherents;
    }

    public Set<ReglePret> getReglePrets() {
        return reglePrets;
    }

    public void setReglePrets(Set<ReglePret> reglePrets) {
        this.reglePrets = reglePrets;
    }

    public Integer getJoursPenalite() {
        return joursPenalite;
    }

    public void setJoursPenalite(Integer joursPenalite) {
        this.joursPenalite = joursPenalite;
    }
}
