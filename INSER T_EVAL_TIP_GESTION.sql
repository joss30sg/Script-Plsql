-- Creación de la tabla EVAL_TIP_GESTION
CREATE TABLE EVAL_TIP_GESTION (
  N_ID_TIPO_GESTION NUMBER PRIMARY KEY,
  C_DESCRIPCION VARCHAR2(100),
  N_PESO NUMBER(9), 
  N_ESTADO VARCHAR2(10),
  C_USU_REGISTRO VARCHAR2(30),
  D_FEC_REGISTRO TIMESTAMP
);

-- Secuencia para el campo n_id_tipo_gestion 
  CREATE SEQUENCE  SEQ_I_TIP_GESTION 
  START WITH 1
  INCREMENT BY 1;

-- Insertar datos de ejemplo
INSERT INTO EVAL_TIP_GESTION (N_ID_TIPO_GESTION, C_DESCRIPCION, N_PESO, N_ESTADO, C_USU_REGISTRO, D_FEC_REGISTRO)
VALUES (3, 'Gestión de visa', 60, 1, 'GNOAIN', TO_TIMESTAMP('2018-11-19 21:19:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO EVAL_TIP_GESTION (N_ID_TIPO_GESTION, C_DESCRIPCION, N_PESO, N_ESTADO, C_USU_REGISTRO, D_FEC_REGISTRO)
VALUES (4, 'Gestión MC', 50, 1, 'GNOAIN', TO_TIMESTAMP('2018-11-19 21:19:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO EVAL_TIP_GESTION (N_ID_TIPO_GESTION, C_DESCRIPCION, N_PESO, N_ESTADO, C_USU_REGISTRO, D_FEC_REGISTRO)
VALUES (5, 'Contracargo visa', 0, 1, 'GNOAIN', TO_TIMESTAMP('2018-11-19 21:19:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO EVAL_TIP_GESTION (N_ID_TIPO_GESTION, C_DESCRIPCION, N_PESO, N_ESTADO, C_USU_REGISTRO, D_FEC_REGISTRO)
VALUES (6, 'Contracargo MC', 0, 1, 'GNOAIN', TO_TIMESTAMP('2018-11-19 21:19:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Confirmar los cambios
COMMIT;