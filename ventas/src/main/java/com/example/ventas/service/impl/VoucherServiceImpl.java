package com.example.ventas.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.ventas.entity.Cliente;
import com.example.ventas.entity.Voucher;
import com.example.ventas.repository.VoucherRepository;

import com.example.ventas.service.VoucherService;

import jakarta.persistence.EntityNotFoundException;

@Service
public class VoucherServiceImpl implements VoucherService {

    @Autowired
    private ClienteServiceImpl clienteService;

    @Autowired
    private VoucherRepository voucherRepository;

    @Override
    public List<Voucher> listar() {
        return voucherRepository.findAll();
    }

    @Override
    public List<Voucher> buscar(String numero, LocalDateTime createdAt, LocalDateTime updatedAt, String status) {
        return voucherRepository.buscarPorParametros(numero, createdAt, updatedAt, status);
    }

    @Override
    public Voucher guardar(Voucher Voucher) {
        return voucherRepository.save(Voucher);
    }


    @Override
    public Voucher actualizar(Voucher voucher) {
        // Primero, obtén la entidad existente desde la base de datos
        Voucher voucherExistente = voucherRepository.findById(voucher.getId())
                .orElseThrow(() -> new EntityNotFoundException("voucher no encontrada"));

        // Solo actualiza los campos que deseas cambiar
        voucherExistente.setTipo(voucher.getTipo());
        voucherExistente.setNumero(voucher.getNumero());
        voucherExistente.setFecha(voucher.getFecha());
        voucherExistente.setTotal(voucher.getTotal());
        voucherExistente.setStatus(voucher.getStatus());
        voucherExistente.setMetodo_pago(voucher.getMetodo_pago());
        voucherExistente.setCliente(voucher.getCliente());
        // No toques createdAt

        // Guarda los cambios
        return voucherRepository.save(voucherExistente);
    }

    @Override
    public Optional<Voucher> listarPorId(Integer id) {
        Voucher voucher = voucherRepository.findById(id).orElse(null);
        if (voucher != null) {
            System.out.println("Antes de la petición");
            Optional<Cliente> clienteOptional = clienteService
                    .listarPorId(voucher.getCliente().getId());
            if (clienteOptional.isPresent()) {
                Cliente cliente = clienteOptional.get();
                voucher.setCliente(cliente);
            }
        }

        return Optional.ofNullable(voucher);
    }

    @Override
    public void eliminarPorId(Integer id) {
        voucherRepository.deleteById(id);
    }

    @Override
    public List<Voucher> listarPorCliente(Integer idCliente) {
        // Obtener la lista de Productos por categoría directamente desde el
        // repositorio
        return voucherRepository.findByClienteId(idCliente);
    }
}
