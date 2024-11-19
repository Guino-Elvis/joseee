package com.example.ventas.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ventas.entity.Empresa;

import java.util.List;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;

public interface EmpresaRepository extends JpaRepository<Empresa, Integer> {

        @Query("SELECT c FROM Empresa c WHERE "
                        + "(:ra_social IS NULL OR c.ra_social LIKE %:ra_social%) AND "
                        + "(:marca IS NULL OR c.marca = :marca) ")

        List<Empresa> buscarPorParametros(
                        @Param("ra_social") String ra_social,
                        @Param("marca") String marca);
}
