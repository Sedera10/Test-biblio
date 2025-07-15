package org.example.controller;

import org.example.dto.DetailAdherentDTO;
import org.example.models.Adherent;
import org.example.repository.AdherentRepository;
import org.example.service.AdherentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/adherents")
public class DetailAdherentController {

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private AdherentService adherentService;

    @GetMapping("/{id}")
    public ResponseEntity<DetailAdherentDTO> getDetails(@PathVariable("id") Integer id) {
        Adherent adherent = adherentRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Adhérent non trouvé"));

        DetailAdherentDTO dto = adherentService.buildDetail(adherent);
        return ResponseEntity.ok(dto);
    }
}

