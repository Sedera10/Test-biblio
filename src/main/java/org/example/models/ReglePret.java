package org.example.models;

import javax.persistence.*;

@Entity
public class ReglePret {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Ces deux attributs correspondent aux colonnes de type VARCHAR dans ta base
    @Column(name = "type_adherent")
    private String typeAdherent;

    @Column(name = "type_pret")
    private String typePret;

    @Column(name = "duree_jours")
    private int dureeJours;

    public ReglePret(){}

    public ReglePret(String typeAdherent , String typePret, int dureeJours){
        this.typeAdherent = typeAdherent;
        this.typePret = typePret;
        this.dureeJours = dureeJours;
    }
    // === Getters et Setters ===

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTypeAdherent() {
        return typeAdherent;
    }

    public void setTypeAdherent(String typeAdherent) {
        this.typeAdherent = typeAdherent;
    }

    public String getTypePret() {
        return typePret;
    }

    public void setTypePret(String typePret) {
        this.typePret = typePret;
    }

    public int getDureeJours() {
        return dureeJours;
    }

    public void setDureeJours(int dureeJours) {
        this.dureeJours = dureeJours;
    }
}
