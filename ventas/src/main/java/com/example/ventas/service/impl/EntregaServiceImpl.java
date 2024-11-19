package com.example.ventas.service.impl;


import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ventas.dto.AuthUser;
import com.example.ventas.entity.Entrega;
import com.example.ventas.feign.AuthUserFeign;
import com.example.ventas.repository.EntregaRepository;
import com.example.ventas.service.EntregaService;


@Service
public class EntregaServiceImpl implements EntregaService{
        @Autowired
    private EntregaRepository entregaRepository;

    @Autowired
    private AuthUserFeign authUserFeign;

    @Override
    public List<Entrega> listar() {
        return entregaRepository.findAll();
    }

    @Override
    public Entrega guardar(Entrega entrega) {
        return entregaRepository.save(entrega);
    }

    @Override
    public Entrega actualizar(Entrega entrega) {

        return entregaRepository.save(entrega);
    }

    @Override
    public Optional<Entrega> listarPorId(Integer id) {

        Entrega entrega = entregaRepository.findById(id).get();

        if(entrega!=null){

          AuthUser usuario = authUserFeign.listById(entrega.getAuthUserId()).getBody();
          
          System.out.println(usuario.toString());
          System.out.println(usuario.getName());
          entrega.setAuthUser(usuario);
        }
        return entregaRepository.findById(id);
    }

    @Override
    public void eliminarPorId(Integer id) {
        entregaRepository.deleteById(id);
    }
}
