package org.example.models;

import java.time.LocalDate;

import javax.persistence.*;

@Entity
@Table(name = "rendu")
public class Rendu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_rendu")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;

    @Column(name = "date_rendu", nullable = false)
    private LocalDate dateRendu;

    // getters & setters
    public LocalDate getDateRendu() {
        return dateRendu;
    }
    public Integer getId() {
        return id;
    }
    public Pret getPret() {
        return pret;
    }
    
    public void setDateRendu(LocalDate dateRendu) {
        this.dateRendu = dateRendu;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public void setPret(Pret pret) {
        this.pret = pret;
    }
}
