-- Лабораторна робота №5 - COMMIT
-- База даних: hot_sauce_shop

USE hot_sauce_shop;

-- 1. Дивимося на ціну "ДО"
SELECT * FROM `products` WHERE `product_id` = 1;
-- 2. Починаємо транзакцію
START TRANSACTION;
-- 3. Виконуємо нашу DML-операцію
UPDATE `products`
SET `price` = 420.00 -- Нова ціна
WHERE `product_id` = 1;
-- 4. Завершуємо транзакцію ТА ЗБЕРІГАЄМО ЗМІНИ
COMMIT;
-- 5. Дивимося на ціну "ПІСЛЯ"
SELECT * FROM `products` WHERE `product_id` = 1;
