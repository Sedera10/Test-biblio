package org.example.repository;

import org.example.models.RegleReport;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface RegleReportRepository extends JpaRepository<RegleReport, Long> {
    Optional<RegleReport> findTopByOrderByIdDesc(); // Dernière règle définie
}