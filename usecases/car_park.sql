
/****************************************************************************/
/* Change object: AddNewCar                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewCar(
    param_company_name CHARACTER,
    param_model CHARACTER,
    param_serial_code INT,
    param_car_status INT,
    param_use_type INT,
    param_code_kasko CHARACTER,
    param_exp_expired_day TIMESTAMP)
  language sql
as
$$
    INSERT INTO car (company_name,  model, serial_code, use_type, car_status, code_kasko,expluatation_expired_date)
    VALUES (param_company_name, param_model, param_serial_code, param_use_type, param_car_status, param_code_kasko, param_exp_expired_day);
$$;


/****************************************************************************/
/* Change object: AddNewCar                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetCarInfo(
    param_car_id BIGINT)
    RETURNS TABLE(
        company_name CHARACTER,
        model CHARACTER,
        serial_code INT,
        use_type INT,
        code_kasko CHARACTER
    )
  language sql
as
$$
    SELECT company_name,
        model,
        serial_code,
        use_type, 
        code_kasko
        FROM car
    WHERE car_id = param_car_id;
$$;


/****************************************************************************/
/* Change object: GetCarSerialNumber                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetCarSerialNumber(
    param_car_id BIGINT)
    RETURNS INT
  language sql
as
$$
    SELECT 
        serial_code
        FROM car
    WHERE car_id = param_car_id;
$$;


/****************************************************************************/
/* Change object: GetKaskoCode                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetKaskoCode(
    param_car_id BIGINT)
    RETURNS CHARACTER
  language sql
as
$$
    SELECT 
        code_kasko
        FROM car
    WHERE car_id = param_car_id;
$$;

/****************************************************************************/
/* Change object: GetCarStatus                   */
/****************************************************************************/

CREATE OR REPLACE FUNCTION GetCarStatus(
    param_car_id BIGINT)
    RETURNS CHARACTER
  language sql
as
$$
    SELECT 
        car_status
        FROM car
    WHERE car_id = param_car_id;
$$;


/****************************************************************************/
/* Change object: BookingCar                   */
/****************************************************************************/

CREATE OR REPLACE PROCEDURE BookingCar(
    param_car_id BIGINT, param_client_id BIGINT)
  language sql
as
$$ 
    UPDATE car 
    SET car_status = 3, client_id = param_client_id
    WHERE car_id = param_car_id;
$$;

/****************************************************************************/
/* Change object: UnBookingCar                   */
/****************************************************************************/

CREATE OR REPLACE PROCEDURE UnBookingCar(
    param_car_id BIGINT)
  language sql
as
$$ 
    UPDATE car 
    SET car_status = 1, client_id = NULL
    WHERE car_id = param_car_id;
$$;



/****************************************************************************/
/* Change object: BookingCar                   */
/****************************************************************************/

CREATE OR REPLACE PROCEDURE BookingCar(
    param_car_id BIGINT, param_car_status INT)
  language sql
as
$$
    UPDATE car 
    SET car_status = param_car_status
    WHERE car_id = param_car_id;
$$;

/****************************************************************************/
/* Change object: CheckAndDeleteExparedCars                   */
/****************************************************************************/

CREATE OR REPLACE FUNCTION CheckAndDeleteExparedCars() RETURNS TRIGGER 
    AS $trigger$
    DECLARE
        ps_row RECORD; -- Обьявеление типа строки
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            -- Проверить, обновляемый обьект не с устаревшей датой или в заблокированном статусе
            SELECT expluatation_expired_date, car_status INTO ps_row FROM car WHERE car_id = NEW.car_id;
             IF (ps_row.expluatation_expired_date < NOW() OR ps_row.car_status = 4 ) THEN

                DELETE FROM car WHERE car_id = NEW.car_id;
                RAISE EXCEPTION 'тс вышел из эксплуатации';
            END IF;
        END IF;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;

/****************************************************************************/
/* Change object: DeleteOldCars                   */
/****************************************************************************/

CREATE OR REPLACE TRIGGER DeleteOldCars BEFORE UPDATE ON car
        FOR EACH ROW EXECUTE PROCEDURE CheckAndDeleteExparedCars();
