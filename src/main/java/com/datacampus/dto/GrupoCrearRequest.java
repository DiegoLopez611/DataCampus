package com.datacampus.dto;

public record GrupoCrearRequest(

        String nombre,
        Integer idPeriodoAcademico,
        Integer idAsignatura
) {
}
