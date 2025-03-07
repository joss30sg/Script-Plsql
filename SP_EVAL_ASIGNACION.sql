/*
      Resumen:
      Este procedimiento actualiza la tabla EVAL_REQ_DETALLE asignando el tipo de gestión
      (n_id_tipo_gestion) y la fecha de gestión (d_fec_gestion) según el valor de n_mto.

      Criterios de asignación:
        - n_mto <= 10: n_id_tipo_gestion = 6
        - 10 < n_mto <= 35: n_id_tipo_gestion = 5
        - 35 < n_mto <= 100: n_id_tipo_gestion = 4
        - n_mto > 100: n_id_tipo_gestion = 3

      Actualizaciones:
        - n_id_tipo_gestion: Asignado según los criterios.
        - d_fec_gestion: Establecido con la fecha y hora actuales (SYSDATE).
    */

CREATE OR REPLACE PACKAGE PKG_EVAL_ASIGNACION IS
  PROCEDURE asignar_tipo_gestion;
END PKG_EVAL_ASIGNACION;
/

CREATE OR REPLACE PACKAGE BODY PKG_EVAL_ASIGNACION IS
  PROCEDURE asignar_tipo_gestion IS
    -- Constantes para los valores de n_id_tipo_gestion
    c_tipo_gestion_6 CONSTANT NUMBER := 6;
    c_tipo_gestion_5 CONSTANT NUMBER := 5;
    c_tipo_gestion_4 CONSTANT NUMBER := 4;
    c_tipo_gestion_3 CONSTANT NUMBER := 3;

    -- Cursor para seleccionar los registros a actualizar
    CURSOR c_eval_req_detalle IS
      SELECT n_id_req_detalle, n_mto
      FROM EVAL_REQ_DETALLE
      FOR UPDATE;

    v_tipo_gestion NUMBER;
  BEGIN
    -- Bucle para recorrer los registros seleccionados
    FOR r_eval_req_detalle IN c_eval_req_detalle LOOP
      -- Asignar el tipo de gestión según el valor de n_mto
      IF r_eval_req_detalle.n_mto <= 10 THEN
        v_tipo_gestion := c_tipo_gestion_6;
      ELSIF r_eval_req_detalle.n_mto > 10 AND r_eval_req_detalle.n_mto <= 35 THEN
        v_tipo_gestion := c_tipo_gestion_5;
      ELSIF r_eval_req_detalle.n_mto > 35 AND r_eval_req_detalle.n_mto <= 100 THEN
        v_tipo_gestion := c_tipo_gestion_4;
      ELSE
        v_tipo_gestion := c_tipo_gestion_3;
      END IF;

      -- Actualizar el registro con el tipo de gestión y la fecha de gestión
      UPDATE EVAL_REQ_DETALLE
      SET n_id_tipo_gestion = v_tipo_gestion,
          d_fec_gestion = SYSDATE
      WHERE CURRENT OF c_eval_req_detalle;
    END LOOP;

    -- Confirmar los cambios
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      -- En caso de error, deshacer los cambios y propagar la excepción
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RAISE;
  END asignar_tipo_gestion;
END PKG_EVAL_ASIGNACION;
/