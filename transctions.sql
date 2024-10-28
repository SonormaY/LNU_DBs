-- Транзакція 1: Додавання нового клієнта та оформлення замовлення
BEGIN;

-- Додавання нового клієнта
INSERT INTO person (name, surname, birth_date) 
VALUES ('Олена', 'Петренко', '1990-05-15');

-- Додавання контактної інформації
INSERT INTO person_contact (person_id, contact_type_id, contact_value)
VALUES 
    ((SELECT MAX(id) FROM person), (SELECT id FROM contact_type WHERE name = 'Phone'), '050-123-4567'),
    ((SELECT MAX(id) FROM person), (SELECT id FROM contact_type WHERE name = 'Email'), 'olena.petrenko@email.com');

-- Перевірка: чи email вже існує
DO $$
DECLARE
    email_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO email_count
    FROM person_contact 
    WHERE contact_type_id = (SELECT id FROM contact_type WHERE name = 'Email')
    AND contact_value = 'olena.petrenko@email.com';

    IF email_count > 1 THEN
        RAISE EXCEPTION 'Email вже існує. Відкат транзакції.';
    END IF;
END $$;

-- Додавання клієнта
INSERT INTO customer (person_id, card_number, discount)
VALUES ((SELECT MAX(id) FROM person), 2001, 0.05);

-- Створення замовлення
INSERT INTO customer_order (operation_time, supermarket_id, customer_id)
VALUES (CURRENT_DATE, 1, (SELECT MAX(person_id) FROM customer));

-- Додавання деталей замовлення
INSERT INTO order_details (customer_order_id, product_id, price, price_with_discount, product_amount)
VALUES 
    ((SELECT MAX(id) FROM customer_order), 1, 0.50, 0.475, 5),
    ((SELECT MAX(id) FROM customer_order), 4, 2.50, 2.375, 2);

-- Перевірка: чи загальна сума замовлення не перевищує 1000
DO $$
DECLARE
    total_sum DECIMAL;
BEGIN
    SELECT SUM(price_with_discount * product_amount) INTO total_sum
    FROM order_details 
    WHERE customer_order_id = (SELECT MAX(id) FROM customer_order);

    IF total_sum > 1000 THEN
        RAISE EXCEPTION 'Сума замовлення перевищує ліміт. Відкат транзакції.';
    END IF;
END $$;

COMMIT;

-- Транзакція 2: Оновлення цін на продукти та додавання нової категорії
BEGIN;

-- Оновлення цін на всі продукти (підвищення на 10%)
UPDATE product SET price = price * 1.1;

-- Додавання нової категорії продуктів
INSERT INTO product_category (name) VALUES ('Органічні продукти');

-- Додавання нового продукту до нової категорії
INSERT INTO product_title (title, product_category_id)
VALUES ('Органічні яблука', (SELECT id FROM product_category WHERE name = 'Органічні продукти'));

INSERT INTO product (product_title_id, manufacturer_id, price, comment)
VALUES (
    (SELECT id FROM product_title WHERE title = 'Органічні яблука'),
    (SELECT id FROM manufacturer WHERE name = 'FreshFarms'),
    1.50,
    'Свіжі органічні яблука'
);

-- Перевірка: якщо ціна нового продукту менше середньої ціни в категорії, відкатимося до оновлення цін
DO $$
DECLARE
    avg_price DECIMAL;
BEGIN
    SELECT AVG(price) INTO avg_price
    FROM product
    JOIN product_title ON product.product_title_id = product_title.id
    WHERE product_title.product_category_id = (SELECT id FROM product_category WHERE name = 'Органічні продукти');

    IF avg_price > 1.50 THEN
        RAISE EXCEPTION 'Ціна нового продукту занадто низька. Відкат транзакції.';
    END IF;
END $$;

COMMIT;