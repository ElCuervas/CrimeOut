package com.crimeout.main.service;

import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UsuarioServicio {
    private final UsuarioRepository usuarioRepository;
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
    public ResponseEntity<?> deleteById(Integer id) {
        Usuario usuario = findById(id);
        usuarioRepository.delete(usuario);
        return ResponseEntity.ok().body("Usuario eliminado exitosamente");
    }
}
