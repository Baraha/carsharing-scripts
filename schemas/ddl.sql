-- CLIENT

CREATE SEQUENCE IF NOT EXISTS seq_client;

CREATE TABLE
  IF NOT EXISTS client (
    client_id BIGINT DEFAULT nextVal ('seq_client') NOT NULL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth TIMESTAMP NOT NULL,
    INN VARCHAR(255),
    loyalty_level INT,
    driver_licence_ID VARCHAR(20),
    last_update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_client ON client (client_id);

-- CAR

CREATE SEQUENCE IF NOT EXISTS seq_car;

CREATE TABLE
  IF NOT EXISTS car (
    car_id BIGINT DEFAULT nextVal ('seq_car') NOT NULL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    model VARCHAR(255),
    expluatation_expired_date TIMESTAMP NOT NULL,
    serial_code INT,
    car_status INT, -- 1) активный 2) в ремонте 3) Забронирован 4) вышел из эксплуатации 
    client_id BIGINT CONSTRAINT fk_client REFERENCES client (client_id),
    use_type INT, -- для коммерции, основной
    code_kasko VARCHAR(20)
  );

CREATE INDEX IF NOT EXISTS idx1_car ON car (car_id);


-- DISCOUNT

CREATE SEQUENCE IF NOT EXISTS seq_discount;

CREATE TABLE
  IF NOT EXISTS discount (
    discount_id BIGINT DEFAULT nextVal ('seq_discount') NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    discount_percent INT,
    loyalty_level INT,
    usage_type INT, -- good drive style | promocode | first use 
    date_expire TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_discount ON discount (discount_id);


-- CARSERVICE


CREATE SEQUENCE IF NOT EXISTS seq_carservice;

CREATE TABLE
  IF NOT EXISTS carservice (
    carservice_id BIGINT DEFAULT nextVal ('seq_carservice') NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    adress VARCHAR(100),
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_carservice ON carservice (carservice_id);


-- EMPLOYEE

CREATE SEQUENCE IF NOT EXISTS seq_employee;

CREATE TABLE
  IF NOT EXISTS employee (
    employee_id BIGINT DEFAULT nextVal ('seq_employee') NOT NULL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    subdivision_code INT,
    date_of_birth TIMESTAMP NOT NULL,
    work_type VARCHAR(100),
    loyalty_level INT,
    carservice_id  BIGINT CONSTRAINT fk_carservice REFERENCES carservice (carservice_id) 
  );

CREATE INDEX IF NOT EXISTS idx1_employee ON employee (employee_id);


-- INSURANCE COMPANY

CREATE SEQUENCE IF NOT EXISTS seq_insurance_company;

CREATE TABLE
  IF NOT EXISTS insurance_company (
    insurance_company_id BIGINT DEFAULT nextVal ('seq_insurance_company') NOT NULL PRIMARY KEY,
    kasko_code INT NOT NULL,
    name VARCHAR(100) NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_insurance_company ON insurance_company (insurance_company_id);


-- ORDER VIOLATION

CREATE SEQUENCE IF NOT EXISTS  seq_order_violation;

CREATE TABLE 
    IF NOT EXISTS order_violation (
    order_violation_id BIGINT DEFAULT nextVal ('seq_order_violation') NOT NULL PRIMARY KEY,
    fine_pay FLOAT NOT NULL,
    client_id BIGINT CONSTRAINT fk_client REFERENCES client (client_id),
    violation_code INT,
    code_GIBDD_department INT NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_order_violation ON order_violation (order_violation_id);

-- ORDER REPAIR

CREATE SEQUENCE IF NOT EXISTS  seq_order_repair;

CREATE TABLE
  IF NOT EXISTS order_repair (
    order_repair_id BIGINT DEFAULT nextVal ('seq_order_repair') NOT NULL PRIMARY KEY,
    insurance_company_id BIGINT CONSTRAINT fk_insurance_company REFERENCES insurance_company (insurance_company_id),
    car_id  BIGINT CONSTRAINT fk_car REFERENCES car (car_id),
    employee_id BIGINT CONSTRAINT fk_employee REFERENCES employee (employee_id),
    repair_part INT NOT NULL, -- | Капот, Бампер, Крыша, Колеса, Левое крыло, Правое крыло, Задние фары, Передние фары, Стекла, Салон, Внутренняя поломка
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    repair_type INT, -- мойка, замена запчастей, снятие с эксплуатации
    photo_registration_link VARCHAR(100) NOT NULL,
    comment VARCHAR(256) NOT NULL
  );

CREATE INDEX IF NOT EXISTS idx1_order_repair ON order_repair (order_repair_id);


-- USAGE CAR HISTORY

CREATE SEQUENCE IF NOT EXISTS seq_usage_car_history;

CREATE TABLE
  IF NOT EXISTS usage_car_history (
    usage_car_history_id BIGINT DEFAULT nextVal ('seq_usage_car_history') NOT NULL PRIMARY KEY,
    discount_id BIGINT CONSTRAINT fk_discount  REFERENCES discount (discount_id),
    car_id BIGINT CONSTRAINT fk_car REFERENCES car (car_id),
    client_id BIGINT CONSTRAINT fk_client REFERENCES client (client_id),
    creation_order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    stop_order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    avg_speed INT DEFAULT 80,
    agression_drive_level INT -- (от 1 до 10)
  );

CREATE INDEX IF NOT EXISTS idx1_usage_car_history ON usage_car_history (usage_car_history_id);


-- REPAIR CAR HISTORY

CREATE SEQUENCE IF NOT EXISTS seq_repair_car_history;

CREATE TABLE
  IF NOT EXISTS repair_car_history (
    repair_car_history_id BIGINT DEFAULT nextVal ('seq_repair_car_history') NOT NULL PRIMARY KEY,
    employee_id BIGINT CONSTRAINT fk_employee REFERENCES employee (employee_id),
    car_id BIGINT CONSTRAINT fk_car REFERENCES car (car_id),
    carservice_id BIGINT CONSTRAINT fk_carservice REFERENCES carservice (carservice_id),
    serial_code INT,
    repair_fee FLOAT,
    repair_type INT -- мойка, замена запчастей, снятие с эксплуатации
  );

CREATE INDEX IF NOT EXISTS idx1_repair_car_history ON repair_car_history (repair_car_history_id);

