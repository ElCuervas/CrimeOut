package com.crimeout.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AnalisisReportesResponse {
    int microtrafico; // Número de reportes de microtráfico
    int actividad_ilicita; // Número de reportes de actividad ilícita
    int maltrato_animal; // Número de reportes de maltrato animal
    int basural; // Número de reportes de basural
}
