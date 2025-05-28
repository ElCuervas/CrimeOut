package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReporteRequest {
    String tipoReporte;
    Integer usuarioId;
    String ubicacion;
    String imagen;
    String detalles;
}
