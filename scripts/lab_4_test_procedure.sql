-- ========================================
-- ТЕСТ: Додавання нового продукту
-- ========================================

USE hot_sauce_shop;

-- Викликаємо процедуру
CALL sp_add_new_product(
    1,                                              -- manufacturer_id = 1
    4,                                              -- heat_level_id = 4
    'Ghost Pepper Apocalypse',                      -- product_name
    200,                                            -- volume_ml
    349.00,                                         -- price
    'Перець Bhut Jolokia, манго, лайм, оцет',      -- ingredients
    'Екстремально гострий соус з тропічними нотками', -- description
    30                                              -- stock_quantity
);

-- Перевірка: дивимось чи додався продукт
SELECT 
    product_id,
    manufacturer_id,
    heat_level_id,
    product_name,
    volume_ml,
    price,
    stock_quantity,
    is_available
FROM products 
ORDER BY product_id DESC 
LIMIT 1;