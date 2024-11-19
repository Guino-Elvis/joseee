package com.example.ventas.entity;


import com.example.ventas.dto.AuthUser;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Entrega {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String departamento;
    private String provincia;
    private String distrito;
    private String referencia;
    
    private Integer authUserId;
    @Transient
    private AuthUser authUser;
}
