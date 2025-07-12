package org.example.repository;

import org.example.models.Livre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LivreRepository extends JpaRepository<Livre, Integer> {
    Livre findByIsbn(String isbn);
}

