package com.example.ventas.service;

import java.util.List;
import java.util.Optional;

import com.example.ventas.entity.Imagen;


public interface ImagenService {
    
    public List<Imagen> listar();

    public Imagen guardar(Imagen imagen);

    public Imagen actualizar(Imagen imagen);

    public Optional<Imagen> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    // Otros métodos existentes
    List<Imagen> listarPorProducto(Integer idProducto);
}
