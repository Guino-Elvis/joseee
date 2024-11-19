package com.example.ventas.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.ventas.entity.Entrega;

public interface EntregaRepository extends JpaRepository<Entrega, Integer> {
//   Optional<AuthUser> listarPorId(Integer id);
}
