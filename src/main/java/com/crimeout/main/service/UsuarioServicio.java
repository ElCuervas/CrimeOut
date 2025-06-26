package com.crimeout.main.service;

import com.crimeout.main.dto.UsuarioDatosDto;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UsuarioServicio {
    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;

    public List<Usuario> findAll() {
        return usuarioRepository.findAll();
    }
    public Usuario findById(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }
    public Usuario findByUsername(String rut) {
        return usuarioRepository.findByRut(rut)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }
    public ResponseEntity<?> cambiarDatos(Integer id, UsuarioDatosDto usuarioDatosDto) {
        Usuario usuario = findById(id);
        usuario.setNombre(usuarioDatosDto.getNombre());
        usuario.setCorreo(usuarioDatosDto.getCorreo());
        if (usuarioDatosDto.getPassword() != null && !usuarioDatosDto.getPassword().isEmpty()) {
            usuario.setContrasena(passwordEncoder.encode(usuarioDatosDto.getPassword()));
        }
        usuarioRepository.save(usuario);
        return ResponseEntity.ok().body("Datos del usuario actualizados exitosamente");
    }
    public ResponseEntity<?> deleteById(Integer id) {
        Usuario usuario = findById(id);
        usuarioRepository.delete(usuario);
        return ResponseEntity.ok().body("Usuario eliminado exitosamente");
    }
}
