package com.example.ventas.controller;

import com.example.ventas.entity.Empresa;
import com.example.ventas.service.EmpresaService;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/empresa")

public class EmpresaController {

    @Autowired
    private EmpresaService empresaService;

    @GetMapping()
    public ResponseEntity<List<Empresa>> list() {
        return ResponseEntity.ok().body(empresaService.listar());
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Empresa>> buscar(
            @RequestParam(required = false) String ra_social,
            @RequestParam(required = false) String marca) {
        List<Empresa> empresas = empresaService.buscar(ra_social, marca);
        return ResponseEntity.ok().body(empresas);
    }

    @PostMapping()
    public ResponseEntity<Empresa> save(@RequestBody Empresa empresa) {
        return ResponseEntity.ok(empresaService.guardar(empresa));
    }

    @PutMapping()
    public ResponseEntity<Empresa> update(@RequestBody Empresa empresa) {
        return ResponseEntity.ok(empresaService.actualizar(empresa));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Empresa> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(empresaService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        empresaService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
