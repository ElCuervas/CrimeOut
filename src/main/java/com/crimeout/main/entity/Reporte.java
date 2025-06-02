package com.crimeout.main.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Entidad que representa un reporte realizado por un usuario.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reporte")
public class Reporte {

    /**
     * Identificador único del reporte.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reporte")
    private Integer idReporte;

    /**
     * Tipo de reporte realizado.
     */
    @Enumerated(EnumType.STRING)
    @JoinColumn(name = "id_tipo_reporte", nullable = false)
    private TipoReporte tipoReporte;

    /**
     * Usuario que realizó el reporte.
     */
    @ManyToOne()
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    /**
     * Ubicación del reporte (almacenada como texto).
     */
    @Column(name = "ubicacion", columnDefinition = "TEXT")
    private String ubicacion;

    /**
     * Fecha y hora en que se realizó el reporte.
     */
    @Column(name = "fecha")
    private LocalDateTime fecha;

    /**
     * Imagen asociada al reporte.
     */
    @Column(name = "imagen",  columnDefinition = "TEXT")
    private String imagen;

    /**
     * Detalles adicionales del reporte.
     */
    @Column(name = "detalles", length = 250)
    private String detalles;

    /**
     * Indica si el reporte es considerado confiable.
     */
    @Column(name = "confiable", columnDefinition = "TINYINT(1)")
    private Boolean confiable;

    /**
     * Indica si el reporte ha sido solucionado.
     */
    @Column(name = "solucionado", columnDefinition = "TINYINT(1)")
    private Boolean solucionado;


}