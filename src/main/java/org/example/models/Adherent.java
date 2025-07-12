package org.example.models;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Table(name = "adherent")
public class Adherent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_adherent")
    private Integer id;

    @Column(length = 100)
    private String nom;

    @Column(length = 100, unique = true)
    private String email;

    @Column(nullable = false)
    private String motDePasse;

    @ManyToOne
    @JoinColumn(name = "type_adherent", referencedColumnName = "nom", nullable = false)
    private TypeAdherent typeAdherent;

    @Column
    private LocalDate inscription;

    @Column(nullable = false)
    private Double penalites = 0.0;

    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Pret> prets;

    @Column(name = "date_fin_penalite")
    private LocalDate dateFinPenalite;

    // Constructors
    public Adherent() {}

    public Adherent(String nom, String email, String mdp, TypeAdherent typeAdherent, LocalDate inscription) {
        this.nom = nom;
        this.email = email; 
        this.motDePasse = mdp;
        this.typeAdherent = typeAdherent;
        this.inscription = inscription;
    }

    // Getters & Setters
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getMotDePasse() {
        return motDePasse;
    }
    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public TypeAdherent getTypeAdherent() {
        return typeAdherent;
    }
    public void setTypeAdherent(TypeAdherent typeAdherent) {
        this.typeAdherent = typeAdherent;
    }

    public LocalDate getInscription() {
        return inscription;
    }
    public void setInscription(LocalDate inscription) {
        this.inscription = inscription;
    }

    public Double getPenalites() {
        return penalites;
    }
    public void setPenalites(Double penalites) {
        this.penalites = penalites;
    }

    public Set<Pret> getPrets() {
        return prets;
    }
    public void setPrets(Set<Pret> prets) {
        this.prets = prets;
    }

    public LocalDate getDateFinPenalite() {
        return dateFinPenalite;
    }

    public void setDateFinPenalite(LocalDate dateFinPenalite) {
        this.dateFinPenalite = dateFinPenalite;
    }
}
