-- ========================================
-- ТЕСТУВАННЯ VIEW: v_detailed_orders
-- ========================================

USE hot_sauce_shop;

-- Тест 1: Вибірка всіх даних з VIEW
SELECT * FROM v_detailed_orders;

-- Тест 2: Вибірка замовлень певного клієнта
SELECT * FROM v_detailed_orders
WHERE customer_name LIKE '%Іванов%';

-- Тест 3: Вибірка замовлень зі статусом "delivered"
SELECT * FROM v_detailed_orders
WHERE order_status = 'delivered';

-- Тест 4: Підрахунок загальної кількості замовлень по містах
SELECT 
    customer_city,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(subtotal) AS total_revenue
FROM v_detailed_orders
GROUP BY customer_city
ORDER BY total_revenue DESC;