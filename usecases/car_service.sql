

/****************************************************************************/
/* Change object: GetServiceInfo                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetServiceInfo(
  param_carservice_id BIGINT
) RETURNS TABLE(name CHARACTER,
    adress CHARACTER,
    creation_date TIMESTAMP)
  language sql
as
$$
    SELECT name, adress, creation_date FROM carservice
    WHERE carservice_id = param_carservice_id;
$$;


/****************************************************************************/
/* Change object: GetKaskoInfo                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetKaskoInfo(
  param_kasko_code BIGINT
) RETURNS TABLE(insurance_company_id BIGINT,
            name CHARACTER)
  language sql
as
$$
    SELECT insurance_company_id, name FROM insurance_company
    WHERE kasko_code = param_kasko_code;
$$;


/****************************************************************************/
/* Change object: AddNewRepairOrder                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewRepairOrder(
    param_insurance_company_id BIGINT,
    param_car_id BIGINT,
    param_employee_id BIGINT,
    param_repair_type INT,
    param_repair_part INT,
    param_photo_registration_link CHARACTER,
    param_comment CHARACTER) 
  language sql
as
$$
    INSERT INTO order_repair (insurance_company_id,car_id,employee_id,repair_type,repair_part, photo_registration_link,comment)
    VALUES (param_insurance_company_id, param_car_id, param_employee_id,param_repair_type,param_repair_part, param_photo_registration_link,param_comment);
$$;


