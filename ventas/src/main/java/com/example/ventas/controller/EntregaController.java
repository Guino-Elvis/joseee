package com.example.ventas.controller;

import com.example.ventas.entity.Entrega;
import com.example.ventas.service.EntregaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/entrega")
public class EntregaController {
     @Autowired
    private EntregaService entregaService;

   @GetMapping()
    public ResponseEntity<List<Entrega>> list() {
        return ResponseEntity.ok().body(entregaService.listar());
    }

    @PostMapping()
    public ResponseEntity<Entrega> save(@RequestBody Entrega entrega) {
        return ResponseEntity.ok(entregaService.guardar(entrega));
    }

    @PutMapping()
    public ResponseEntity<Entrega> update(@RequestBody Entrega entrega) {
        return ResponseEntity.ok(entregaService.actualizar(entrega));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Entrega> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(entregaService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        entregaService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
