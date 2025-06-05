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

    /**
     * Tipo de reporte.
     */
    String tipoReporte;

    /**
     * Ubicación del reporte (latitud y longitud).
     */
    List<Double> ubicacion;

    /**
     * Fecha y hora en que se realizó el reporte.
     */
    LocalDateTime fecha;

    /**
     * Imagen asociada al reporte.
     */
    String imagen;

    /**
     * Detalles adicionales del reporte.
     */
    String detalles;

    /**
     * Indica si el reporte es considerado confiable.
     */
    Boolean confiable;

    /**
     * Indica si el reporte ha sido solucionado.
     */
    Boolean solucionado;
}