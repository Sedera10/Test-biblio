package org.example.models;

import java.time.LocalDate;
import javax.persistence.*;

@Entity
@Table(name = "jourferie")
public class JourFerie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private LocalDate date;

    private String description;

    // Getters & Setters

    public LocalDate getDate() {
        return date;
    }
    public String getDescription() {
        return description;
    }
    public Long getId() {
        return id;
    }
    public void setDate(LocalDate date) {
        this.date = date;
    }
    public void setDescription(String description) {
        this.description = description;
    }

}