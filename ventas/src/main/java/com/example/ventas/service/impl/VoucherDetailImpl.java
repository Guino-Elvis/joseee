package com.example.ventas.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ventas.entity.VoucherDetail;
import com.example.ventas.entity.Voucher;

import com.example.ventas.repository.VoucherDetailRepository;
import com.example.ventas.service.VoucherDetailService;

import jakarta.persistence.EntityNotFoundException;

@Service
public class VoucherDetailImpl implements VoucherDetailService {

    @Autowired
    private VoucherServiceImpl voucherService;

    @Autowired
    private VoucherDetailRepository voucherDetailRepository;

    @Override
    public List<VoucherDetail> listar() {
        return voucherDetailRepository.findAll();
    }

    @Override
    public VoucherDetail guardar(VoucherDetail voucherDetail) {
        return voucherDetailRepository.save(voucherDetail);
    }

    @Override
    public VoucherDetail actualizar(VoucherDetail voucherDetail) {

        VoucherDetail voucherDetailExistente = voucherDetailRepository.findById(voucherDetail.getId())
                .orElseThrow(() -> new EntityNotFoundException("VoucherDetail no encontrado"));
        // Solo actualiza los campos que deseas cambiar
        voucherDetailExistente.setCantidad(voucherDetail.getCantidad());
        voucherDetailExistente.setDescripcion(voucherDetail.getDescripcion());
        voucherDetailExistente.setPunitario(voucherDetail.getPunitario());
        voucherDetailExistente.setImporte(voucherDetail.getImporte());
        voucherDetailExistente.setVoucher(voucherDetail.getVoucher());
        // Guarda los cambios
        return voucherDetailRepository.save(voucherDetailExistente);
    }

    @Override
    public Optional<VoucherDetail> listarPorId(Integer id) {
        VoucherDetail voucherDetail = voucherDetailRepository.findById(id).orElse(null);
        if (voucherDetail != null) {
            System.out.println("Antes de la petición");
            Optional<Voucher> voucherOptional = voucherService
                    .listarPorId(voucherDetail.getVoucher().getId());
            if (voucherOptional.isPresent()) {
                Voucher voucher = voucherOptional.get();
                voucherDetail.setVoucher(voucher);
            }
        }

        return Optional.ofNullable(voucherDetail);
    }

    @Override
    public void eliminarPorId(Integer id) {
        voucherDetailRepository.deleteById(id);
    }

    @Override
    public List<VoucherDetail> listarPorVoucher(Integer idVoucher) {
        return voucherDetailRepository.findByVoucherId(idVoucher);
    }

}
