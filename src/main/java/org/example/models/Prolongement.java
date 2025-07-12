package org.example.models;

import java.time.LocalDate;

import javax.persistence.*;

@Entity
@Table(name = "prolongement")
public class Prolongement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_prolongement")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;

    @Column(name = "ancienne_date", nullable = false)
    private LocalDate ancienneDate;

    @Column(name = "nouvelle_date", nullable = false)
    private LocalDate nouvelleDate;

    // Getters, Setters, Constructeurs
    public Prolongement() {}

    public Prolongement(Pret pret, LocalDate ancienneDate, LocalDate nouvelleDate) {
        this.pret = pret;
        this.ancienneDate = ancienneDate;
        this.nouvelleDate = nouvelleDate;
    }    

    public LocalDate getAncienneDate() {
        return ancienneDate;
    }
    public Integer getId() {
        return id;
    }
    public LocalDate getNouvelleDate() {
        return nouvelleDate;
    }
    public Pret getPret() {
        return pret;
    }

    public void setAncienneDate(LocalDate ancienneDate) {
        this.ancienneDate = ancienneDate;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public void setNouvelleDate(LocalDate nouvelleDate) {
        this.nouvelleDate = nouvelleDate;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }

}
