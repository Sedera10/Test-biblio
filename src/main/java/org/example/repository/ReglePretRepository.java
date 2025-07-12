package org.example.repository;

import org.example.models.ReglePret;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface ReglePretRepository extends JpaRepository<ReglePret, Integer> {
    ReglePret findByTypeAdherentAndTypePret(String typeAdherent, String typePret);

    @Query("SELECT r FROM ReglePret r WHERE LOWER(r.typeAdherent) = LOWER(:typeAdherent) AND LOWER(r.typePret) = LOWER(:typePret)")
    ReglePret findRegle(@Param("typeAdherent") String typeAdherent, @Param("typePret") String typePret);

}
