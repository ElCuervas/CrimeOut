package com.crimeout.main.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reporte")
public class Reporte {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reporte")
    private Integer idReporte;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_tipo_reporte", nullable = false)
    private TipoReporte tipoReporte;

    @ManyToOne()
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @Column(name = "ubicacion", length = 100)
    private String ubicacion;

    @Column(name = "fecha")
    private LocalDateTime fecha;

    @Lob
    @Column(name = "imagen")
    private byte[] imagen;

    @Column(name = "detalles", length = 250)
    private String detalles;

    @Column(name = "confiable", columnDefinition = "TINYINT(1)")
    private Boolean confiable;

    @Column(name = "solucionado", columnDefinition = "TINYINT(1)")
    private Boolean solucionado;
}