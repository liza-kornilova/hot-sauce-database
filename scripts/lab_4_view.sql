-- ========================================
-- VIEW: Детальна інформація про замовлення
-- Об'єднує дані з 4 таблиць: orders, customers, order_items, products
-- ========================================

USE hot_sauce_shop;

-- Видаляємо VIEW якщо він існує (для можливості повторного запуску)
DROP VIEW IF EXISTS v_detailed_orders;

-- Створюємо VIEW
CREATE VIEW v_detailed_orders AS
SELECT 
    o.order_id,
    o.order_date,
    o.status AS order_status,
    o.total_amount,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email AS customer_email,
    c.city AS customer_city,
    p.product_name,
    p.price AS current_price,
    oi.quantity,
    oi.price_per_unit AS purchase_price,
    oi.subtotal,
    m.name AS manufacturer_name
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    order_items oi ON o.order_id = oi.order_id
INNER JOIN 
    products p ON oi.product_id = p.product_id
INNER JOIN
    manufacturers m ON p.manufacturer_id = m.manufacturer_id
ORDER BY 
    o.order_date DESC;