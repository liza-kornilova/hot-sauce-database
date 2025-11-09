-- DQL: Фільтрація (WHERE + AND)
-- Знаходимо гострі соуси дешевше 250 грн
SELECT *
FROM `products`
WHERE `heat_level_id` = 5 AND `price` < 250.00;

-- DQL: Фільтрація (WHERE + IN)
-- Знаходимо відправлені або доставлені замовлення
SELECT *
FROM `orders`
WHERE `status` IN ('shipped', 'delivered');

-- DQL: Фільтрація (WHERE + LIKE)
-- Знаходимо клієнтів з Gmail
SELECT *
FROM `customers`
WHERE `email` LIKE '%@gmail.com';

-- DQL: Сортування (ORDER BY)
-- Сортуємо продукти за ціною (від дорогих до дешевих)
SELECT *
FROM `products`
ORDER BY `price` DESC;

