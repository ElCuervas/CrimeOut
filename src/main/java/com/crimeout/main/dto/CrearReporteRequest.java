package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * DTO para la solicitud de creación de un reporte.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CrearReporteRequest {

    /**
     * Tipo de reporte a crear.
     */
    String tipoReporte;

    /**
     * Ubicación del reporte (latitud y longitud).
     */
    List<Double> ubicacion;

    /**
     * Imagen asociada al reporte.
     */
    String imagen;

    /**
     * Detalles adicionales del reporte.
     */
    String detalles;
}