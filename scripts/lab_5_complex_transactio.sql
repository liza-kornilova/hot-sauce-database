-- Лабораторна робота №5 - Комплексна транзакція
-- База даних: hot_sauce_shop

USE hot_sauce_shop;

-- ПОЧАТОК ТРАНЗАКЦІЇ
START TRANSACTION;

-- КРОК 1: Створюємо саме замовлення (для клієнта з id=1)
INSERT INTO orders (customer_id, total_amount, status, delivery_address)
VALUES (1, 500.00, 'pending', 'вул. Сумська, 77, Харків');

-- Зберігаємо ID щойно створеного замовлення у змінну
SET @new_order_id = LAST_INSERT_ID();

-- КРОК 2: Додаємо товар у це замовлення
-- (Купуємо товар з id=1, кількість=2 шт)
INSERT INTO order_items (order_id, product_id, quantity, price_per_unit, subtotal)
VALUES (@new_order_id, 1, 2, 
        (SELECT price FROM products WHERE product_id = 1),
        (SELECT price * 2 FROM products WHERE product_id = 1));

-- КРОК 3: Оновлюємо склад (списуємо 2 одиниці товару id=1)
UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 1;

-- Якщо все пройшло без помилок - зберігаємо зміни
COMMIT;
