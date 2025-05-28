package com.crimeout.main.service;

import com.crimeout.main.dto.AuthResponse;
import com.crimeout.main.dto.ReporteRequest;
import com.crimeout.main.entity.Reporte;
import com.crimeout.main.entity.Rol;
import com.crimeout.main.entity.TipoReporte;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.ReporteRepository;
import com.crimeout.main.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ReporteServicio {
    private final ReporteRepository reporteRepository;
    private final UsuarioServicio usuarioServicio;
    public ReporteRequest crearReporte(ReporteRequest request) {
        Usuario user = usuarioServicio.findById(request.getUsuarioId());
        Reporte reporte = Reporte.builder()
                .tipoReporte(TipoReporte.valueOf(request.getTipoReporte()))
                .usuario(user)
                .ubicacion(request.getUbicacion())
                .fecha(LocalDateTime.now())
                .imagen(request.getImagen())
                .detalles(request.getDetalles())
                .build();

        reporteRepository.save(reporte);

        return ReporteRequest.builder().build();
    }
}
