-- Лабораторна робота №5 - INDEX
-- База даних: hot_sauce_shop

USE hot_sauce_shop;

-- Створюємо індекс
CREATE INDEX idx_customers_last_name ON customers (last_name);