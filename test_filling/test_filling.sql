

-- CLIENT

CALL AddNewClient('Михаил Михайлов Абрамович', '1970-01-01 00:00:00'::timestamp, '111-111',2,'999999 999');
CALL AddNewClient('Артем Артемов Артемович', '1990-01-02 22:10:00'::timestamp, '322-111',1,'924299 999');
CALL AddNewClient('Егор Егорин Егоров', '1992-11-03 12:20:00'::timestamp, '123-911',1,'999999 999');
CALL AddNewClient('Ян Янин Янович', '1981-12-01 09:30:20'::timestamp, '231-211',2,'12121 999');
CALL AddNewClient('Ибрагим Ибрагимов Ибрагимович', '1970-01-01 00:00:00'::timestamp, '111-111',2,'999999 999');
CALL AddNewClient('Антон Антонов Антонович', '1992-01-01 02:12:00'::timestamp, '141-121',2,'900999 999');
CALL AddNewClient('Степан Степанов Степанович', '1920-10-01 00:22:00'::timestamp, '888-111',3,'999999 999');
CALL AddNewClient('Афросий Мало Михалович', '1920-01-02 00:00:00'::timestamp, '121-101',2,'92299 929');

CALL AddNewClient('Афросий Мало Михалович', '1920-01-02 00:00:00'::timestamp, '121-101',2,'92299 929');

-- CAR

CALL AddNewCar('Audi', 'A1',1121123, 1, 1,'1211-1231','2030-01-02 00:00:00');
CALL AddNewCar('Audi', 'A7',1121123, 1,1, '1211-1231','2031-12-10 00:00:00');
CALL AddNewCar('BMW', 'M5',1122345, 1, 1,'1211-1231','2031-12-10 00:00:00');
CALL AddNewCar('Ford', 'Focus',4125121, 1,1, '1211-1231','2031-10-10 00:00:00');
CALL AddNewCar('Ford', 'Mustang',1121003, 2,1, '1211-1231','2041-10-10 00:00:00');
CALL AddNewCar('Kia', 'K5',11211223, 2,1, '1211-1231','2041-12-10 00:00:00');

-- DISCOUNT

CALL AddNewDiscount('base discount',50,5,2, '2030-01-02 00:00:00'::timestamp);
CALL AddNewDiscount('advanced discount',5,4,1, '2030-01-02 00:00:00'::timestamp);

-- CARSERVICE

INSERT INTO carservice (name,adress)
VALUES ('Хороший сервис','Новомосковская Д.22'),
    ('Коммерческий сервис','Новомосковская Д.25');

INSERT INTO employee (full_name,subdivision_code,
date_of_birth,work_type,loyalty_level,carservice_id)
VALUES ('Павлов Петр Артемович',10,'2001-02-10','Механик', 2, 2);

INSERT INTO employee (full_name,subdivision_code,
date_of_birth,work_type,loyalty_level,carservice_id)
VALUES ('Павлов Максим Артемович',5,'1980-02-10','Главный механик', 2, 2);

INSERT INTO insurance_company (name,kasko_code)
VALUES ('Страховая компания ТРАНС',1241211);

INSERT INTO insurance_company (name,kasko_code)
VALUES ('Страховая компания ЭКСТРА',1001);