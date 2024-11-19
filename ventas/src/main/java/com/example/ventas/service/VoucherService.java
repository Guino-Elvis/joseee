package com.example.ventas.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.example.ventas.entity.Voucher;

public interface VoucherService {

    public List<Voucher> listar();

    public Voucher guardar(Voucher voucher);

    public Voucher actualizar(Voucher voucher);

    public Optional<Voucher> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    // Otros métodos existentes
    List<Voucher> listarPorCliente(Integer idCliente);

    List<Voucher> buscar(String numero, LocalDateTime createdAt, LocalDateTime updatedAt, String status);
}
