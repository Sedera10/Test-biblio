package org.example.service;

import org.example.models.Exemplaire;
import org.example.models.Livre;
import org.example.repository.LivreRepository;
import org.example.repository.ExemplaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LivreService {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public List<Livre> getAll() {
        return livreRepository.findAll();
    }

    public List<Exemplaire> getAllExemplaires(Integer id) {
        return exemplaireRepository.findByLivre_Id(id);
    }

    public List<Exemplaire> getExemplairesDispo() {
        return exemplaireRepository.findByDisponibleTrue();
    }

    public Livre getById(int id) {
        return livreRepository.findById(id).orElse(null);
    }

    public void saveOrUpdate(Livre livre) {
        livreRepository.save(livre);
    }

    public void delete(int id) {
        livreRepository.deleteById(id);
    }

    public Livre findByIsbn(String isbn) {
        return livreRepository.findByIsbn(isbn);
    }
}
