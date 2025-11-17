package com.datacampus.service;


import com.datacampus.dto.*;

public interface MatriculaService {

    MatriculaIniciarResponse iniciarMatricula(MatriculaIniciarRequest request);

    MatriculaAgregarGrupoResponse agregarGrupo(Integer idMatricula, MatriculaAgregarGrupoRequest request);

    MatriculaQuitarGrupoResponse quitarGrupo(Integer idMatricula, Integer idGrupo);

    MatriculaFinalizarResponse finalizarMatricula(Integer idMatricula);
}
