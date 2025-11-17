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

    // 2. Agregar grupo
    @PostMapping("/{idMatricula}/agregar-grupo")
    public ResponseEntity<MatriculaAgregarGrupoResponse> agregarGrupo(
            @PathVariable Integer idMatricula,
            @RequestBody MatriculaAgregarGrupoRequest request) {

        return ResponseEntity.ok(matriculaService.agregarGrupo(idMatricula, request));
    }

    // 3. Quitar grupo
    @DeleteMapping("/{idMatricula}/grupo/{idGrupo}")
    public ResponseEntity<MatriculaQuitarGrupoResponse> quitarGrupo(
            @PathVariable Integer idMatricula,
            @PathVariable Integer idGrupo) {

        return ResponseEntity.ok(matriculaService.quitarGrupo(idMatricula, idGrupo));
    }

    // 4. Finalizar matrícula
    @PostMapping("/{idMatricula}/finalizar")
    public ResponseEntity<MatriculaFinalizarResponse> finalizar(
            @PathVariable Integer idMatricula) {

        return ResponseEntity.ok(matriculaService.finalizarMatricula(idMatricula));
    }

}
