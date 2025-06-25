package com.crimeout.main.service;

import com.crimeout.main.dto.AuthResponse;
import com.crimeout.main.dto.LoginRequest;
import com.crimeout.main.dto.RegisterRequest;
import com.crimeout.main.entity.Rol;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuthService{
    private final UsuarioRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getRut(), request.getPassword()));
        Usuario user=userRepository.findByRut(request.getRut()).orElseThrow();
        Map<String, Object> extraClaims = new HashMap<>();
        extraClaims.put("id", user.getId());
        extraClaims.put("rol", user.getRol());
        jwtService.setExtraClaims(extraClaims);
        String token = jwtService.getToken(user);
        return AuthResponse.builder()
                .idUsuario(user.getId())
                .token(token)
                .build();
    }
    public AuthResponse register(RegisterRequest request, int tipoUsuario) {//1 para usuario, 2 para admin
        Rol rol = Rol.USUARIO;
        if(tipoUsuario==2){
            rol = Rol.MUNICIPAL;
        }
        Usuario user = Usuario.builder()
                .rut(request.getRut())
                .contrasena(passwordEncoder.encode(request.getPassword()))
                .nombre(request.getNombre())
                .correo(request.getCorreo())
                .rol(rol)
                .build();

        userRepository.save(user);

        return AuthResponse.builder()
                .idUsuario(user.getId())
                .token(jwtService.getToken(user))
                .build();

    }
}
