package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * DTO para la respuesta de ubicación de un reporte.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ListReporteResponse {
    private Integer idReporte;
    /**
     * Tipo de reporte.
     */
    private String tipoReporte;

    /**
     * Ubicación del reporte (latitud y longitud).
     */
    private List<Double> ubicacion;

    /**
     * Fecha y hora en que se realizó el reporte.
     */
    private LocalDateTime fecha;

    /**
     * Imagen asociada al reporte.
     */
    private String imagen;

    /**
     * Detalles adicionales del reporte.
     */
    private String detalles;

    /**
     * Indica si el reporte es considerado confiable.
     */
    private Boolean confiable;

    /**
     * Indica si el reporte ha sido solucionado.
     */
    private Boolean solucionado;
}