package com.example.ventas.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.example.ventas.entity.Empresa;

public interface EmpresaService {

    public List<Empresa> listar();

    public Empresa guardar(Empresa empresa);

    public Empresa actualizar(Empresa empresa);

    public Optional<Empresa> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    List<Empresa> buscar(String ra_social, String marca);
}
