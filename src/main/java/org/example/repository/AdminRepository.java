package org.example.repository;

import org.example.models.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {
    Admin findByEmailAndMotDePasse(String email, String motDePasse);
}
