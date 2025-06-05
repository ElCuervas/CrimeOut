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
    /**
     * roles del usuario.
     */
    private String roles;
    /**
     * Lista de reportes asociados al usuario.
     */
    private List<ListReporteResponse> reportes;
}
