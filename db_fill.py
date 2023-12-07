import sqlite3, random, datetime
from russian_names import RussianNames
from faker import Faker

fake = Faker(['ru_RU', 'en_US'])
max_count = 10 ** 1

connection = sqlite3.connect('identifier.sqlite')
cursor = connection.cursor()

cursor.execute('SELECT COUNT(*) FROM Materials')
count_materials = cursor.fetchone()[0]

cursor.execute('SELECT COUNT(*) FROM Size')
count_sizes = cursor.fetchone()[0]

cursor.execute('SELECT COUNT(*) FROM Positions')
count_positions = cursor.fetchone()[0]

cursor.execute('SELECT COUNT(*) FROM Color')
count_color = cursor.fetchone()[0]

rn = RussianNames(count = 1, name=False, surname=False)

"""Создание записей для аккаунтов"""
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Clients (cl_name, cl_last_name, cl_patronymic, cl_address, cl_phone)'
        'VALUES (?, ?, ?, ?, ?)',
        (fake.first_name(), fake.last_name(), rn.get_person(), fake.address(),
         fake.phone_number()))

"""Создание записей для брендов"""
mass_company_unique = set()
for _ in range(1, max_count + 1):
    mass_company_unique.add(fake.company())

for company in mass_company_unique:
    cursor.execute(
        'INSERT INTO Brands (brand_name, brand_description)'
        'VALUES (?, ?)',
        (company, fake.paragraph(nb_sentences=6))
    )

"""Создание записей для сотрудников"""
for _ in range(1, max_count + 1):
    cursor.execute(
        'INSERT INTO Employees (emp_name, emp_last_name, emp_patronymic, emp_position, emp_phone, emp_birth_date, emp_mail)'
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        (fake.first_name(), fake.last_name(), rn.get_person(), random.randrange(1, count_positions + 1), fake.phone_number(), fake.date(), fake.ascii_email())
    )

"""Создание записей о товарах"""
for _ in range(1, max_count + 1):
    size = random.randrange(20, 80 - 2 + 1)
    cursor.execute(
        'INSERT INTO Products (prod_name, prod_desc, prod_count, prod_price, prod_color, prod_material, prod_size)'
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        (fake.first_name(), fake.paragraph(nb_sentences=3), random.randrange(1, 10 ** 4), random.randrange(10 ** 3, 10 ** 4), random.randrange(1, count_color), random.randrange(1, count_materials), f'{size}-{size + 2}')
    )

connection.commit()
connection.close()
