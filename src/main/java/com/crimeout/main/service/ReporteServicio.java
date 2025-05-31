package com.crimeout.main.service;

import com.crimeout.main.dto.ReporteRequest;
import com.crimeout.main.dto.UbicacionReporteResponse;
import com.crimeout.main.entity.Reporte;
import com.crimeout.main.entity.TipoReporte;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.ReporteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReporteServicio {
    private final ReporteRepository reporteRepository;
    private final UsuarioServicio usuarioServicio;
    public ResponseEntity<?> crearReporte(ReporteRequest request, Integer userId) {
        Boolean estado=false;
        Usuario user = usuarioServicio.findById(userId);
        Reporte reporte = Reporte.builder()
                .tipoReporte(TipoReporte.valueOf(request.getTipoReporte()))
                .usuario(user)
                .ubicacion(request.getUbicacion())
                .fecha(LocalDateTime.now())
                .imagen(request.getImagen())
                .detalles(request.getDetalles())
                .confiable(estado)
                .solucionado(estado)
                .build();

        reporteRepository.save(reporte);

        return ResponseEntity.ok()
                .body("Reporte creado exitosamente");
    }
    public ResponseEntity<List<UbicacionReporteResponse>> ubicacionReportes() {
        List<Reporte> reportes = reporteRepository.findAll();
        List<UbicacionReporteResponse> ubicacionReporteList = reportes.stream()
            .map(reporte -> UbicacionReporteResponse.builder()
                .tipoReporte(reporte.getTipoReporte().name())
                .ubicacion(reporte.getUbicacion())
                .fecha(reporte.getFecha())
                .imagen(reporte.getImagen())
                .detalles(reporte.getDetalles())
                .confiable(reporte.getConfiable())
                .solucionado(reporte.getSolucionado())
                .build())
            .toList();
        return ResponseEntity.ok(ubicacionReporteList);
    }
}
