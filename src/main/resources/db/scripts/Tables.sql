
/**
    Dado que se quieren agregra las llaves primarias como un indice independiente en el tablespace TS_INDICES

    1. Se crea la tabla sin restricciones de llave primaria
    2. Se crea el indice sobre la campo de llave primaria de la tabla y se le asigna el tablespace correspondiente (TS_INDICES)
    3. Se modifica la tabla para agregar la restricción de llave primaria (Indice creado manualmente en el paso 2) 
**/

-- Departamento
CREATE TABLE Departamento (
    id_departamento NUMBER NOT NULL,
    nombre VARCHAR2(100) NOT NULL
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Departamento_PK
ON Departamento(id_departamento)
TABLESPACE ts_indices;

ALTER TABLE Departamento
ADD CONSTRAINT PK_Departamento
PRIMARY KEY (id_departamento)
USING INDEX IX_Departamento_PK;


-- Municipio

CREATE TABLE Municipio (
    id_municipio NUMBER NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    id_departamento NUMBER NOT NULL,

    CONSTRAINT FK_Municipio_Departamento
    FOREIGN KEY (id_departamento)
    REFERENCES Departamento(id_departamento)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Municipio_PK
ON Municipio(id_municipio)
TABLESPACE ts_indices;

ALTER TABLE Municipio
ADD CONSTRAINT PK_Municipio
PRIMARY KEY (id_municipio)
USING INDEX IX_Municipio_PK;

CREATE INDEX IX_Municipio_Departamento
ON Municipio(id_departamento)
TABLESPACE ts_indices;

-- Sede

CREATE TABLE Sede (
    id_sede NUMBER NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    id_municipio NUMBER NOT NULL,

    CONSTRAINT FK_Sede_Municipio
    FOREIGN KEY (id_municipio)
    REFERENCES Municipio(id_municipio)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Sede_PK
ON Sede(id_sede)
TABLESPACE ts_indices;

ALTER TABLE Sede
ADD CONSTRAINT PK_Sede
PRIMARY KEY (id_sede)
USING INDEX IX_Sede_PK;

CREATE INDEX IX_Sede_Municipio
ON Sede(id_municipio)
TABLESPACE ts_indices;

-- Facultad

CREATE TABLE Facultad (
    id_facultad NUMBER NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    id_sede NUMBER NOT NULL,

    CONSTRAINT FK_Facultad_Sede
    FOREIGN KEY (id_sede)
    REFERENCES Sede(id_sede)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Facultad_PK
ON Facultad(id_facultad)
TABLESPACE ts_indices;

ALTER TABLE Facultad
ADD CONSTRAINT PK_Facultad
PRIMARY KEY (id_facultad)
USING INDEX IX_Facultad_PK;

CREATE INDEX IX_Facultad_Sede
ON Facultad(id_sede)
TABLESPACE ts_indices;

-- Tipo Programa

CREATE TABLE Tipo_Programa (
    id_tipo_programa NUMBER NOT NULL,
    nombre VARCHAR2(50) NOT NULL
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_TipoPrograma_PK
ON Tipo_Programa(id_tipo_programa)
TABLESPACE ts_indices;

ALTER TABLE Tipo_Programa
ADD CONSTRAINT PK_TipoPrograma
PRIMARY KEY (id_tipo_programa)
USING INDEX IX_TipoPrograma_PK;

-- Programa Academico

CREATE TABLE Programa_Academico (
    id_programa_academico NUMBER NOT NULL,
    codigo VARCHAR2(20) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    numero_creditos NUMBER NOT NULL,
    id_tipo_programa NUMBER NOT NULL,
    id_facultad NUMBER NOT NULL,

    CONSTRAINT FK_Prog_Tipo
        FOREIGN KEY (id_tipo_programa)
        REFERENCES Tipo_Programa(id_tipo_programa),

    CONSTRAINT FK_Prog_Facultad
        FOREIGN KEY (id_facultad)
        REFERENCES Facultad(id_facultad)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_ProgramaAcademico_PK
ON Programa_Academico(id_programa_academico)
TABLESPACE ts_indices;

ALTER TABLE Programa_Academico
ADD CONSTRAINT PK_Programa_Academico
PRIMARY KEY (id_programa_academico)
USING INDEX IX_ProgramaAcademico_PK;

CREATE INDEX IX_ProgramaAcademico_Tipo
ON Programa_Academico(id_tipo_programa)
TABLESPACE ts_indices;

CREATE INDEX IX_ProgramaAcademico_Facultad
ON Programa_Academico(id_facultad)
TABLESPACE ts_indices;

-- Tipo Asignatura

CREATE TABLE Tipo_Asignatura (
    id_tipo_asignatura NUMBER NOT NULL,
    nombre VARCHAR2(50) NOT NULL
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_TipoAsignatura_PK
ON Tipo_Asignatura(id_tipo_asignatura)
TABLESPACE ts_indices;

ALTER TABLE Tipo_Asignatura
ADD CONSTRAINT PK_TipoAsignatura
PRIMARY KEY (id_tipo_asignatura)
USING INDEX IX_TipoAsignatura_PK;

-- Asignatura

CREATE TABLE Asignatura (
    id_asignatura NUMBER NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    codigo VARCHAR2(20) NOT NULL,
    numero_creditos NUMBER NOT NULL,
    horas_semanales NUMBER NOT NULL,
    semestre NUMBER NOT NULL,
    id_tipo_asignatura NUMBER NOT NULL,
    id_programa_academico NUMBER NOT NULL,

    CONSTRAINT FK_Asigatura_Tipo
        FOREIGN KEY (id_tipo_asignatura)
        REFERENCES Tipo_Asignatura(id_tipo_asignatura),

    CONSTRAINT FK_Asigatura_Programa
        FOREIGN KEY (id_programa_academico)
        REFERENCES Programa_Academico(id_programa_academico)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Asignatura_PK
ON Asignatura(id_asignatura)
TABLESPACE ts_indices;

ALTER TABLE Asignatura
ADD CONSTRAINT PK_Asignatura
PRIMARY KEY (id_asignatura)
USING INDEX IX_Asignatura_PK;

CREATE INDEX IX_Asignatura_Tipo
ON Asignatura(id_tipo_asignatura)
TABLESPACE ts_indices;

CREATE INDEX IX_Asignatura_Programa
ON Asignatura(id_programa_academico)
TABLESPACE ts_indices;

-- Asignatura Especial

CREATE TABLE Asignatura_Especial (
    id_asignatura_especial NUMBER NOT NULL,
    porcentaje_creditos_aprobados NUMBER NOT NULL,
    id_asignatura NUMBER NOT NULL,

    CONSTRAINT FK_AsigEsp_Asig
        FOREIGN KEY (id_asignatura)
        REFERENCES Asignatura(id_asignatura)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_AsigEspecial_PK
ON Asignatura_Especial(id_asignatura_especial)
TABLESPACE ts_indices;

ALTER TABLE Asignatura_Especial
ADD CONSTRAINT PK_AsigEspecial
PRIMARY KEY (id_asignatura_especial)
USING INDEX IX_AsigEspecial_PK;

CREATE INDEX IX_AsigEsp_Asig
ON Asignatura_Especial(id_asignatura)
TABLESPACE ts_indices;

-- Asignatura Prerrequisito

CREATE TABLE Asignatura_Prerrequisito (
    id_asignatura NUMBER NOT NULL,
    id_prerrequisito NUMBER NOT NULL,

    CONSTRAINT FK_Prer_Asig
        FOREIGN KEY (id_asignatura)
        REFERENCES Asignatura(id_asignatura),

    CONSTRAINT FK_Prer_Req
        FOREIGN KEY (id_prerrequisito)
        REFERENCES Asignatura(id_asignatura)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_AsigPrer_PK
ON Asignatura_Prerrequisito(id_asignatura, id_prerrequisito)
TABLESPACE ts_indices;

ALTER TABLE Asignatura_Prerrequisito
ADD CONSTRAINT PK_AsigPrer
PRIMARY KEY (id_asignatura, id_prerrequisito)
USING INDEX IX_AsigPrer_PK;

CREATE INDEX IX_AsigPrer_Asig
ON Asignatura_Prerrequisito(id_asignatura)
TABLESPACE ts_indices;

CREATE INDEX IX_AsigPrer_Pre
ON Asignatura_Prerrequisito(id_prerrequisito)
TABLESPACE ts_indices;

-- Periodo Academico

CREATE TABLE Periodo_Academico (
    id_periodo_academico NUMBER NOT NULL,
    anio NUMBER NOT NULL,
    semestre NUMBER NOT NULL,
    fecha_inicio DATE,
    fecha_cancelacion DATE,
    fecha_cierre_academico DATE,
    fecha_cierre_admin DATE
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Periodo_PK
ON Periodo_Academico(id_periodo_academico)
TABLESPACE ts_indices;

ALTER TABLE Periodo_Academico
ADD CONSTRAINT PK_Periodo
PRIMARY KEY (id_periodo_academico)
USING INDEX IX_Periodo_PK;

-- Tipo Nota

CREATE TABLE Tipo_Nota (
    id_tipo_nota NUMBER NOT NULL,
    nombre VARCHAR2(50) NOT NULL
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_TipoNota_PK
ON Tipo_Nota(id_tipo_nota)
TABLESPACE ts_indices;

ALTER TABLE Tipo_Nota
ADD CONSTRAINT PK_TipoNota
PRIMARY KEY (id_tipo_nota)
USING INDEX IX_TipoNota_PK;

-- Nivel Riesgo

CREATE TABLE Nivel_Riesgo (
    id_nivel_riesgo NUMBER NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    maximo_creditos NUMBER NOT NULL
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Riesgo_PK
ON Nivel_Riesgo(id_nivel_riesgo)
TABLESPACE ts_indices;

ALTER TABLE Nivel_Riesgo
ADD CONSTRAINT PK_Riesgo
PRIMARY KEY (id_nivel_riesgo)
USING INDEX IX_Riesgo_PK;

-- Aula

CREATE TABLE Aula (
    id_aula NUMBER NOT NULL,
    capacidad_maxima NUMBER NOT NULL,
    id_facultad NUMBER NOT NULL,

    CONSTRAINT FK_Aula_Facultad
        FOREIGN KEY (id_facultad)
        REFERENCES Facultad(id_facultad)
) TABLESPACE ts_solo_lectura;

CREATE UNIQUE INDEX IX_Aula_PK
ON Aula(id_aula)
TABLESPACE ts_indices;

ALTER TABLE Aula
ADD CONSTRAINT PK_Aula
PRIMARY KEY (id_aula)
USING INDEX IX_Aula_PK;

CREATE INDEX IX_Aula_Facultad
ON Aula(id_facultad)
TABLESPACE ts_indices;

-- Estudiante

CREATE TABLE Estudiante (
    id_estudiante NUMBER NOT NULL,
    identificacion VARCHAR2(20) NOT NULL,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100),
    telefono VARCHAR2(20),
    id_programa_academico NUMBER NOT NULL,
    id_sede NUMBER NOT NULL,

    CONSTRAINT FK_Estudiante_Programa
        FOREIGN KEY (id_programa_academico)
        REFERENCES Programa_Academico(id_programa_academico),
        
    CONSTRAINT FK_Estudiante_Sede
        FOREIGN KEY (id_sede)
        REFERENCES Sede (id_sede)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Estudiante_PK
ON Estudiante(id_estudiante)
TABLESPACE ts_indices;

ALTER TABLE Estudiante
ADD CONSTRAINT PK_Estudiante
PRIMARY KEY (id_estudiante)
USING INDEX IX_Estudiante_PK;

CREATE INDEX IX_Estud_Programa
ON Estudiante(id_programa_academico)
TABLESPACE ts_indices;

CREATE INDEX IX_Estud_Sede
ON Estudiante (id_sede)
TABLESPACE ts_indices;

-- Docente

CREATE TABLE Docente (
    id_docente NUMBER NOT NULL,
    documento VARCHAR2(20) NOT NULL,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100),
    telefono VARCHAR2(20)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Docente_PK
ON Docente(id_docente)
TABLESPACE ts_indices;

ALTER TABLE Docente
ADD CONSTRAINT PK_Docente
PRIMARY KEY (id_docente)
USING INDEX IX_Docente_PK;

-- Institucion Educativa

CREATE TABLE Institucion_Educativa (
    id_institucion NUMBER NOT NULL,
    nombre VARCHAR2(200) NOT NULL
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Institucion_PK
ON Institucion_Educativa(id_institucion)
TABLESPACE ts_indices;

ALTER TABLE Institucion_Educativa
ADD CONSTRAINT PK_Institucion
PRIMARY KEY (id_institucion)
USING INDEX IX_Institucion_PK;

-- Estudio

CREATE TABLE Estudio (
    id_estudio NUMBER NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    nivel VARCHAR2(50),
    id_institucion NUMBER NOT NULL,

    CONSTRAINT FK_Estudio_Institucion
        FOREIGN KEY (id_institucion)
        REFERENCES Institucion_Educativa(id_institucion)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Estudio_PK
ON Estudio(id_estudio)
TABLESPACE ts_indices;

ALTER TABLE Estudio
ADD CONSTRAINT PK_Estudio
PRIMARY KEY (id_estudio)
USING INDEX IX_Estudio_PK;

CREATE INDEX IX_Estudio_Institucion
ON Estudio(id_institucion)
TABLESPACE ts_indices;

-- Docente Estudio

CREATE TABLE Docente_Estudio (
    id_docente NUMBER NOT NULL,
    id_estudio NUMBER NOT NULL,

    CONSTRAINT FK_DocEst_Docente
        FOREIGN KEY (id_docente)
        REFERENCES Docente(id_docente),

    CONSTRAINT FK_DocEst_Estudio
        FOREIGN KEY (id_estudio)
        REFERENCES Estudio(id_estudio)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_DocEst_PK
ON Docente_Estudio(id_docente, id_estudio)
TABLESPACE ts_indices;

ALTER TABLE Docente_Estudio
ADD CONSTRAINT PK_Docente_Estudio
PRIMARY KEY (id_docente, id_estudio)
USING INDEX IX_DocEst_PK;

CREATE INDEX IX_DocEst_Doc
ON Docente_Estudio(id_docente)
TABLESPACE ts_indices;

CREATE INDEX IX_DocEst_Est
ON Docente_Estudio(id_estudio)
TABLESPACE ts_indices;

-- Grupo 

CREATE TABLE Grupo (
    id_grupo NUMBER NOT NULL,
    nombre VARCHAR2(45) NOT NULL,
    id_periodo_academico NUMBER NOT NULL,
    id_asignatura NUMBER NOT NULL,

    CONSTRAINT FK_Grupo_Periodo
        FOREIGN KEY (id_periodo_academico)
        REFERENCES Periodo_Academico(id_periodo_academico),

    CONSTRAINT FK_Grupo_Asignatura
        FOREIGN KEY (id_asignatura)
        REFERENCES Asignatura(id_asignatura)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Grupo_PK
ON Grupo(id_grupo)
TABLESPACE ts_indices;

ALTER TABLE Grupo
ADD CONSTRAINT PK_Grupo
PRIMARY KEY (id_grupo)
USING INDEX IX_Grupo_PK;

CREATE INDEX IX_Grupo_Periodo
ON Grupo(id_periodo_academico)
TABLESPACE ts_indices;

CREATE INDEX IX_Grupo_Asignatura
ON Grupo(id_asignatura)
TABLESPACE ts_indices;

-- Grupo Docente

CREATE TABLE Grupo_Docente (
    id_grupo   NUMBER NOT NULL,
    id_docente NUMBER NOT NULL,

    CONSTRAINT FK_GrupoDoc_Grupo
        FOREIGN KEY (id_grupo)
        REFERENCES Grupo(id_grupo),

    CONSTRAINT FK_GrupoDoc_Docente
        FOREIGN KEY (id_docente)
        REFERENCES Docente(id_docente)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_GrupoDocente_PK
ON Grupo_Docente(id_grupo, id_docente)
TABLESPACE ts_indices;

ALTER TABLE Grupo_Docente
ADD CONSTRAINT PK_Grupo_Docente
PRIMARY KEY (id_grupo, id_docente)
USING INDEX IX_GrupoDocente_PK;

CREATE INDEX IX_GrupoDocente_Grupo
ON Grupo_Docente(id_grupo)
TABLESPACE ts_indices;

CREATE INDEX IX_GrupoDocente_Docente
ON Grupo_Docente(id_docente)
TABLESPACE ts_indices;

-- Clase

CREATE TABLE Clase (
    id_clase   NUMBER NOT NULL,
    id_grupo   NUMBER NOT NULL,
    id_aula    NUMBER NOT NULL,
    dia        VARCHAR2(45) NOT NULL,      
    hora_inicio VARCHAR2(5),              
    hora_fin    VARCHAR2(5),               

    CONSTRAINT FK_Clase_Grupo
        FOREIGN KEY (id_grupo)
        REFERENCES Grupo(id_grupo),

    CONSTRAINT FK_Clase_Aula
        FOREIGN KEY (id_aula)
        REFERENCES Aula(id_aula)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_Clase_PK
ON Clase(id_clase)
TABLESPACE ts_indices;

ALTER TABLE Clase
ADD CONSTRAINT PK_Clase
PRIMARY KEY (id_clase)
USING INDEX IX_Clase_PK;

CREATE INDEX IX_Clase_Grupo
ON Clase(id_grupo)
TABLESPACE ts_indices;

CREATE INDEX IX_Clase_Aula
ON Clase(id_aula)
TABLESPACE ts_indices;

-- Configuracion Nota Grupo

CREATE TABLE Configuracion_Nota_Grupo (
    id_configuracion NUMBER NOT NULL,
    id_grupo NUMBER NOT NULL,
    id_tipo_nota NUMBER NOT NULL,
    porcentaje NUMBER NOT NULL,

    CONSTRAINT FK_Conf_Grupo
        FOREIGN KEY (id_grupo)
        REFERENCES Grupo(id_grupo),

    CONSTRAINT FK_Conf_TipoNota
        FOREIGN KEY (id_tipo_nota)
        REFERENCES Tipo_Nota(id_tipo_nota)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_ConfigNota_PK
ON Configuracion_Nota_Grupo(id_configuracion)
TABLESPACE ts_indices;

ALTER TABLE Configuracion_Nota_Grupo
ADD CONSTRAINT PK_ConfigNota
PRIMARY KEY (id_configuracion)
USING INDEX IX_ConfigNota_PK;

-- FK indexes
CREATE INDEX IX_Config_Grupo
ON Configuracion_Nota_Grupo(id_grupo)
TABLESPACE ts_indices;

CREATE INDEX IX_Config_TipoNota
ON Configuracion_Nota_Grupo(id_tipo_nota)
TABLESPACE ts_indices;

-- Auditoria Riesgo

CREATE TABLE Auditoria_Riesgo (
    id_auditoria NUMBER NOT NULL,
    id_estudiante NUMBER NOT NULL,
    id_nivel_riesgo NUMBER NOT NULL,
    id_periodo_academico NUMBER NOT NULL,

    CONSTRAINT FK_AudRiesgo_Estud
        FOREIGN KEY (id_estudiante)
        REFERENCES Estudiante(id_estudiante),

    CONSTRAINT FK_AudRiesgo_Nivel
        FOREIGN KEY (id_nivel_riesgo)
        REFERENCES Nivel_Riesgo(id_nivel_riesgo),
        
    CONSTRAINT FK_AudRiesgo_Periodo
        FOREIGN KEY (id_periodo_academico)
        REFERENCES Periodo_Academico(id_periodo_academico)
) TABLESPACE ts_baja_concurrencia;

CREATE UNIQUE INDEX IX_AudRiesgo_PK
ON Auditoria_Riesgo(id_auditoria)
TABLESPACE ts_indices;

ALTER TABLE Auditoria_Riesgo
ADD CONSTRAINT PK_Auditoria_Riesgo
PRIMARY KEY (id_auditoria)
USING INDEX IX_AudRiesgo_PK;

CREATE INDEX IX_AudRiesgo_Estud
ON Auditoria_Riesgo(id_estudiante)
TABLESPACE ts_indices;

CREATE INDEX IX_AudRiesgo_Nivel
ON Auditoria_Riesgo(id_nivel_riesgo)
TABLESPACE ts_indices;

CREATE INDEX IX_AudRiesgo_Periodo
ON Auditoria_Riesgo(id_periodo_academico)
TABLESPACE ts_indices;

-- Matricula Academica

CREATE TABLE Matricula_Academica (
    id_matricula NUMBER NOT NULL,
    id_periodo_academico NUMBER NOT NULL,
    id_estudiante NUMBER NOT NULL,
    fecha_matricula DATE DEFAULT SYSDATE,

    CONSTRAINT FK_Matr_Periodo
        FOREIGN KEY (id_periodo_academico)
        REFERENCES Periodo_Academico(id_periodo_academico),

    CONSTRAINT FK_Matr_Estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES Estudiante(id_estudiante)
) TABLESPACE ts_alta_concurrencia;

CREATE UNIQUE INDEX IX_Matricula_PK
ON Matricula_Academica(id_matricula)
TABLESPACE ts_indices;

ALTER TABLE Matricula_Academica
ADD CONSTRAINT PK_Matricula
PRIMARY KEY (id_matricula)
USING INDEX IX_Matricula_PK;

CREATE INDEX IX_Matricula_Periodo
ON Matricula_Academica(id_periodo_academico)
TABLESPACE ts_indices;

CREATE INDEX IX_Matricula_Estud
ON Matricula_Academica(id_estudiante)
TABLESPACE ts_indices;

-- Detalle Matricula

CREATE TABLE Detalle_Matricula (
    id_detalle_matricula NUMBER NOT NULL,
    id_matricula NUMBER NOT NULL,
    id_grupo NUMBER NOT NULL,
    nota_definitiva NUMBER(3,1),

    CONSTRAINT FK_DetMat_Matricula
        FOREIGN KEY (id_matricula)
        REFERENCES Matricula_Academica(id_matricula),

    CONSTRAINT FK_DetMat_Grupo
        FOREIGN KEY (id_grupo)
        REFERENCES Grupo(id_grupo)
) TABLESPACE ts_alta_concurrencia;

CREATE UNIQUE INDEX IX_DetalleMat_PK
ON Detalle_Matricula(id_detalle_matricula)
TABLESPACE ts_indices;

ALTER TABLE Detalle_Matricula
ADD CONSTRAINT PK_Detalle_Matricula
PRIMARY KEY (id_detalle_matricula)
USING INDEX IX_DetalleMat_PK;

CREATE INDEX IX_DetMat_Matricula
ON Detalle_Matricula(id_matricula)
TABLESPACE ts_indices;

CREATE INDEX IX_DetMat_Grupo
ON Detalle_Matricula(id_grupo)
TABLESPACE ts_indices;

-- Nota

CREATE TABLE Nota(

    id_nota NUMBER NOT NULL,
    id_config_nota_grupo NUMBER NOT NULL,
    id_detalle_matricula NUMBER NOT NULL,
    resultado NUMBER(3,1) NOT NULL,
    
    CONSTRAINT KF_Nota_ConfigNota
        FOREIGN KEY (id_config_nota_grupo)
        REFERENCES Configuracion_Nota_Grupo (id_configuracion),
        
    CONSTRAINT FK_Nota_DetalleMatricula
        FOREIGN KEY (id_detalle_matricula)
        REFERENCES Detalle_Matricula (id_detalle_matricula)
) TABLESPACE ts_alta_concurrencia;

CREATE UNIQUE INDEX IX_Nota_PK
ON Nota (id_nota)
TABLESPACE ts_indices;

ALTER TABLE Nota
ADD CONSTRAINT PK_Nota
PRIMARY KEY (id_nota)
USING INDEX IX_Nota_PK;

CREATE INDEX IX_Nota_ConfigNota
ON Nota (id_config_nota_grupo)
TABLESPACE ts_indices;

CREATE INDEX IX_Nota_detalleMatricula
ON Nota (id_detalle_matricula)
TABLESPACE  ts_indices;

-- Historial Academico

CREATE TABLE Historial_Academico (
    id_historial NUMBER NOT NULL,
    id_matricula_academica NUMBER NOT NULL,
    creditos_registrados NUMBER NOT NULL,
    creditos_aprobados NUMBER NOT NULL,
    promedio_semestral NUMBER(3,1) NOT NULL,
    promedio_acumulado NUMBER(3,1) NOT NULL,
    
    CONSTRAINT KF_HistorialAca_Matricula
        FOREIGN KEY (id_matricula_academica)
        REFERENCES Matricula_Academica (id_matricula)
) TABLESPACE ts_alta_concurrencia;

CREATE UNIQUE INDEX IX_HistorialAca_PK
ON Historial_Academico (id_historial)
TABLESPACE ts_indices;

ALTER TABLE Historial_Academico
ADD CONSTRAINT PK_historialAcademico
PRIMARY KEY (id_historial)
USING INDEX IX_HistorialAca_PK;

CREATE INDEX IX_HistorialAca_Matricula
ON Historial_Academico (id_matricula_academica)
TABLESPACE ts_indices;

-- Auditoria Operacional

CREATE TABLE Auditoria_Operacional (
    id_auditoria NUMBER NOT NULL,
    usuario VARCHAR2(45),
    rol VARCHAR2(45),
    fecha DATE DEFAULT SYSDATE,
    operacion VARCHAR2(45),
    descripcion VARCHAR2(150),
    entidad_modificada VARCHAR2(45),
    id_registro_modificado VARCHAR2(45),
    ip_origen VARCHAR2(45)
) TABLESPACE ts_alta_concurrencia;

CREATE UNIQUE INDEX IX_AuditoriaOpe
ON Auditoria_Operacional (id_auditoria)
TABLESPACE ts_indices;

ALTER TABLE Auditoria_Operacional
ADD CONSTRAINT PK_Auditoria_Operacional
PRIMARY KEY (id_auditoria)
USING INDEX IX_AuditoriaOpe;

/**
    A cada una de las tablas del usuario DATACAMPUS se le agreagan 3 columnas (fecha_creacion, fecha_actualizacion y estado)
    este ultimo nos sirve para gestionar la base de datos de la mejor manera y no eliminar registros directamnete sino solo 
    pasarlos a un estado inactivo (I) y asi garantizar la integridad de los datos.
**/

DECLARE
    v_sql VARCHAR2(500);
BEGIN
    FOR t IN (
        SELECT table_name 
        FROM user_tables
    ) LOOP
        -- fecha_creacion
        BEGIN
            v_sql := 'ALTER TABLE ' || t.table_name || 
                     ' ADD (fecha_creacion DATE DEFAULT SYSDATE NOT NULL)';
            EXECUTE IMMEDIATE v_sql;
        EXCEPTION
            WHEN OTHERS THEN 
                IF SQLCODE != -01430 THEN  -- columna ya existe
                    RAISE;
                END IF;
        END;
        -- fecha_actualizacion
        BEGIN
            v_sql := 'ALTER TABLE ' || t.table_name || 
                     ' ADD (fecha_actualizacion DATE)';
            EXECUTE IMMEDIATE v_sql;
        EXCEPTION
            WHEN OTHERS THEN 
                IF SQLCODE != -01430 THEN 
                    RAISE;
                END IF;
        END;
        -- estado
        BEGIN
            v_sql := 'ALTER TABLE ' || t.table_name || 
                     ' ADD (estado CHAR(1) DEFAULT ''A'' CHECK (estado IN (''A'', ''I'')))';
            EXECUTE IMMEDIATE v_sql;
        EXCEPTION
            WHEN OTHERS THEN 
                IF SQLCODE != -01430 THEN 
                    RAISE;
                END IF;
        END;
    END LOOP;
END;
/