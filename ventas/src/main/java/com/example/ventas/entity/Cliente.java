package com.example.ventas.entity;


import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Data;

@Entity
@Data

public class Cliente {
      @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String email;
    private String phone;
    private String name;
    private String paterno;
    private String materno;
    private String tdocumento;
    private String direccion;
    private String postal;
    private String tdatos;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    private void prePersist() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    private void preUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
