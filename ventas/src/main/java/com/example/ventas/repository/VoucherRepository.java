package com.example.ventas.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.example.ventas.entity.Voucher;

public interface VoucherRepository extends JpaRepository< Voucher,Integer >{

    List<Voucher> findByClienteId(Integer idCliente);

    @Query("SELECT c FROM Voucher c WHERE "
            + "(:numero IS NULL OR c.numero LIKE %:numero%) AND "
            + "(:status IS NULL OR c.status = :status) AND "
            + "(:createdAt IS NULL OR c.createdAt >= :createdAt) AND "
            + "(:updatedAt IS NULL OR c.updatedAt <= :updatedAt)")

    List<Voucher> buscarPorParametros(
            @Param("numero") String numero,
            @Param("createdAt") LocalDateTime createdAt,
            @Param("updatedAt") LocalDateTime updatedAt,
            @Param("status") String status);
    
} 