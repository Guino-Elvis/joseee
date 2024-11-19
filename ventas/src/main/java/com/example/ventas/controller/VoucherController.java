package com.example.ventas.controller;

import com.example.ventas.entity.Voucher;
import com.example.ventas.service.VoucherService;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/voucher")
public class VoucherController {
    @Autowired
    private VoucherService voucherService;

    @GetMapping("/voucherPorCliente/{idCliente}")
    public ResponseEntity<List<Voucher>> listarVouchersPorCliente(@PathVariable Integer idCliente) {
        List<Voucher> vouchers = voucherService.listarPorCliente(idCliente);
        return ResponseEntity.ok(vouchers);
    }

    @GetMapping()
    public ResponseEntity<List<Voucher>> list() {
        return ResponseEntity.ok().body(voucherService.listar());
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Voucher>> buscar(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) LocalDateTime createdAt,
            @RequestParam(required = false) LocalDateTime updatedAt,
            @RequestParam(required = false) String tdocumento) {

        List<Voucher> vouchers = voucherService.buscar(name, createdAt, updatedAt, tdocumento);
        return ResponseEntity.ok().body(vouchers);
    }

    @PostMapping()
    public ResponseEntity<Voucher> save(@RequestBody Voucher voucher) {
        return ResponseEntity.ok(voucherService.guardar(voucher));
    }

    @PutMapping()
    public ResponseEntity<Voucher> update(@RequestBody Voucher voucher) {
        return ResponseEntity.ok(voucherService.actualizar(voucher));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Voucher> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(voucherService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        voucherService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }

}
