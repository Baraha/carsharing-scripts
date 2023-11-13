
/****************************************************************************/
/* Change object: GetDiscount                   */
/****************************************************************************/
CREATE OR REPLACE FUNCTION GetDiscount(
  param_discount_id BIGINT
) RETURNS TABLE(name CHARACTER,
    discount_percent INT,
    work_type CHARACTER,
    loyalty_level INT,
    usage_type INT,
    date_expire TIMESTAMP)
  language sql
as
$$
    SELECT name, discount_percent,work_type, loyalty_level, usage_type,date_expire FROM discount
    WHERE discount_id = param_discount_id;
$$;

/****************************************************************************/
/* Change object: AddNewDiscount                   */
/****************************************************************************/
CREATE OR REPLACE PROCEDURE AddNewDiscount(
    param_discount_percent INT,
    param_work_type CHARACTER,
    param_loyalty_level INT,
    param_usage_type INT,
    param_date_expire TIMESTAMP) 
  language sql
as
$$
    INSERT INTO discount (discount_percent, work_type, loyalty_level, usage_type, date_expire)
    VALUES (param_discount_percent, param_work_type, param_loyalty_level, param_usage_type,param_date_expire);
$$;

