package org.example.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.example.models.RegleReport;
import org.example.repository.JourFerieRepository;
import org.example.repository.RegleReportRepository;

@Service
public class CalendrierService {

    @Autowired private JourFerieRepository jourFerieRepository;
    @Autowired private RegleReportRepository regleReportRepository;

    public boolean estJourFerieOuWeekend(LocalDate date) {
        return jourFerieRepository.existsByDate(date) || date.getDayOfWeek() == DayOfWeek.SUNDAY;
    }

    public LocalDate ajusterDate(LocalDate date) {
        Optional<RegleReport> regleOpt = regleReportRepository.findTopByOrderByIdDesc();
        String choix = regleOpt.map(RegleReport::getChoix).orElse("apres");

        while (estJourFerieOuWeekend(date)) {
            date = choix.equals("avant") ? date.minusDays(1) : date.plusDays(1);
        }
        return date;
    }
}