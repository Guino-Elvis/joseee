package com.example.ventas.entity;


import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Empresa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String ra_social;
    private String marca;
    private String numero;
    private String foto;
}
