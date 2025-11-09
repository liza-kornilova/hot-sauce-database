-- ========================================
-- TRIGGER 1: Автоматичне оновлення часу зміни продукту
-- Спрацьовує BEFORE UPDATE на таблиці products
-- ========================================

USE hot_sauce_shop;

-- Видаляємо тригер якщо існує
DROP TRIGGER IF EXISTS tr_products_before_update;

-- Створюємо тригер
DELIMITER $$

CREATE TRIGGER tr_products_before_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    -- Автоматично встановлюємо час оновлення
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;


-- ========================================
-- TRIGGER 2: Зменшення залишків після додавання товару в замовлення
-- Спрацьовує AFTER INSERT на таблиці order_items
-- ========================================

-- Видаляємо тригер якщо існує
DROP TRIGGER IF EXISTS tr_order_items_after_insert;

-- Створюємо тригер
DELIMITER $$

CREATE TRIGGER tr_order_items_after_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    -- Зменшуємо кількість товару на складі
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
    
    -- Якщо залишок став 0 або менше - позначаємо як недоступний
    UPDATE products
    SET is_available = FALSE
    WHERE product_id = NEW.product_id 
    AND stock_quantity <= 0;
END$$

DELIMITER ;


-- ========================================
-- TRIGGER 3: Повернення залишків при видаленні товару з замовлення
-- Спрацьовує AFTER DELETE на таблиці order_items
-- ========================================

-- Видаляємо тригер якщо існує
DROP TRIGGER IF EXISTS tr_order_items_after_delete;

-- Створюємо тригер
DELIMITER $$

CREATE TRIGGER tr_order_items_after_delete
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    -- Повертаємо кількість товару на склад
    UPDATE products
    SET stock_quantity = stock_quantity + OLD.quantity,
        is_available = TRUE
    WHERE product_id = OLD.product_id;
END$$

DELIMITER ;