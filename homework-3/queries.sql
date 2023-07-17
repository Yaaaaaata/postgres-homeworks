-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT cust.company_name, CONCAT(emp.first_name, ' ', emp.last_name) as employee_name
FROM customers AS cust
JOIN orders AS ord ON cust.customer_id = ord.customer_id
JOIN employees AS emp ON ord.employee_id = emp.employee_id
JOIN shippers AS ship ON ord.ship_via = ship.shipper_id
WHERE cust.city = 'London' AND emp.city = 'London' AND ship.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT prod.product_name, prod.units_in_stock, supp.contact_name, supp.phone
FROM products AS prod
JOIN suppliers AS supp ON prod.supplier_id = supp.supplier_id
WHERE prod.discontinued = 0 AND prod.units_in_stock < 25
AND prod.category_id IN (SELECT category_id FROM categories WHERE category_name IN ('Dairy Products', 'Condiments'))
ORDER BY prod.units_in_stock ASC;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT p.product_name
FROM products p
WHERE p.product_id IN (
  SELECT od.product_id
  FROM order_details od
  WHERE od.quantity = 10
);