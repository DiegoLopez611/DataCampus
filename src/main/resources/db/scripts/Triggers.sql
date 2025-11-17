/*
    Se crean los triggers necesarios para poder hacer que las llaves primarias de las tablas sean autoincrementabes,
    haciendo uso de las secunecias definidas en el archivo Sequences.sql; esta implementación se hace necesario ya que
    la versión del motor oracle sql no soporta alternativas más robustas y ligeras en implementación.
 */

CREATE OR REPLACE TRIGGER trg_matricula_academica_ai
BEFORE INSERT ON Matricula_Academica
FOR EACH ROW
BEGIN
    IF :NEW.id_matricula IS NULL THEN
        :NEW.id_matricula := seq_matricula_academica.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_detalle_matricula_ai
BEFORE INSERT ON Detalle_Matricula
FOR EACH ROW
BEGIN
    IF :NEW.id_detalle_matricula IS NULL THEN
        :NEW.id_detalle_matricula := seq_detalle_matricula.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_nota_ai
BEFORE INSERT ON Nota
FOR EACH ROW
BEGIN
    IF :NEW.id_nota IS NULL THEN
        :NEW.id_nota := seq_nota.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_auditoria_operacional_ai
BEFORE INSERT ON Auditoria_Operacional
FOR EACH ROW
BEGIN
    IF :NEW.id_auditoria IS NULL THEN
        :NEW.id_auditoria := seq_auditoria_operacional.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_historial_academico_ai
BEFORE INSERT ON Historial_Academico
FOR EACH ROW
BEGIN
    IF :NEW.id_historial IS NULL THEN
        :NEW.id_historial := seq_historial_academico.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_estudiante_ai
BEFORE INSERT ON Estudiante
FOR EACH ROW
BEGIN
    IF :NEW.id_estudiante IS NULL THEN
        :NEW.id_estudiante := seq_estudiante.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_docente_ai
BEFORE INSERT ON Docente
FOR EACH ROW
BEGIN
    IF :NEW.id_docente IS NULL THEN
        :NEW.id_docente := seq_docente.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_configuracion_nota_grupo_ai
BEFORE INSERT ON Configuracion_Nota_Grupo
FOR EACH ROW
BEGIN
    IF :NEW.id_configuracion_nota_grupo IS NULL THEN
        :NEW.id_configuracion_nota_grupo := seq_configuracion_nota_grupo.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_auditoria_riesgo_ai
BEFORE INSERT ON Auditoria_Riesgo
FOR EACH ROW
BEGIN
    IF :NEW.id_auditoria IS NULL THEN
        :NEW.id_auditoria := seq_auditoria_riesgo.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_estudio_ai
BEFORE INSERT ON Estudio
FOR EACH ROW
BEGIN
    IF :NEW.id_estudio IS NULL THEN
        :NEW.id_estudio := seq_estudio.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_institucion_educativa_ai
BEFORE INSERT ON Institucion_Educativa
FOR EACH ROW
BEGIN
    IF :NEW.id_institucion IS NULL THEN
        :NEW.id_institucion := seq_institucion_educativa.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_grupo_ai
BEFORE INSERT ON Grupo
FOR EACH ROW
BEGIN
    IF :NEW.id_grupo IS NULL THEN
        :NEW.id_grupo := seq_grupo.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_clase_ai
BEFORE INSERT ON Clase
FOR EACH ROW
BEGIN
    IF :NEW.id_clase IS NULL THEN
        :NEW.id_clase := seq_clase.NEXTVAL;
END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_departamento_ai
BEFORE INSERT ON Departamento
FOR EACH ROW
BEGIN
    IF :NEW.id_departamento IS NULL THEN
        :NEW.id_departamento := seq_departamento.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_municipio_ai
BEFORE INSERT ON Municipio
FOR EACH ROW
BEGIN
    IF :NEW.id_municipio IS NULL THEN
        :NEW.id_municipio := seq_municipio.NEXTVAL;
END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_tipo_programa_ai
BEFORE INSERT ON Tipo_Programa
FOR EACH ROW
BEGIN
    IF :NEW.id_tipo_programa IS NULL THEN
        :NEW.id_tipo_programa := seq_tipo_programa.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_tipo_asignatura_ai
BEFORE INSERT ON Tipo_Asignatura
FOR EACH ROW
BEGIN
    IF :NEW.id_tipo_asignatura IS NULL THEN
        :NEW.id_tipo_asignatura := seq_tipo_asignatura.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_programa_academico_ai
BEFORE INSERT ON Programa_Academico
FOR EACH ROW
BEGIN
    IF :NEW.id_programa_academico IS NULL THEN
        :NEW.id_programa_academico := seq_programa_academico.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_facultad_ai
BEFORE INSERT ON Facultad
FOR EACH ROW
BEGIN
    IF :NEW.id_facultad IS NULL THEN
        :NEW.id_facultad := seq_facultad.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_sede_ai
BEFORE INSERT ON Sede
FOR EACH ROW
BEGIN
    IF :NEW.id_sede IS NULL THEN
        :NEW.id_sede := seq_sede.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_periodo_academico_ai
BEFORE INSERT ON Periodo_Academico
FOR EACH ROW
BEGIN
    IF :NEW.id_periodo_academico IS NULL THEN
        :NEW.id_periodo_academico := seq_periodo_academico.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_tipo_nota_ai
BEFORE INSERT ON Tipo_Nota
FOR EACH ROW
BEGIN
    IF :NEW.id_tipo_nota IS NULL THEN
        :NEW.id_tipo_nota := seq_tipo_nota.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_nivel_riesgo_ai
BEFORE INSERT ON Nivel_Riesgo
FOR EACH ROW
BEGIN
    IF :NEW.id_nivel_riesgo IS NULL THEN
        :NEW.id_nivel_riesgo := seq_nivel_riesgo.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_asignatura_ai
BEFORE INSERT ON Asignatura
FOR EACH ROW
BEGIN
    IF :NEW.id_asignatura IS NULL THEN
        :NEW.id_asignatura := seq_asignatura.NEXTVAL;
END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_asignatura_especial_ai
BEFORE INSERT ON Asignatura_Especial
FOR EACH ROW
BEGIN
    IF :NEW.id_asignatura_especial IS NULL THEN
        :NEW.id_asignatura_especial := seq_asignatura_especial.NEXTVAL;
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_aula_ai
BEFORE INSERT ON Aula
FOR EACH ROW
BEGIN
    IF :NEW.id_aula IS NULL THEN
        :NEW.id_aula := seq_aula.NEXTVAL;
END IF;
END;
/

