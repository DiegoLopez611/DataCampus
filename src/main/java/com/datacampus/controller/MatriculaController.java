package com.datacampus.controller;

import com.datacampus.dto.*;
import com.datacampus.service.MatriculaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/matricula")
@RequiredArgsConstructor
public class MatriculaController {

    private final MatriculaService matriculaService;

    // 1. Iniciar matrícula
    @PostMapping("/iniciar")
    public ResponseEntity<MatriculaIniciarResponse> iniciar(
            @RequestBody MatriculaIniciarRequest request) {
        return ResponseEntity.ok(matriculaService.iniciarMatricula(request));
    }

}
