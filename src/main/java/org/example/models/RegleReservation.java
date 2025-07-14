package org.example.models;

import javax.persistence.*;

@Entity
@Table(name = "reglereservation")
public class RegleReservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "type_adherent", referencedColumnName = "nom", nullable = false)
    private TypeAdherent typeAdherent;

    @Column(name = "quota_max", nullable = false)
    private Integer quotaMax;

    @Column(name = "duree_max_jours")
    private Integer dureeMaxJours;

    // Getters et Setters...
    public Integer getDureeMaxJours() {
        return dureeMaxJours;
    }

    public Integer getId() {
        return id;
    }

    public Integer getQuotaMax() {
        return quotaMax;
    }

    public TypeAdherent getTypeAdherent() {
        return typeAdherent;
    }

    public void setDureeMaxJours(Integer dureeMaxJours) {
        this.dureeMaxJours = dureeMaxJours;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setQuotaMax(Integer quotaMax) {
        this.quotaMax = quotaMax;
    }

    public void setTypeAdherent(TypeAdherent typeAdherent) {
        this.typeAdherent = typeAdherent;
    }
}
