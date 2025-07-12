package org.example.models;

import javax.persistence.*;

@Entity
@Table(name = "reglereport")
public class RegleReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String choix; // "avant" ou "apres"

    // Getters & Setters
    public String getChoix() {
        return choix;
    }
    public Long getId() {
        return id;
    }

    public void setChoix(String choix) {
        this.choix = choix;
    }
    public void setId(Long id) {
        this.id = id;
    }
}