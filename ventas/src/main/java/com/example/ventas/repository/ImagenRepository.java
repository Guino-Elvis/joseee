package com.example.ventas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.ventas.entity.Imagen;

public interface ImagenRepository extends JpaRepository<Imagen, Integer> {
       List<Imagen> findByProductoId(Integer idProducto);
}
