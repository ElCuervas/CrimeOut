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
    int NumMaltratoAnimal; // Número de reportes de maltrato animal
    int NumActividadIlicita; // Número de reportes de actividad ilícita
    int NumMicrotrafico; // Número de reportes de microtráfico
    int NumBasural; // Número de reportes de basural
}
