package com.example.ventas.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;


import com.example.ventas.entity.Cliente;

import java.util.List;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;

public interface ClienteRepository extends JpaRepository<Cliente, Integer>
{
    
    @Query("SELECT c FROM Cliente c WHERE "
            + "(:name IS NULL OR c.name LIKE %:name%) AND "
            + "(:tdocumento IS NULL OR c.tdocumento = :tdocumento) AND "
            + "(:createdAt IS NULL OR c.createdAt >= :createdAt) AND "
            + "(:updatedAt IS NULL OR c.updatedAt <= :updatedAt)")

    List<Cliente> buscarPorParametros(
            @Param("name") String name,
            @Param("createdAt") LocalDateTime createdAt,
            @Param("updatedAt") LocalDateTime updatedAt,
            @Param("tdocumento") String tdocumento);
}
