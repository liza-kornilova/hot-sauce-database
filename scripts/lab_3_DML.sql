-- DML: Додавання нового клієнта (Customer)
INSERT INTO `customers` (`first_name`, `last_name`, `email`, `phone`, `city`, `address`) 
VALUES ('Максим', 'Петренко', 'maksym.petrenko@gmail.com', '+380501234567', 'Київ', 'вул. Хрещатик, 25');

-- DML: Додавання нового продукту (Product)
INSERT INTO `products` (`manufacturer_id`, `heat_level_id`, `product_name`, `volume_ml`, `price`, `ingredients`, `description`, `stock_quantity`) 
VALUES (1, 3, 'Carolina Reaper Inferno', 150, 299.00, 'Перець Carolina Reaper, оцет, часник, сіль', 'Один з найгостріших соусів у світі', 25);

-- DML: Оновлення ціни товару (Update)
-- Робимо знижку на товар з ID=1
UPDATE `products`
SET `price` = 249.00
WHERE `product_id` = 1;

-- DML: Видалення позиції з замовлення (Delete)
-- Видаляємо один товар з замовлення
DELETE FROM `order_items`
WHERE `order_id` = 1 AND `product_id` = 2;

