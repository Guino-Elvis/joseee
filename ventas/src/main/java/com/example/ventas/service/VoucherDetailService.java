package com.example.ventas.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.example.ventas.entity.VoucherDetail;



public interface VoucherDetailService {
    
    public List<VoucherDetail> listar();

    public VoucherDetail guardar(VoucherDetail voucherDetail);

    public VoucherDetail actualizar(VoucherDetail voucherDetail);

    public Optional<VoucherDetail> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    // Otros métodos existentes
    List<VoucherDetail> listarPorVoucher(Integer idVoucher);

  
}
