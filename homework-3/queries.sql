-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers_new.company_name AS customer, CONCAT(employee_new.first_name, ' ', employee_new.last_name) AS employee
FROM orders as order_new
JOIN customers as customers_new USING(customer_id)
JOIN employees as employee_new USING(employee_id)
JOIN shippers as shippers_new ON order_new.ship_via = shippers_new.shipper_id
WHERE customers_new.city = 'London' AND employee_new.city = 'London' AND shippers_new.company_name = 'United Package';


-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, units_in_stock, contact_name, phone FROM products JOIN suppliers USING(supplier_id)
WHERE discontinued <> 1 AND units_in_stock < 25 AND category_id IN ('2', '4') ORDER BY units_in_stock ASC


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name FROM CUSTOMERS
WHERE NOT EXISTS (SELECT * FROM orders WHERE CUSTOMERS.customer_id=orders.customer_id)


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT product_name FROM products
WHERE EXISTS (SELECT * FROM order_details WHERE products.product_id=order_details.product_id AND order_details.quantity = 10)
ORDER BY product_name
