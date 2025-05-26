package com.crimeout.main.repository;


import com.crimeout.main.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ReporteRepository extends JpaRepository<Reporte, Integer> {

    List<Reporte> findByTipoReporte(TipoReporte tipoReporte);

    List<Reporte> findByUsuario(Usuario usuario);

    List<Reporte> findByUbicacionContaining(String ubicacion);

    List<Reporte> findByFechaBetween(LocalDateTime fechaInicio, LocalDateTime fechaFin);

    List<Reporte> findBySolucionado(Boolean solucionado);

    List<Reporte> findByConfiable(Boolean confiable);

    @Query("SELECT r FROM Reporte r ORDER BY r.fecha DESC")
    List<Reporte> findReportesRecientes();

    List<Reporte> findByTipoReporteAndSolucionado(TipoReporte tipoReporte, Boolean solucionado);

    List<Reporte> findByUsuarioAndFechaBetween(Usuario usuario, LocalDateTime fechaInicio, LocalDateTime fechaFin);
}