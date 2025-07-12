package org.example.repository;

import org.example.models.JourFerie;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface JourFerieRepository extends JpaRepository<JourFerie, Long> {
    boolean existsByDate(LocalDate date);
    List<JourFerie> findAllByOrderByDateAsc();
}