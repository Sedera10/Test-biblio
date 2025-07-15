package org.example.dto;

import java.util.List;

public class LivreDTO {
    private Integer id;
    private String titre;
    private String auteur;
    private String editeur;
    private String isbn;
    private Integer limiteAge;
    private boolean pretDomicile;
    private List<ExemplaireDTO> exemplaires;

    // Getters et Setters
    public String getAuteur() {
        return auteur;
    }
    public String getEditeur() {
        return editeur;
    }
    public List<ExemplaireDTO> getExemplaires() {
        return exemplaires;
    }
    public Integer getId() {
        return id;
    }
    public String getIsbn() {
        return isbn;
    }
    public Integer getLimiteAge() {
        return limiteAge;
    }
    public String getTitre() {
        return titre;
    }
    public boolean isPretDomicile() {
        return pretDomicile;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }
    public void setEditeur(String editeur) {
        this.editeur = editeur;
    }
    public void setExemplaires(List<ExemplaireDTO> exemplaires) {
        this.exemplaires = exemplaires;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    public void setLimiteAge(Integer limiteAge) {
        this.limiteAge = limiteAge;
    }
    public void setPretDomicile(boolean pretDomicile) {
        this.pretDomicile = pretDomicile;
    }
    public void setTitre(String titre) {
        this.titre = titre;
    }
    
}
