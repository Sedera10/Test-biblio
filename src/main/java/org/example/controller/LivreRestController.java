package org.example.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.example.dto.ExemplaireDTO;
import org.example.dto.LivreDTO;
import org.example.models.Exemplaire;
import org.example.models.Livre;
import org.example.repository.ExemplaireRepository;
import org.example.repository.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class LivreRestController {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @GetMapping("/api/livres/{id}")
    @ResponseBody
    public LivreDTO getLivre(@PathVariable("id") Integer id) {
        Livre livre = livreRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Livre introuvable"));

        LivreDTO dto = new LivreDTO();
        dto.setId(livre.getId());
        dto.setTitre(livre.getTitre());
        dto.setAuteur(livre.getAuteur());
        dto.setEditeur(livre.getEditeur());
        dto.setIsbn(livre.getIsbn());
        dto.setLimiteAge(livre.getLimiteAge());
        dto.setPretDomicile(livre.isPretDomicile());

        LocalDate today = LocalDate.now();

        List<Exemplaire> disponiblesPret = exemplaireRepository.findDisponiblesSelonPret(id, today);
        List<Exemplaire> disponiblesReservation = exemplaireRepository.findDisponiblesSelonReservation(id, today);

        Set<Integer> idsDisponibles = disponiblesPret.stream()
            .map(Exemplaire::getId)
            .filter(idEx -> disponiblesReservation.stream().anyMatch(e -> e.getId().equals(idEx)))
            .collect(Collectors.toSet());

        List<ExemplaireDTO> exemplaireDTOs = livre.getExemplaires().stream().map(ex -> {
            ExemplaireDTO eDto = new ExemplaireDTO();
            eDto.setId(ex.getId());
            eDto.setEtat(ex.getEtat());
            eDto.setDisponible(idsDisponibles.contains(ex.getId()));
            return eDto;
        }).toList();

        dto.setExemplaires(exemplaireDTOs);
        return dto;
    }

}
