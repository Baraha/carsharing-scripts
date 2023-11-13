
/****************************************************************************/
/* Change object: GetClientInfo            */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetClientInfo(
  param_client_id BIGINT
) RETURNS TABLE(full_name CHARACTER,
    date_of_birth CHARACTER,
    INN character,
   loyalty_level INT,
    driver_licence_ID CHARACTER varying)
  language sql
as
$$
    SELECT full_name, 
    TO_CHAR(date_of_birth,'YYYY-MM-DD'),
    INN,
    loyalty_level,
    driver_licence_ID FROM client
    WHERE client_id = param_client_id
;
$$;

/****************************************************************************/
/* Change object: GetClientID                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetClientID(
  param_full_name CHARACTER
) RETURNS BIGINT
  language sql
as
$$
    SELECT client_id FROM client
    WHERE full_name = param_full_name;
$$;

/****************************************************************************/
/* Change object: GetGIBDDInfo                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetGIBDDInfo(
  param_client_id BIGINT
) RETURNS TABLE(full_name CHARACTER,
    date_of_birth CHARACTER,
    INN character,
    driver_licence_ID CHARACTER)
  language sql
as
$$
    SELECT full_name,date_of_birth, inn, driver_licence_id FROM client
    WHERE client_id = param_client_id;
$$;


/****************************************************************************/
/* Change object: AddNewClient                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewClient(
    param_full_name CHARACTER,
    param_date_of_birth TIMESTAMP,
    param_INN character,
    param_loyalty_level INT,
    param_driver_licence_ID CHARACTER) 
  language sql
as
$$
    INSERT INTO client (full_name,date_of_birth,inn,loyalty_level, driver_licence_id)
    VALUES (param_full_name, param_date_of_birth, param_INN,param_loyalty_level, param_driver_licence_ID);
$$;


/****************************************************************************/
/* Change object: UpdateClientData                   */
/****************************************************************************/

CREATE OR REPLACE PROCEDURE UpdateClientData(
    param_client_id BIGINT,
    param_full_name CHARACTER,
    param_date_of_birth TIMESTAMP,
    param_INN character,
    param_loyalty_level INT,
    param_driver_licence_ID CHARACTER) 
  language sql
as
$$
    
    UPDATE client 
    SET 
    full_name = param_full_name, 
    date_of_birth = param_date_of_birth, 
    inn = param_INN,
    loyalty_level = param_loyalty_level, driver_licence_id = param_driver_licence_ID,
    last_update_date =  NOW()
    WHERE client_id = param_client_id;
$$;