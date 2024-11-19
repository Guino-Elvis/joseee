package com.example.ventas.controller;

import java.util.List;
import org.springframework.web.bind.annotation.*;

import com.example.ventas.entity.Imagen;
import com.example.ventas.service.ImagenService;
import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/imagen")
public class ImagenController {

    @Autowired
    private ImagenService imagenService;

    @GetMapping("/imagenProducto/{idProducto}")
    public ResponseEntity<List<Imagen>> listarImagenPorProducto(@PathVariable Integer idProducto) {
        List<Imagen> imagen = imagenService.listarPorProducto(idProducto);
        return ResponseEntity.ok(imagen);
    }

    @GetMapping()
    public ResponseEntity<List<Imagen>> list() {
        return ResponseEntity.ok().body(imagenService.listar());
    }

    @PostMapping()
    public ResponseEntity<Imagen> save(@RequestBody Imagen imagen) {
        return ResponseEntity.ok(imagenService.guardar(imagen));
    }

    @PutMapping()
    public ResponseEntity<Imagen> update(@RequestBody Imagen imagen) {
        return ResponseEntity.ok(imagenService.actualizar(imagen));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Imagen> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(imagenService.listarPorId(id).get());
    }

    @DeleteMapping("eliminar/{id}")
    public ResponseEntity<String> deleteById(@PathVariable(required = true) Integer id) {
        try {
            imagenService.eliminarPorId(id);
            return ResponseEntity.ok("Eliminación correcta de la imagen");
        } catch (EmptyResultDataAccessException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Imagen no encontrada");
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("No se puede eliminar la imagen debido a restricciones de integridad referencial");
        }
    }
}
