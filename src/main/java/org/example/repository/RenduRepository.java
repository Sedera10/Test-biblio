package org.example.repository;

import java.util.List;

import org.example.models.Rendu;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RenduRepository extends JpaRepository<Rendu, Integer> {
    List<Rendu> findByPret_Adherent_Id(int idAdherent);
}
