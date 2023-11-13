
/****************************************************************************/
/* Change object: GetCarHistoryInfo                   */
/****************************************************************************/

CREATE OR REPLACE FUNCTION GetCarHistoryInfo(
        param_car_id BIGINT
) RETURNS TABLE(discount_name CHARACTER, discount_percent INT, discount_usage_type INT,
                car_company_name CHARACTER, car_model CHARACTER,  car_status INT, car_serial_code INT,
                client_full_name CHARACTER, client_loyalty_level INT, client_driver_license_id CHARACTER,
                creation_order_date TIMESTAMP, stop_order_date TIMESTAMP,
                agression_drive_level int, avg_speed int)
  language sql
AS
$$
    -- DISCOUNT
    SELECT discount_data.name as discount_name,
        discount_data.discount_percent as discount_percent,
        discount_data.usage_type as discount_usage_type,
    -- CAR
        car_data.company_name as car_company_name,
        car_data.model as car_model,
        car_data.car_status as car_status,
        car_data.serial_code as car_serial_code,
    -- CLIENT
        client_data.full_name  as client_full_name ,
        client_data.loyalty_level  as client_loyalty_level ,
        client_data.driver_licence_id  as client_driver_license_id,
    -- HISTORY
        hist_data.creation_order_date as creation_order_date,
        hist_data.stop_order_date as stop_order_date,
        hist_data.agression_drive_level as agression_drive_level,
        hist_data.avg_speed as avg_speed
    FROM usage_car_history AS hist_data

        INNER JOIN discount discount_data ON
        discount_data.discount_id = hist_data.discount_id

        INNER JOIN car car_data ON
        car_data.car_id = hist_data.car_id

        INNER JOIN client client_data ON
        client_data.client_id = hist_data.client_id

    WHERE hist_data.car_id = param_car_id;
$$;


/****************************************************************************/
/* Change object: GetCarServiceHistoryInfo                   */
/****************************************************************************/

CREATE OR REPLACE FUNCTION GetCarServiceHistoryInfo(
        param_car_id BIGINT
) RETURNS TABLE(employee_full_name CHARACTER, employee_subdivision_code INT, employee_loyalty_level INT,
                car_company_name CHARACTER, car_model CHARACTER,  car_status INT, car_serial_code INT,
                carservice_name CHARACTER, serial_code INT, repair_fee FLOAT, repair_type INT)
  language sql
AS
$$
    -- EMPLOYEE
    SELECT employee_data.full_name as employee_full_name,
        employee_data.subdivision_code as employee_subdivision_code,
        employee_data.loyalty_level as employee_loyalty_level,
    -- CAR
        car_data.company_name as car_company_name,
        car_data.model as car_model,
        car_data.car_status as car_status,
        car_data.serial_code as car_serial_code,
    -- CARSERVICE
        carservice_data.name  as carservice_name ,
    -- HISTORY
        hist_data.serial_code as serial_code,
        hist_data.repair_fee as repair_fee,
        hist_data.repair_type as repair_type
    FROM repair_car_history AS hist_data
        INNER JOIN employee employee_data ON
        employee_data.employee_id = hist_data.employee_id

        INNER JOIN car car_data ON
        car_data.car_id = hist_data.car_id

        INNER JOIN carservice carservice_data ON
        carservice_data.carservice_id = hist_data.carservice_id

    WHERE hist_data.car_id = param_car_id;
$$;