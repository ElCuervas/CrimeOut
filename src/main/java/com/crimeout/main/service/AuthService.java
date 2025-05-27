package com.crimeout.main.service;

import com.crimeout.main.dto.AuthResponse;
import com.crimeout.main.dto.LoginRequest;
import com.crimeout.main.dto.RegisterRequest;
import com.crimeout.main.entity.Rol;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService{
    private final UsuarioRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthResponse login(LoginRequest request) {
        UserDetails user=userRepository.findByRut(request.getRut()).orElseThrow();
        String nombre=user.getUsername();
        return AuthResponse.builder()
                .token("Simulacion de token" + nombre)
                .build();
    }
    public AuthResponse register(RegisterRequest request) {
        Usuario user = Usuario.builder()
                .rut(request.getRut())
                .contrasena(passwordEncoder.encode(request.getPassword()))
                .nombre(request.getNombre())
                .correo(request.getCorreo())
                .rol(Rol.USUARIO)
                .build();

        userRepository.save(user);

        return AuthResponse.builder()
                .token(jwtService.getToken(user))
                .build();

    }
}
