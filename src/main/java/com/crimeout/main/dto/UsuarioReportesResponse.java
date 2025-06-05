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
public class UsuarioReportesResponse {
    /**
     * ID del usuario.
     */
    private Integer idUsuario;

    /**
     * Nombre del usuario.
     */
    private String nombreUsuario;

    private String roles;

    private List<UbicacionReporteResponse> reportes;
}
