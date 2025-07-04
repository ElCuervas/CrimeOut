package com.crimeout.main.controller;

import com.crimeout.main.dto.SugerenciaRequest;
import com.crimeout.main.dto.UsuarioDatosDto;
import com.crimeout.main.dto.UsuarioResponse;
import com.crimeout.main.service.UsuarioServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1/crimeout", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserControlller {
    private final UsuarioServicio usuarioServicio;

    @GetMapping("/usuario/buscar/{id}")
    public ResponseEntity<UsuarioResponse> buscarUsuario(@PathVariable Integer id) {
        return usuarioServicio.buscarUsuarioPorId(id);
    }
    @GetMapping("/list/usuarios-nombre/{nombre}")
    public ResponseEntity<?> buscarUsuariosPorNombre(@PathVariable String nombre) {
        return usuarioServicio.listUsuariosPorNombre(nombre);
    }
    @GetMapping("/list/usuarios-rol/{rol}")
    public ResponseEntity<?> buscarUsuariosPorRol(@PathVariable String rol) {
        return usuarioServicio.listUsuariosPorRol(rol);
    }
    @GetMapping("list/estado-sistema")
    public ResponseEntity<?> estadoSistemaResponse() {
        return usuarioServicio.estadoSistema();
    }
    @PostMapping("/sugerencia")
    public ResponseEntity<?> enviarSugerencia(@RequestBody SugerenciaRequest request) {
        usuarioServicio.enviarSugerencia(request.getMensaje());
        return ResponseEntity.ok("Sugerencia enviada correctamente");
    }
    @PatchMapping("/usuario/{id}")
    public ResponseEntity<?> cambiarDatos(@PathVariable Integer id, @RequestBody UsuarioDatosDto usuarioDatosDto) {
        return usuarioServicio.cambiarDatos(id, usuarioDatosDto);
    }
    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> DeleteUser(@PathVariable Integer id) {
        return usuarioServicio.deleteById(id);
    }
}
