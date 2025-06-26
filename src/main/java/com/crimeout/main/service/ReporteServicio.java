package com.crimeout.main.service;

import com.crimeout.main.dto.*;
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
    /**
     * Obtiene los reportes de un usuario específico.
     *
     * @param userId ID del usuario cuyos reportes se desean obtener
     * @return respuesta HTTP con la lista de reportes del usuario
     */
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
    /**
     * Obtiene los reportes por tipo de reporte.
     *
     * @param tipoReporte tipo de reporte a buscar
     * @return respuesta HTTP con la lista de reportes del tipo especificado
     */
    public ResponseEntity<List<ListReporteResponse>> reportesPorTipo(String tipoReporte){
        List<Reporte> reportes = reporteRepository.findByTipoReporteAndSolucionado(TipoReporte.valueOf(tipoReporte),false);
        if (reportes.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(listaReportes(reportes));
    }
    public ResponseEntity<List<ListReporteResponse>> reportesPorNoConfiable() {
        List<Reporte> reportes = reporteRepository.findByConfiable(false);
        if (reportes.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(listaReportes(reportes));
    }
    /**
     * Obtiene el número de reportes por mes y año para el gráfico.
     *
     * @param mes_anio mes y año en formato "MM-yyyy"
     * @return respuesta HTTP con la lista de reportes por mes y año
     */
    public ResponseEntity<AnalisisReportesResponse> analisisReportes(String mes_anio) {
        String[] fecha = mes_anio.split("-");
        int mes = Integer.parseInt(fecha[0]);
        int anio = Integer.parseInt(fecha[1]);
        int[] tipo_reporte = {0,0,0,0}; // [microtrafico, actividad_ilicita, maltrato_animal, basural]
        List<Reporte> reportes = reporteRepository.findByMesAndAnio(mes, anio);
        for (Reporte reporte : reportes) {
            switch (reporte.getTipoReporte()) {
                case MICROTRAFICO:
                    tipo_reporte[0]++;
                    break;
                case ACTIVIDAD_ILICITA:
                    tipo_reporte[1]++;
                    break;
                case MALTRATO_ANIMAL:
                    tipo_reporte[2]++;
                    break;
                case BASURAL:
                    tipo_reporte[3]++;
                    break;
            }
        }
        AnalisisReportesResponse analisisReportes = AnalisisReportesResponse.builder()
                .microtrafico(tipo_reporte[0])
                .actividad_ilicita(tipo_reporte[1])
                .maltrato_animal(tipo_reporte[2])
                .basural(tipo_reporte[3])
                .build();
        return ResponseEntity.ok(analisisReportes);
    }
    /**
     * Actualiza el estado de un reporte.
     *
     * @param reporteId ID del reporte a actualizar
     * @param request datos del estado del reporte
     * @return respuesta HTTP indicando el resultado de la operación
     */
    public ResponseEntity<?> estadoReporte(Integer reporteId, EstadoReporteDto request) {
        Reporte reporte = reporteRepository.findById(reporteId)
                .orElseThrow(() -> new IllegalArgumentException("Reporte con id " + reporteId + " no encontrado"));
        reporte.setConfiable(request.getConfiable());
        reporte.setSolucionado(request.getSolucionado());
        reporteRepository.save(reporte);
        return ResponseEntity.ok("Reporte actualizado correctamente");
    }
    /**
     * Convierte una lista de reportes a una lista de respuestas de reporte.
     *
     * @param reportes lista de reportes a convertir
     * @return lista de respuestas de reporte
     */
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
                            .idReporte(reporte.getIdReporte())
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
