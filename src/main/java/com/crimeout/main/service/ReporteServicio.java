package com.crimeout.main.service;

import com.crimeout.main.dto.CrearReporteRequest;
import com.crimeout.main.dto.ListReporteResponse;
import com.crimeout.main.dto.UsuarioReportesResponse;
import com.crimeout.main.entity.Reporte;
import com.crimeout.main.entity.TipoReporte;
import com.crimeout.main.entity.Usuario;
import com.crimeout.main.repository.ReporteRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Servicio para la gestión de reportes.
 */
@Service
@RequiredArgsConstructor
public class ReporteServicio {
    private final ReporteRepository reporteRepository;
    private final UsuarioServicio usuarioServicio;
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * Crea un nuevo reporte a partir de la solicitud y el ID de usuario.
     *
     * @param request datos del reporte a crear
     * @param userId ID del usuario que realiza el reporte
     * @return respuesta HTTP indicando el resultado de la operación
     */
    public ResponseEntity<?> crearReporte(CrearReporteRequest request, Integer userId) {
        Boolean estado=false;
        Usuario user = usuarioServicio.findById(userId);
        String ubicacion;
        try {
            ubicacion = objectMapper.writeValueAsString(request.getUbicacion());
        } catch (JsonProcessingException e) {
            return ResponseEntity.badRequest().body("Error al procesar la ubicación");
        }
        Reporte reporte = Reporte.builder()
                .tipoReporte(TipoReporte.valueOf(request.getTipoReporte()))
                .usuario(user)
                .ubicacion(ubicacion)
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

    /**
     * Obtiene la lista de ubicaciones de todos los reportes.
     *
     * @return respuesta HTTP con la lista de ubicaciones de los reportes
     */
    public ResponseEntity<List<ListReporteResponse>> ubicacionReportes() {
        List<Reporte> reportes = reporteRepository.findAll();
        return ResponseEntity.ok(listaReportes(reportes));
    }

    public ResponseEntity<UsuarioReportesResponse> usuarioReportes(Integer userId) {
        Usuario user = usuarioServicio.findById(userId);
        List<Reporte> reportes = reporteRepository.findByUsuario(user);
        UsuarioReportesResponse ReportesUsuario = UsuarioReportesResponse.builder()
                .idUsuario(user.getId())
                .nombreUsuario(user.getNombre())
                .roles(user.getRol().toString())
                .reportes(listaReportes(reportes))
                .build();
        return ResponseEntity.ok(ReportesUsuario);
    }

    private List<ListReporteResponse> listaReportes(List<Reporte> reportes) {
        return reportes.stream()
                .map(reporte -> {
                    List<Double> ubicacion = new ArrayList<>();
                    try {
                        ubicacion = objectMapper.readValue(
                                reporte.getUbicacion(),
                                new com.fasterxml.jackson.core.type.TypeReference<>() {
                                }
                        );
                    } catch (Exception ignored) {}
                    return ListReporteResponse.builder()
                            .tipoReporte(reporte.getTipoReporte().name())
                            .ubicacion(ubicacion)
                            .fecha(reporte.getFecha())
                            .imagen(reporte.getImagen())
                            .detalles(reporte.getDetalles())
                            .confiable(reporte.getConfiable())
                            .solucionado(reporte.getSolucionado())
                            .build();
                })
                .toList();
    }
}
