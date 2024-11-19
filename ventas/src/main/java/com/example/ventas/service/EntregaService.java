package com.example.ventas.service;


import java.util.List;
import java.util.Optional;
import com.example.ventas.entity.Entrega;


public interface EntregaService {
    
    public List<Entrega> listar();

    public Entrega guardar(Entrega entrega);

    public Entrega actualizar(Entrega entrega);

    public Optional<Entrega> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

}
