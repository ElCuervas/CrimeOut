package com.crimeout.main.controller;

import com.crimeout.main.service.UsuarioServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1/crimeout/auth", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserControlller {
    private final UsuarioServicio usuarioServicio;

    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> DeleteUser(Integer id) {
        return usuarioServicio.deleteById(id);
    }
}
