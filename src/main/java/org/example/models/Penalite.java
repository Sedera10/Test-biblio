package org.example.models;

import javax.persistence.*;

@Entity
@Table(name = "penalite")
public class Penalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPenalite;

    @ManyToOne
    @JoinColumn(name = "id_pret")
    private Pret pret;

    private String motif;

    private boolean applique;
    // getters/setters

    public Integer getIdPenalite() {
        return idPenalite;
    }

    public String getMotif() {
        return motif;
    }

    public Pret getPret() {
        return pret;
    }

    public void setApplique(boolean applique) {
        this.applique = applique;
    }

    public void setIdPenalite(Integer idPenalite) {
        this.idPenalite = idPenalite;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }
}
