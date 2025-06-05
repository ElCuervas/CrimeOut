package com.crimeout.main.controller;

import com.crimeout.main.dto.CrearReporteRequest;
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
     * Obtiene la lista de todos los reportes para ubicacion.
     *
     * @return respuesta HTTP con la lista de todos los reportes para ubicacion
     */
    @GetMapping("/reportes")
    public ResponseEntity<?> ubicacionReportes() {
        return reporteServicio.ubicacionReportes();
    }
}