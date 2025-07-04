package com.crimeout.main.controller;

import com.crimeout.main.dto.CrearReporteRequest;
import com.crimeout.main.dto.EstadoReporteDto;
import org.springframework.stereotype.Controller;
import com.crimeout.main.service.ReporteServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


/**
 * Controlador para la gestión de reportes.
 */
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1/crimeout", produces = MediaType.APPLICATION_JSON_VALUE)
public class ReporteController {

    /**
     * Servicio para la gestión de reportes.
     */
    private final ReporteServicio reporteServicio;

    /**
     * Crea un nuevo reporte.
     *
     * @param request datos del reporte a crear
     * @param userId ID del usuario que realiza el reporte
     * @return respuesta HTTP indicando el resultado de la operación
     */
    @PostMapping("/user/{id}/reporte")
    public ResponseEntity<?> crearReporte(@PathVariable("id") Integer userId, @RequestBody CrearReporteRequest request) {
        return ResponseEntity.ok(reporteServicio.crearReporte(request, userId));
    }
    /**
     * Obtiene los reportes de un usuario específico.
     *
     * @param userId ID del usuario cuyos reportes se desean obtener
     * @return respuesta HTTP con la lista de reportes del usuario
     */
    @GetMapping("/user/{id}/reportes")
    public ResponseEntity<?> usuarioReportes(@PathVariable("id") Integer userId) {
        return reporteServicio.usuarioReportes(userId);
    }
    /**
     * Obtiene la lista de todos los reportes para ubicacion.
     *
     * @return respuesta HTTP con la lista de todos los reportes para ubicacion
     */
    @GetMapping("/reportes")
    public ResponseEntity<?> ubicacionReportes() {
        return reporteServicio.ubicacionReportes();
    }

    @GetMapping("/reportes/sospechosos")
    public ResponseEntity<?> reportesPorNoConfiable(){
        return reporteServicio.reportesPorNoConfiable();
    }
     /**
     * Obtiene los reportes por tipo.
     *
     * @param tipoReporte tipo de reporte a filtrar
     * @return respuesta HTTP con la lista de reportes filtrados por tipo
     */

    @GetMapping("/list/municipal/{tipoReporte}/reportes")
    public ResponseEntity<?> reportesFalsos(@PathVariable("tipoReporte") String tipoReporte) {
        return reporteServicio.reportesPorTipo(tipoReporte);
    }
    /**
     * Obtiene numero de la cantidad de reportes por mes y año para el grafico.
     * @param mes_anio mes y año en formato "MM-yyyy"
     * @return respuesta HTTP con la lista de reportes por mes y año
     */
    @GetMapping("list/grafico/{mes}")
    public ResponseEntity<?> analisisReportes(@PathVariable("mes") String mes_anio) {
        return reporteServicio.analisisReportes(mes_anio);
    }
    /**
     * Actualiza el estado de un reporte.
     *
     * @param id ID del reporte a actualizar
     * @param request datos del estado del reporte a actualizar
     * @return respuesta HTTP indicando el resultado de la operación
     */
    @PatchMapping("/reporte/{id}")
    public ResponseEntity<?> actualizarEstado(@PathVariable Integer id, @RequestBody EstadoReporteDto request) {
        return reporteServicio.estadoReporte(id, request);
    }


}