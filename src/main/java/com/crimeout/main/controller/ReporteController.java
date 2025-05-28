package com.crimeout.main.controller;

import com.crimeout.main.dto.ReporteRequest;
import com.crimeout.main.service.ReporteServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1/crimeout", produces = MediaType.APPLICATION_JSON_VALUE)
public class ReporteController {
    private final ReporteServicio reporteServicio;
    @PostMapping("/user/{id}/reporte")
    public ResponseEntity<?> crearReporte(@PathVariable("id") Integer userId, @RequestBody ReporteRequest request) {
        return ResponseEntity.ok(reporteServicio.crearReporte(request, userId));
    }
}
