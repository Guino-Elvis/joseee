package com.example.ventas.controller;


import com.example.ventas.entity.VoucherDetail;
import com.example.ventas.service.VoucherDetailService;
import java.util.List;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/voucher_detalle")
public class VoucherDetailController {
    @Autowired
    private VoucherDetailService voucherdetailService;


    @GetMapping("/voucherdetailPorVoucher/{idVoucher}")
    public ResponseEntity<List<VoucherDetail>> listarVoucherDetailsPorVoucher(@PathVariable Integer idVoucher) {
        List<VoucherDetail> voucherdetails = voucherdetailService.listarPorVoucher(idVoucher);
        return ResponseEntity.ok(voucherdetails);
    }

    @GetMapping()
    public ResponseEntity<List<VoucherDetail>> list() {
        return ResponseEntity.ok().body(voucherdetailService.listar());
    }


    @PostMapping()
    public ResponseEntity<VoucherDetail> save(@RequestBody VoucherDetail voucherdetail) {
        return ResponseEntity.ok(voucherdetailService.guardar(voucherdetail));
    }

    @PutMapping()
    public ResponseEntity<VoucherDetail> update(@RequestBody VoucherDetail voucherdetail) {
        return ResponseEntity.ok(voucherdetailService.actualizar(voucherdetail));
    }

    @GetMapping("/{id}")
    public ResponseEntity<VoucherDetail> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(voucherdetailService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        voucherdetailService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }

 
}
