package org.example.dto;

import java.time.LocalDate;

public class DetailAdherentDTO {
    private Integer id;
    private String nom;
    private String email;
    private String typeAdherent;
    private Integer quotaMax;
    private long nombrePretEnCours;
    private long resteQuota;
    private boolean penalise;
    private LocalDate dateFinPenalite;
    private boolean isAbonne;

    // Constructeur 
    public DetailAdherentDTO(Integer id, String nom, String email, String typeAdherent,
                             Integer quotaMax, long nombrePretEnCours, long resteQuota,
                             boolean penalise, LocalDate dateFinPenalite, boolean isAbonne) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.typeAdherent = typeAdherent;
        this.quotaMax = quotaMax;
        this.nombrePretEnCours = nombrePretEnCours;
        this.resteQuota = resteQuota;
        this.penalise = penalise;
        this.dateFinPenalite = dateFinPenalite;
        this.isAbonne = isAbonne;
    }

    // Getters et Setters
    public LocalDate getDateFinPenalite() {
        return dateFinPenalite;
    }
    public String getEmail() {
        return email;
    }
    public Integer getId() {
        return id;
    }
    public String getNom() {
        return nom;
    }
    public long getNombrePretEnCours() {
        return nombrePretEnCours;
    }
    public Integer getQuotaMax() {
        return quotaMax;
    }
    public long getResteQuota() {
        return resteQuota;
    }
    public String getTypeAdherent() {
        return typeAdherent;
    }
    public boolean isPenalise() {
        return penalise;
    }
    public boolean isAbonne() {
        return isAbonne;
    }

    public void setAbonne(boolean isAbonne) {
        this.isAbonne = isAbonne;
    }
    
    public void setDateFinPenalite(LocalDate dateFinPenalite) {
        this.dateFinPenalite = dateFinPenalite;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public void setNombrePretEnCours(long nombrePretEnCours) {
        this.nombrePretEnCours = nombrePretEnCours;
    }
    public void setPenalise(boolean penalise) {
        this.penalise = penalise;
    }
    public void setQuotaMax(Integer quotaMax) {
        this.quotaMax = quotaMax;
    }
    public void setResteQuota(long resteQuota) {
        this.resteQuota = resteQuota;
    }
    public void setTypeAdherent(String typeAdherent) {
        this.typeAdherent = typeAdherent;
    }
    
}
