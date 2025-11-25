USE hot_sauce_shop;

-- 1. Дивимося на ціну "ДО"
SELECT * FROM `products` WHERE `product_id` = 6;
-- 2. Починаємо транзакцію
START TRANSACTION;
-- 3. Виконуємо нашу DML-операцію (яку ми хочемо скасувати)
UPDATE `products`
SET `price` = 999.00 -- Встановлюємо якусь божевільну ціну
WHERE `product_id` = 6;
-- 4. Переконуємося, що ЦІНА ЗМІНИЛАСЯ (тільки для нас, всередині транзакції)
SELECT * FROM `products` WHERE `product_id` = 6;
-- 5. Завершуємо транзакцію ТА СКАСОВУЄМО ВСІ ЗМІНИ
ROLLBACK;
-- 6. Дивимося на ціну "ПІСЛЯ"
SELECT * FROM `products` WHERE `product_id` = 6;

