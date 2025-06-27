package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EstadoSistemaResponse {
    private Integer total_usuarios;
    private Integer total_reportes;
    private Integer reportes_sospechosos;
}
