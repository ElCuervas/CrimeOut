package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReporteRequest {
    String tipoReporte;
    List<Double> ubicacion;
    String imagen;
    String detalles;
}
