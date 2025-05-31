package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UbicacionReporteResponse {
    String tipoReporte;
    String ubicacion;
    LocalDateTime fecha;
    String imagen;
    String detalles;
    Boolean confiable;
    Boolean solucionado;
}
