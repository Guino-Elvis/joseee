package com.example.ventas.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.example.ventas.entity.Cliente;

public interface ClienteService {

    public List<Cliente> listar();

    public Cliente guardar(Cliente cliente);

    public Cliente actualizar(Cliente cliente);

    public Optional<Cliente> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    List<Cliente> buscar(String name, LocalDateTime createdAt, LocalDateTime updatedAt, String tdocumento);
    
}
