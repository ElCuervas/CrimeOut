package com.crimeout.main.repository;


import com.crimeout.main.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ReporteRepository extends JpaRepository<Reporte, Integer> {

    // Buscar por tipo de reporte
    List<Reporte> findByTipoReporte(TipoReporte tipoReporte);

    List<Reporte> findByUsuario(Usuario usuario);

    // Buscar por ubicación (búsqueda parcial)
    List<Reporte> findByUbicacionContaining(String ubicacion);

    // Buscar por rango de fechas
    List<Reporte> findByFechaBetween(LocalDateTime fechaInicio, LocalDateTime fechaFin);

    // Buscar reportes solucionados/no solucionados
    List<Reporte> findBySolucionado(Boolean solucionado);

    // Buscar reportes confiables/no confiables
    List<Reporte> findByConfiable(Boolean confiable);

    // Consulta personalizada para reportes recientes
    @Query("SELECT r FROM Reporte r ORDER BY r.fecha DESC")
    List<Reporte> findReportesRecientes();

    // Consulta para encontrar reportes por tipo y estado de solución
    List<Reporte> findByTipoReporteAndSolucionado(TipoReporte tipoReporte, Boolean solucionado);

    // Reportes de un usuario específico en un rango de fechas
    List<Reporte> findByUsuarioAndFechaBetween(Usuario usuario, LocalDateTime fechaInicio, LocalDateTime fechaFin);
}