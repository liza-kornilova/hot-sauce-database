USE hot_sauce_shop;


-- ========================================
-- ТЕСТ 1: Тригер оновлення часу зміни продукту
-- tr_products_before_update
-- ========================================

-- Крок 1: Дивимось поточні дані продукту ID=2
SELECT 
    product_id, 
    product_name, 
    price, 
    updated_at 
FROM products 
WHERE product_id = 2;

-- Запам'ятай час з колонки updated_at!

-- Крок 2: Оновлюємо ціну (тригер має автоматично змінити updated_at)
UPDATE products 
SET price = 295.00 
WHERE product_id = 2;

-- Крок 3: Перевіряємо що updated_at ЗМІНИВСЯ
SELECT 
    product_id, 
    product_name, 
    price, 
    updated_at 
FROM products 
WHERE product_id = 2;

-- Результат: updated_at має бути НОВІШИЙ ніж був до UPDATE


-- ========================================
-- ТЕСТ 2: Тригер зменшення залишків після додавання в замовлення
-- tr_order_items_after_insert
-- ========================================

-- Крок 1: Дивимось поточну кількість товару на складі
SELECT 
    product_id, 
    product_name, 
    stock_quantity, 
    is_available 
FROM products 
WHERE product_id = 2;

-- Запам'ятай поточну кількість (наприклад, було 250)

-- Крок 2: Створюємо нове замовлення
INSERT INTO orders (customer_id, total_amount, status, delivery_address)
VALUES (1, 500.00, 'pending', 'Тестова адреса для перевірки тригера');

-- Отримуємо ID щойно створеного замовлення
SET @new_order_id = LAST_INSERT_ID();

SELECT @new_order_id AS created_order_id;

-- Крок 3: Додаємо товар в замовлення (тригер спрацює АВТОМАТИЧНО!)
INSERT INTO order_items (order_id, product_id, quantity, price_per_unit, subtotal)
VALUES (@new_order_id, 2, 5, 100.00, 500.00);

-- Крок 4: Перевіряємо що кількість ЗМЕНШИЛАСЬ на 5
SELECT 
    product_id, 
    product_name, 
    stock_quantity, 
    is_available 
FROM products 
WHERE product_id = 2;

-- Результат: stock_quantity має бути (попередня_кількість - 5)
-- Наприклад: було 250 → стало 245
