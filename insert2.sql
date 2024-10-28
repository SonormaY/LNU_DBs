-- Insert sample cities
INSERT INTO city (name) VALUES
('New York'),
('Los Angeles'),
('Chicago'),
('Houston');

-- Insert sample streets
INSERT INTO street (name, city_id) VALUES
('Broadway', 1),
('Sunset Boulevard', 2),
('Michigan Avenue', 3),
('Main Street', 4);

-- Insert sample supermarkets
INSERT INTO supermarket (name, street_id, house_number) VALUES
('Grocery Plus', 1, '123'),
('Fresh Foods', 2, '456'),
('Super Save', 3, '789'),
('Quick Mart', 4, '101');

-- Insert sample persons
INSERT INTO person (name, surname, birth_date) VALUES
('John', 'Doe', '1980-01-15'),
('Jane', 'Smith', '1992-05-22'),
('Mike', 'Johnson', '1975-11-30'),
('Emily', 'Brown', '1988-09-07');

-- Insert sample contact types
INSERT INTO contact_type (name) VALUES
('Phone'),
('Email'),
('Address');

-- Insert sample person contacts
INSERT INTO person_contact (person_id, contact_type_id, contact_value) VALUES
(1, 1, '555-1234'),
(1, 2, 'john.doe@email.com'),
(2, 1, '555-5678'),
(2, 2, 'jane.smith@email.com');

-- Insert sample customers
INSERT INTO customer (person_id, card_number, discount) VALUES
(1, 1001, 0.05),
(2, 1002, 0.10);

-- Insert sample product categories
INSERT INTO product_category (name) VALUES
('Fruits'),
('Vegetables'),
('Dairy'),
('Bakery');

-- Insert sample product titles
INSERT INTO product_title (title, product_category_id) VALUES
('Apple', 1),
('Banana', 1),
('Carrot', 2),
('Milk', 3),
('Bread', 4);

-- Insert sample manufacturers
INSERT INTO manufacturer (name) VALUES
('FreshFarms'),
('OrganicGoods'),
('DairyBest'),
('BakerDelight');

-- Insert sample products
INSERT INTO product (product_title_id, manufacturer_id, price, comment) VALUES
(1, 1, 0.50, 'Red Delicious'),
(2, 1, 0.30, 'Organic'),
(3, 2, 0.75, 'Bundle'),
(4, 3, 2.50, '1 Gallon'),
(5, 4, 1.50, 'Whole Wheat');

-- Insert sample customer orders
INSERT INTO customer_order (operation_time, supermarket_id, customer_id) VALUES
('2024-09-17', 1, 1),
('2024-09-17', 2, 2);

-- Insert sample order details
INSERT INTO order_details (customer_order_id, product_id, price, price_with_discount, product_amount) VALUES
(1, 1, 0.50, 0.475, 5),
(1, 4, 2.50, 2.375, 1),
(2, 2, 0.30, 0.27, 3),
(2, 5, 1.50, 1.35, 2);