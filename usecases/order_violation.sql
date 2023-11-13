
/****************************************************************************/
/* Change object: AddNewOrderViolation                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewOrderViolation(
    param_fine_pay FLOAT,
    param_client_id BIGINT,
    param_violation_code INT,
    param_code_gibdd_department INT)
  language sql
as
$$
    INSERT INTO order_violation (fine_pay, client_id, violation_code, code_gibdd_department)
    VALUES (param_fine_pay, param_client_id, param_violation_code, param_code_gibdd_department);
$$;



/****************************************************************************/
/* Change object: GetUserViolations                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetUserViolations(
  param_client_id BIGINT
) RETURNS TABLE(
    order_violation_id BIGINT,
    fine_pay FLOAT,
    violation_code INT,
    code_gibdd_department INT)
  language sql
as
$$
    SELECT 
        order_violation_id,
        fine_pay,  
        violation_code,
        code_gibdd_department 
        FROM order_violation
    WHERE client_id = param_client_id;
$$;


/****************************************************************************/
/* Change object: GetAllViolations                   */
/****************************************************************************/

CREATE OR REPLACE VIEW GetAllViolations AS
    SELECT 
        order_violation_id,
        fine_pay,  
        client_id,
        violation_code,
        code_gibdd_department 
        FROM order_violation; 