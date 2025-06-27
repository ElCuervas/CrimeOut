package com.crimeout.main.dto;

import com.crimeout.main.entity.TipoReporte;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReportesSospechososResponse {
    private Integer id_usuario;
    private TipoReporte tipoReporte;
    private String imagenUrl;
    private String detalles;
}
