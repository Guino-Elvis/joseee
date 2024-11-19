package com.example.ventas.entity;
import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Imagen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String url;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "producto_id", nullable = true, foreignKey = @ForeignKey(name = "fk_producto_imagen", value = ConstraintMode.CONSTRAINT))
    @JsonBackReference  // Marca el lado "secundario" de la relación
    private Producto producto;

    

}
