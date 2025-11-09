USE hot_sauce_shop;

DROP PROCEDURE IF EXISTS sp_add_new_product;

DELIMITER $$

CREATE PROCEDURE sp_add_new_product(
    IN p_manufacturer_id INT,
    IN p_heat_level_id INT,
    IN p_product_name VARCHAR(150),
    IN p_volume_ml INT,
    IN p_price DECIMAL(10, 2),
    IN p_ingredients TEXT,
    IN p_description TEXT,
    IN p_stock_quantity INT
)
BEGIN
    DECLARE manufacturer_exists INT DEFAULT 0;
    DECLARE heat_level_exists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO manufacturer_exists 
    FROM manufacturers 
    WHERE manufacturer_id = p_manufacturer_id;
    
    SELECT COUNT(*) INTO heat_level_exists 
    FROM heat_levels 
    WHERE heat_level_id = p_heat_level_id;
    
    IF manufacturer_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Помилка: Виробник не існує';
    END IF;
    
    IF heat_level_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Помилка: Рівень гостроти не існує';
    END IF;
    
    IF p_price <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Помилка: Ціна має бути більше 0';
    END IF;
    
    IF p_stock_quantity < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Помилка: Кількість не може бути відємною';
    END IF;
    
    INSERT INTO products (
        manufacturer_id, 
        heat_level_id, 
        product_name, 
        volume_ml, 
        price, 
        ingredients, 
        description, 
        stock_quantity,
        is_available
    ) VALUES (
        p_manufacturer_id,
        p_heat_level_id,
        p_product_name,
        p_volume_ml,
        p_price,
        p_ingredients,
        p_description,
        p_stock_quantity,
        TRUE
    );
    
    SELECT CONCAT('Продукт додано! ID: ', LAST_INSERT_ID()) AS result;
END$$

DELIMITER ;