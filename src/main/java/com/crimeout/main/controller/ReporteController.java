package com.crimeout.main.controller;

import com.crimeout.main.dto.ReporteRequest;
import com.crimeout.main.dto.UbicacionReporteResponse;
import com.crimeout.main.service.ReporteServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controlador para la gestión de reportes.
 */
@RestController
@RequestMapping("/api/reportes")
@RequiredArgsConstructor
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
    @PostMapping("/crear")
    public ResponseEntity<?> crearReporte(@RequestBody ReporteRequest request, @RequestParam Integer userId) {
        return reporteServicio.crearReporte(request, userId);
    }

    /**
     * Obtiene la lista de ubicaciones de todos los reportes.
     *
     * @return respuesta HTTP con la lista de ubicaciones de los reportes
     */
    @GetMapping("/ubicaciones")
    public ResponseEntity<List<UbicacionReporteResponse>> ubicacionReportes() {
        return reporteServicio.ubicacionReportes();
    }
}