package org.example.dto;

public class ExemplaireDTO {
    private Integer id;
    private String etat;
    private boolean disponible;

    // Getters et Setters
    public String getEtat() {
        return etat;
    }
    public Integer getId() {
        return id;
    }
    public boolean isDisponible() {
        return disponible;
    }
    
    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
    public void setEtat(String etat) {
        this.etat = etat;
    }
    public void setId(Integer id) {
        this.id = id;
    }
}
