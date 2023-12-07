CREATE TABLE IF NOT EXISTS Employees
(
    emp_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    emp_name       VARCHAR(100),
    emp_last_name  VARCHAR(100),
    emp_patronymic VARCHAR(100),
    emp_position   INTEGER REFERENCES Positions (pos_id),
    emp_phone      INTEGER(11) UNIQUE,
    emp_birth_date DATE,
    emp_mail       TEXT UNIQUE
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
    --- 42-44
    prod_size          varchar(5)
);

CREATE TABLE IF NOT EXISTS Clients
(
    cl_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    cl_name       VARCHAR(100),
    cl_last_name  VARCHAR(100),
    cl_patronymic VARCHAR(100),
    cl_address    TEXT,
    cl_phone      INTEGER UNIQUE
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
    size_id INTEGER PRIMARY KEY AUTOINCREMENT,
    prod_id INTEGER REFERENCES Products (prod_id)
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

DROP TABLE Clients;
DROP TABLE Brands;
DROP TABLE Color;
DROP TABLE Materials;
DROP TABLE Employees;
DROP TABLE Positions;
DROP TABLE Products;

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
VALUES ('Курьер')
