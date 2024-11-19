package com.example.ventas.service.impl;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ventas.entity.Empresa;
import com.example.ventas.repository.EmpresaRepository;
import com.example.ventas.service.EmpresaService;


@Service
public class EmpresaServiceImpl implements EmpresaService{
    
    @Autowired
    private EmpresaRepository empresaRepository;

    @Override
    public List<Empresa> buscar(String ra_social, String marca) {
        return empresaRepository.buscarPorParametros(ra_social,marca);
    }

    @Override
    public List<Empresa> listar() {
        return empresaRepository.findAll();
    }

    @Override
    public Empresa guardar(Empresa empresa) {
        return empresaRepository.save(empresa);
    }

    @Override
    public Empresa actualizar(Empresa empresa) {

        return empresaRepository.save(empresa);
    }

    @Override
    public Optional<Empresa> listarPorId(Integer id) {
        return empresaRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        empresaRepository.deleteById(id);
    }
}
