import csv
import psycopg2

# Подключение к базе данных
conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password="19Sonnik94"
)
cur = conn.cursor()

# Загрузка данных в таблицу employees
with open('north_data/employees_data.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader)  # Пропуск заголовка
    for row in reader:
        cur.execute(
            "INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, notes) "
            "VALUES (%s, %s, %s, %s, %s, %s)",
            (int(row[0]), row[1], row[2], row[3], row[4], row[5])
        )

# Загрузка данных в таблицу customers
with open('north_data/customers_data.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader)  # Пропуск заголовка
    for row in reader:
        cur.execute(
            "INSERT INTO customers (customer_id, company_name, contact_name) "
            "VALUES (%s, %s, %s)",
            (row[0], row[1], row[2])
        )

# Загрузка данных в таблицу orders
with open('north_data/orders_data.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader)  # Пропуск заголовка
    for row in reader:
        cur.execute(
            "INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) "
            "VALUES (%s, %s, %s, %s, %s)",
            (int(row[0]), row[1], int(row[2]), row[3], row[4])
        )

# Сохранение изменений и закрытие соединения
conn.commit()
cur.close()
conn.close()
