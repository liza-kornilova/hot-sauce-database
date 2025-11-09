-- DQL: Агрегація (COUNT + GROUP BY)
-- Рахуємо кількість продуктів у кожного виробника
SELECT
    `manufacturer_id`,
    COUNT(*) AS `total_products`
FROM
    `products`
GROUP BY
    `manufacturer_id`;

-- DQL: Агрегація (SUM)
-- Рахуємо загальну вартість всіх товарів на складі
SELECT
    SUM(`price` * `stock_quantity`) AS `total_stock_value`
FROM
    `products`;

-- DQL: Агрегація (AVG, MIN, MAX)
-- Аналітика цін для середнього рівня гостроти (heat_level_id = 3)
SELECT
    AVG(`price`) AS `average_price`,
    MIN(`price`) AS `min_price`,
    MAX(`price`) AS `max_price`
FROM
    `products`
WHERE
    `heat_level_id` = 3;

-- DQL: Агрегація (GROUP BY + JOIN)
-- Рахуємо загальну суму витрат для кожного клієнта
SELECT
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.price_per_unit) AS total_spent
FROM
    customers AS c
JOIN
    orders AS o ON c.customer_id = o.customer_id
JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_spent desc
    
-- DQL: Фільтрація після агрегації (HAVING)
-- Знаходимо клієнтів, які витратили більше 1000 грн
SELECT
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.price_per_unit) AS total_spent
FROM
    customers AS c
JOIN
    orders AS o ON c.customer_id = o.customer_id
JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    total_spent > 1000
ORDER BY
    total_spent desc
    
-- DQL: INNER JOIN (4 таблиці)
-- Звіт про продажі
SELECT
    c.first_name AS customer_name,
    p.product_name AS product_name,
    oi.quantity,
    o.status
FROM
    customers AS c
INNER JOIN
    orders AS o ON c.customer_id = o.customer_id
INNER JOIN
    order_items AS oi ON o.order_id = oi.order_id
INNER JOIN
    products AS p ON oi.product_id = p.product_id
WHERE
    o.status = 'delivered'
ORDER BY
    c.first_name
    
-- DQL: LEFT JOIN
-- Всі клієнти та їхні замовлення (якщо є)
SELECT
    c.first_name AS customer_name,
    c.last_name,
    o.order_id
FROM
    customers AS c
LEFT JOIN
    orders AS o ON c.customer_id = o.customer_id
ORDER BY
    c.first_name
    
    
-- DQL: Підзапит (Subquery)
-- Знайти товари, які ніколи не купували
SELECT
    p.product_name
FROM
    products AS p
WHERE
    p.product_id NOT IN (
        -- Внутрішній запит: список ID куплених товарів
        SELECT DISTINCT oi.product_id 
        FROM order_items AS oi
    )

-- DQL: Комбінування вибірок (UNION)
-- Єдиний список клієнтів та виробників
SELECT
    c.first_name AS item_name,
    'Customer' AS item_type
FROM
    customers AS c
UNION
SELECT
    m.name AS item_name,
    'Manufacturer' AS item_type
FROM
    manufacturers AS m
ORDER BY
    item_type, item_name