import random
import sqlite3
import datetime

from faker import Faker
from russian_names import RussianNames

fake = Faker(['ru_RU', 'en_US'])
max_count = int(input("Введите максимальное количество записей:\n"))

connection = sqlite3.connect('identifier.sqlite')
cursor = connection.cursor()

cursor.execute('SELECT COUNT(*) FROM Materials')
count_materials = cursor.fetchone()[0]

# Если не создавать размеры вручную, то нужно использовать это.
"""Создание размеров"""
print("Создание размеров")
for s_size in range(40, 100 - 2 + 1):
    s_size = f'{s_size}-{s_size - 2}'
    cursor.execute(
        'INSERT INTO Size (size_size) VALUES (?)',
        (s_size,)
    )

cursor.execute('SELECT COUNT(*) FROM Size')
count_sizes = cursor.fetchone()[0]

cursor.execute('SELECT COUNT(*) FROM Positions')
count_positions = cursor.fetchone()[0]

cursor.execute('SELECT COUNT(*) FROM Color')
count_color = cursor.fetchone()[0]

rn = RussianNames(count=1, name=False, surname=False)

print("Создание записей для аккаунтов")
"""Создание записей для аккаунтов"""
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Clients (cl_name, cl_last_name, cl_patronymic, cl_address, cl_phone)'
        'VALUES (?, ?, ?, ?, ?)',
        (fake.first_name(), fake.last_name(), rn.get_person(), fake.address(),
         fake.phone_number()))

print("Создание записей для брендов")
"""Создание записей для брендов"""
print("-Создание компаний")
mass_company_unique = set()
for _ in range(1, max_count + 1):
    mass_company_unique.add(fake.company())

print("-Заполнение компаний")
for company in mass_company_unique:
    cursor.execute(
        'INSERT INTO Brands (brand_name, brand_description)'
        'VALUES (?, ?)',
        (company, fake.paragraph(nb_sentences=6))
    )

print("Создание записей для сотрудников")
"""Создание записей для сотрудников"""
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Employees (emp_name, emp_last_name, emp_patronymic,'
        ' emp_position, emp_phone, emp_birth_date, emp_mail)'
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        (fake.first_name(), fake.last_name(), rn.get_person(), random.randrange(1, count_positions + 1),
         fake.phone_number(), fake.date(), fake.ascii_email())
    )

print("Создание записей о товарах")
"""Создание записей о товарах"""
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Products (prod_name, prod_desc, prod_count, prod_price, prod_color, prod_material, prod_size)'
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        (fake.first_name(), fake.paragraph(nb_sentences=3), random.randrange(1, 10 ** 4),
         random.randrange(10 ** 3, 10 ** 4), random.randrange(1, count_color), random.randrange(1, count_materials),
         random.randrange(1, count_sizes + 1))
    )

print("Создание записей о заказах")
"""Создание записей о заказах"""
date_1 = datetime.date(year=2004, month=7, day=23)
date_2 = datetime.date(year=2020, month=2, day=23)
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Orders (ord_client, ord_product, ord_date, ord_dev_date) VALUES (?, ?, ?, ?)',
        (random.randrange(1, max_count), random.randrange(1, max_count),
         fake.date_between(start_date=date_1, end_date=date_2), fake.date_between(start_date=date_2))
    )

connection.commit()
connection.close()

input("\n\nЗапись данных успешно завершена!\n\n\nНАЖМИТЕ ЛЮБУЮ КЛАВИШУ ДЛЯ ВЫХОДА...")
