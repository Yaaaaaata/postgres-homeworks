CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    title VARCHAR(255),
    birth_date DATE,
    notes TEXT
);

CREATE TABLE customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255),
    contact_name VARCHAR(255)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id VARCHAR(255),
    employee_id INTEGER,
    order_date DATE,
    ship_city VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);
