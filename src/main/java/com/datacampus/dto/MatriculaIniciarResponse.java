package com.datacampus.dto;

import java.util.List;

public record MatriculaIniciarResponse(
        Integer idMatricula,
        List<String> asignaturasAutomaticas,
        String mensaje
) {}
