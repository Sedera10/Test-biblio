package org.example.repository;

import org.example.models.TypeAdherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeAdherentRepository extends JpaRepository<TypeAdherent, String> {
    
}