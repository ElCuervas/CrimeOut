package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UsuarioResponse {
    /**
     * ID del usuario.
     */
    private Integer id;

    /**
     * Nombre del usuario.
     */
    private String nombre;

    /**
     * Rol del usuario.
     */
    private String rol;
}
