
/****************************************************************************/
/* Change object: GetDiscount                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetDiscount(
  param_discount_id BIGINT
) RETURNS TABLE(name CHARACTER,
    discount_percent INT,
    loyalty_level INT,
    usage_type INT,
    date_expire TIMESTAMP)
  language sql
as
$$
    SELECT name, discount_percent, loyalty_level, usage_type,date_expire FROM discount
    WHERE discount_id = param_discount_id;
$$;

/****************************************************************************/
/* Change object: AddNewDiscount                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewDiscount(
    param_name CHARACTER,
    param_discount_percent INT,
    param_loyalty_level INT,
    param_usage_type INT,
    param_date_expire TIMESTAMP) 
  language sql
as
$$
    INSERT INTO discount (name, discount_percent, loyalty_level, usage_type, date_expire)
    VALUES (param_name, param_discount_percent, param_loyalty_level, param_usage_type,param_date_expire);
$$;

