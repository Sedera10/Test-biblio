package org.example.models;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "typepret")
public class TypePret {

    @Id
    @Column(length = 50)
    private String type;

    @OneToMany(mappedBy = "typePret", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ReglePret> reglePrets;

    @OneToMany(mappedBy = "typePret", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Pret> prets;

    // Constructors
    public TypePret() {}

    public TypePret(String type) {
        this.type = type;
    }

    // Getters & Setters
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    public Set<ReglePret> getReglePrets() {
        return reglePrets;
    }
    public void setReglePrets(Set<ReglePret> reglePrets) {
        this.reglePrets = reglePrets;
    }

    public Set<Pret> getPrets() {
        return prets;
    }
    public void setPrets(Set<Pret> prets) {
        this.prets = prets;
    }
}
