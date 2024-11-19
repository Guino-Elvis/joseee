package com.example.ventas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


import com.example.ventas.entity.VoucherDetail;


public interface VoucherDetailRepository extends JpaRepository<VoucherDetail,Integer>{
    List<VoucherDetail> findByVoucherId(Integer idVoucher);
}
