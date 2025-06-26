package com.crimeout.main.controller;

import com.crimeout.main.dto.UsuarioDatosDto;
import com.crimeout.main.service.UsuarioServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1/crimeout/auth", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserControlller {
    private final UsuarioServicio usuarioServicio;

    @PatchMapping("/usuario/{id}")
    public ResponseEntity<?> cambiarDatos(@PathVariable Integer id, @RequestBody UsuarioDatosDto usuarioDatosDto) {
        return usuarioServicio.cambiarDatos(id, usuarioDatosDto);
    }
    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> DeleteUser(@PathVariable Integer id) {
        return usuarioServicio.deleteById(id);
    }
}
