package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EstadoReporteDto {
    /**
     * Indica si el reporte es confiable.
     */
    private Boolean confiable;

    /**
     * Indica si el reporte ha sido solucionado.
     */
    private Boolean solucionado;
}
