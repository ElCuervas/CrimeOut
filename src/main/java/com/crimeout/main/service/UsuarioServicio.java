package com.crimeout.main.service;

import com.crimeout.main.dto.EstadoSistemaResponse;
import com.crimeout.main.dto.UsuarioDatosDto;
import com.crimeout.main.dto.UsuarioResponse;
import com.crimeout.main.entity.Reporte;
import com.crimeout.main.entity.Rol;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.ReporteRepository;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.mail.javamail.JavaMailSender;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UsuarioServicio {
    private final UsuarioRepository usuarioRepository;
    private final ReporteRepository reporteRepository;
    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender javaMailSender;

    public Usuario findById(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }
    public ResponseEntity<List<UsuarioResponse>> listUsuariosPorNombre(String nombre) {
        List<Usuario> usuario = usuarioRepository.findByNombreContainingIgnoreCase(nombre);
        List<UsuarioResponse> usuarioResponse = usuario.stream()
                .map(u -> UsuarioResponse.builder()
                        .id(u.getId())
                        .nombre(u.getNombre())
                        .rol(u.getRol().name())
                        .build())
                .toList();
        return ResponseEntity.ok(usuarioResponse);

    }
    public ResponseEntity<List<UsuarioResponse>> listUsuariosPorRol(String rol) {
        List<Usuario> usuario = usuarioRepository.findAllByRol(Rol.valueOf(rol));
        List<UsuarioResponse> usuarioResponse = usuario.stream()
                .map(u -> UsuarioResponse.builder()
                        .id(u.getId())
                        .nombre(u.getNombre())
                        .rol(u.getRol().name())
                        .build())
                .toList();
        return ResponseEntity.ok(usuarioResponse);

    }
    public ResponseEntity<UsuarioResponse> buscarUsuarioPorId(Integer id) {
        Usuario usuario = findById(id);
        UsuarioResponse usuarioResponse = UsuarioResponse.builder()
                .id(usuario.getId())
                .nombre(usuario.getNombre())
                .rol(usuario.getRol().name())
                .build();
        return ResponseEntity.ok(usuarioResponse);
    }
    public void enviarSugerencia(String mensaje) {
        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo("j.contreras26@ufromail.cl");
        mail.setSubject("Nueva sugerencia");
        mail.setText(mensaje);
        javaMailSender.send(mail);
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
    public ResponseEntity<?> estadoSistema(){
        long totalUsuarios = usuarioRepository.count();
        long totalReportes = reporteRepository.count();
        List<Reporte> reportesSospechosos = reporteRepository.findByConfiable(false);
        EstadoSistemaResponse estadoSistemaResponse = EstadoSistemaResponse.builder()
                .total_usuarios(Math.toIntExact(totalUsuarios))
                .total_reportes(Math.toIntExact(totalReportes))
                .reportes_sospechosos(reportesSospechosos.size())
                .build();
        return ResponseEntity.ok(estadoSistemaResponse);
    }
}
