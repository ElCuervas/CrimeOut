package com.crimeout.main.repository;

import com.crimeout.main.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Repositorio para la gestión de entidades Reporte.
 */
@Repository
public interface ReporteRepository extends JpaRepository<Reporte, Integer> {

    /**
     * Busca reportes por tipo de reporte.
     *
     * @param tipoReporte tipo de reporte a buscar
     * @return lista de reportes del tipo especificado
     */
    List<Reporte> findByTipoReporte(TipoReporte tipoReporte);

    /**
     * Busca reportes por usuario.
     *
     * @param usuario usuario asociado al reporte
     * @return lista de reportes del usuario especificado
     */
    List<Reporte> findByUsuario(Usuario usuario);

    /**
     * Busca reportes que contengan una ubicación específica.
     *
     * @param ubicacion ubicación a buscar (como texto)
     * @return lista de reportes que contienen la ubicación
     */
    List<Reporte> findByUbicacionContaining(String ubicacion);

    /**
     * Busca reportes entre dos fechas.
     *
     * @param fechaInicio fecha de inicio
     * @param fechaFin fecha de fin
     * @return lista de reportes en el rango de fechas
     */
    List<Reporte> findByFechaBetween(LocalDateTime fechaInicio, LocalDateTime fechaFin);

    /**
     * Busca reportes por estado de solucionado.
     *
     * @param solucionado indica si el reporte está solucionado
     * @return lista de reportes según el estado de solucionado
     */
    List<Reporte> findBySolucionado(Boolean solucionado);

    /**
     * Busca reportes por estado de confiable.
     *
     * @param confiable indica si el reporte es confiable
     * @return lista de reportes según el estado de confiabilidad
     */
    List<Reporte> findByConfiable(Boolean confiable);

    /**
     * Obtiene todos los reportes ordenados por fecha descendente.
     *
     * @return lista de reportes recientes
     */
    @Query("SELECT r FROM Reporte r ORDER BY r.fecha DESC")
    List<Reporte> findReportesRecientes();

    /**
     * Busca reportes por tipo y estado de solucionado.
     *
     * @param tipoReporte tipo de reporte
     * @param solucionado estado de solucionado
     * @return lista de reportes filtrados por tipo y solucionado
     */
    List<Reporte> findByTipoReporteAndSolucionado(TipoReporte tipoReporte, Boolean solucionado);

    /**
     * Busca reportes de un usuario en un rango de fechas.
     *
     * @param usuario usuario asociado
     * @param fechaInicio fecha de inicio
     * @param fechaFin fecha de fin
     * @return lista de reportes del usuario en el rango de fechas
     */
    List<Reporte> findByUsuarioAndFechaBetween(Usuario usuario, LocalDateTime fechaInicio, LocalDateTime fechaFin);

    // En ReporteRepository.java
    @Query("SELECT r FROM Reporte r WHERE MONTH(r.fecha) = :mes AND YEAR(r.fecha) = :anio")
    List<Reporte> findByMesAndAnio(@Param("mes") int mes, @Param("anio") int anio);
}