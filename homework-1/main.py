"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv

import psycopg2

with psycopg2.connect(
        host="localhost",
        database="north",
        user="postgres",
        password="454125"
) as conn:
    with conn.cursor() as cursor:
        csv_file_employees = 'north_data/employees_data.csv'
        with open(csv_file_employees, 'r', encoding='utf8') as file_employees:
            reader_employees = csv.reader(file_employees)
            next(reader_employees)

            for row_employees in reader_employees:
                cursor.execute("INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, "
                               "notes) VALUES (%s, %s, %s, %s, %s, %s)", row_employees)

    with conn.cursor() as cursor:
        csv_file_customers = 'north_data/customers_data.csv'
        with open(csv_file_customers, 'r', encoding='utf8') as file_customers:
            reader_customers = csv.reader(file_customers)
            next(reader_customers)

            for row_customers in reader_customers:
                cursor.execute("INSERT INTO customers (customer_id, company_name, contact_name) VALUES ( "
                               "%s, %s, %s)", row_customers)

    with conn.cursor() as cursor:
        csv_file_orders = 'north_data/orders_data.csv'
        with open(csv_file_orders, 'r', encoding='utf8') as file_orders:
            reader_orders = csv.reader(file_orders)
            next(reader_orders)

            for row_orders in reader_orders:
                cursor.execute("INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) VALUES "
                               "(%s, %s, %s, %s, %s)", row_orders)

