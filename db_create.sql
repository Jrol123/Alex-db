DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Brands;
DROP TABLE IF EXISTS Color;
DROP TABLE IF EXISTS Materials;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Positions;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Size;

CREATE TABLE IF NOT EXISTS Employees
(
    emp_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    emp_name       VARCHAR(100),
    emp_last_name  VARCHAR(100),
    emp_patronymic VARCHAR(100),
    emp_position   INTEGER REFERENCES Positions (pos_id),
    -- Убираю Unique для генерации
    emp_phone      INTEGER(11),
    emp_birth_date DATE,
    -- Убираю Unique для генерации
    emp_mail       TEXT
);

CREATE TABLE IF NOT EXISTS Positions
(
    pos_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    pos_name TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS Products
(
    prod_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    prod_name     varchar(100),
    prod_desc     TEXT,
    prod_count    INTEGER,
    prod_price    REAL,
    prod_color    INTEGER REFERENCES Color (color_id),
    prod_material INTEGER REFERENCES Materials (material_id),
    prod_size     INTEGER REFERENCES Size (size_id)
);

CREATE TABLE IF NOT EXISTS Clients
(
    cl_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    cl_name       VARCHAR(100),
    cl_last_name  VARCHAR(100),
    cl_patronymic VARCHAR(100),
    cl_address    TEXT,
    -- Убираю Unique для генерации
    cl_phone      INTEGER
);

CREATE TABLE IF NOT EXISTS Orders
(
    ord_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    ord_client   INTEGER REFERENCES Clients (cl_id),
    ord_product  INTEGER REFERENCES Products (prod_id),
    ord_date     DATE,
    ord_dev_date DATE
);

CREATE TABLE IF NOT EXISTS Size
(
    size_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    --- 42-44
    size_size varchar(5) UNIQUE
);

CREATE TABLE IF NOT EXISTS Brands
(
    brand_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    brand_name        varchar(100) UNIQUE,
    brand_description TEXT
);

CREATE TABLE IF NOT EXISTS Color
(
    color_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    color_name varchar(20)
);

CREATE TABLE IF NOT EXISTS Materials
(
    material_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    material_name varchar(50)
);



INSERT INTO Color (color_name)
VALUES ('Хаки');
INSERT INTO Color (color_name)
VALUES ('Красный');
INSERT INTO Color (color_name)
VALUES ('Белый');
INSERT INTO Color (color_name)
VALUES ('Чёрный');
INSERT INTO Color (color_name)
VALUES ('Пятый алимент');

INSERT INTO Materials (material_name)
VALUES ('Кожа');
INSERT INTO Materials (material_name)
VALUES ('Мех');
INSERT INTO Materials (material_name)
VALUES ('Шкура лунного песца');

INSERT INTO Positions (pos_name)
VALUES ('Стажёр');
INSERT INTO Positions (pos_name)
VALUES ('Продавец');
INSERT INTO Positions (pos_name)
VALUES ('Босс');
INSERT INTO Positions (pos_name)
VALUES ('Курьер');