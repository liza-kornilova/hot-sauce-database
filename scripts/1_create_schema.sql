-- База даних: Крафтові гострі соуси та продукти
-- DDL скрипт для створення структури таблиць

CREATE DATABASE IF NOT EXISTS hot_sauce_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hot_sauce_shop;

-- Таблиця виробників
CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    founding_year INT,
    website VARCHAR(200),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблиця категорій гостроти
CREATE TABLE heat_levels (
    heat_level_id INT PRIMARY KEY AUTO_INCREMENT,
    level_name VARCHAR(50) NOT NULL,
    scoville_min INT NOT NULL,
    scoville_max INT NOT NULL,
    description VARCHAR(255)
);

-- Таблиця продуктів (соусів)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    manufacturer_id INT NOT NULL,
    heat_level_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    volume_ml INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    ingredients TEXT,
    description TEXT,
    stock_quantity INT DEFAULT 0,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id),
    FOREIGN KEY (heat_level_id) REFERENCES heat_levels(heat_level_id)
);

-- Таблиця клієнтів
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50),
    address TEXT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблиця замовлень
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    delivery_address TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Таблиця деталей замовлення
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Таблиця відгуків
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
