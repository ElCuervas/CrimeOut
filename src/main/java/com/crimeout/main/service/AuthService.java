package com.crimeout.main.service;

import com.crimeout.main.dto.AuthResponse;
import com.crimeout.main.dto.LoginRequest;
import com.crimeout.main.dto.RegisterRequest;
import com.crimeout.main.entity.Rol;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService{
    private final UsuarioRepository userRepository;

    public AuthResponse login(LoginRequest request) {
        UserDetails user=userRepository.findByRut(request.getRut()).orElseThrow();
        String nombre=user.getUsername();
        return AuthResponse.builder()
                .token("Simulacion de token" + nombre)
                .build();
    }
    public ResponseEntity<?> register(RegisterRequest request) {
        Usuario user = Usuario.builder()
                .rut(request.getRut())
                .contrasena(request.getPassword())
                .nombre(request.getNombre())
                .correo(request.getCorreo())
                .rol(Rol.USUARIO)
                .build();

        userRepository.save(user);

        return ResponseEntity.ok("Usuario registrado exitosamente");

    }
}
