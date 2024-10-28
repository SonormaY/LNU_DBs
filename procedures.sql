-- Процедура 1: Додавання нового продукту та оновлення ціни
CREATE OR REPLACE PROCEDURE add_product_and_update_price(
    IN p_title VARCHAR(50),
    IN p_category VARCHAR(50),
    IN p_manufacturer VARCHAR(50),
    IN p_price REAL,
    IN p_comment VARCHAR(60),
    OUT p_product_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_category_id INTEGER;
    v_manufacturer_id INTEGER;
    v_product_title_id INTEGER;
    const_max_price CONSTANT REAL := 1000.0;
BEGIN
    -- Перевірка ціни
    IF p_price <= 0 OR p_price > const_max_price THEN
        RAISE EXCEPTION 'Недійсна ціна. Має бути більше 0 та менше або дорівнювати %', const_max_price;
    END IF;

    -- Отримання або створення category_id
    SELECT id INTO v_category_id FROM product_category WHERE name = p_category;
    IF NOT FOUND THEN
        INSERT INTO product_category (name) VALUES (p_category) RETURNING id INTO v_category_id;
    END IF;

    -- Отримання або створення manufacturer_id
    SELECT id INTO v_manufacturer_id FROM manufacturer WHERE name = p_manufacturer;
    IF NOT FOUND THEN
        INSERT INTO manufacturer (name) VALUES (p_manufacturer) RETURNING id INTO v_manufacturer_id;
    END IF;

    -- Створення нового product_title, якщо не існує
    SELECT id INTO v_product_title_id FROM product_title WHERE title = p_title AND product_category_id = v_category_id;
    IF NOT FOUND THEN
        INSERT INTO product_title (title, product_category_id) 
        VALUES (p_title, v_category_id) 
        RETURNING id INTO v_product_title_id;
    END IF;

    -- Додавання нового продукту
    INSERT INTO product (product_title_id, manufacturer_id, price, comment)
    VALUES (v_product_title_id, v_manufacturer_id, p_price, p_comment)
    RETURNING id INTO p_product_id;

    -- Оновлення цін для всіх продуктів цього виробника
    UPDATE product
    SET price = price * 1.1
    WHERE manufacturer_id = v_manufacturer_id AND id != p_product_id;

    RAISE NOTICE 'Продукт додано з ID: %. Ціни оновлено для виробника %.', p_product_id, p_manufacturer;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Помилка при додаванні продукту: %', SQLERRM;
END;
$$;

-- Процедура 2: Отримання звіту про продажі за категоріями
CREATE OR REPLACE PROCEDURE get_sales_report(
    IN p_start_date DATE,
    IN p_end_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    r_category RECORD;
    v_total_sales REAL := 0;
    cur_categories CURSOR FOR 
        SELECT pc.id, pc.name, COALESCE(SUM(od.price_with_discount * od.product_amount), 0) as total_sales
        FROM product_category pc
        LEFT JOIN product_title pt ON pc.id = pt.product_category_id
        LEFT JOIN product p ON pt.id = p.product_title_id
        LEFT JOIN order_details od ON p.id = od.product_id
        LEFT JOIN customer_order co ON od.customer_order_id = co.id
        WHERE co.operation_time BETWEEN p_start_date AND p_end_date
        GROUP BY pc.id, pc.name;
BEGIN
    RAISE NOTICE 'Звіт про продажі з % по %', p_start_date, p_end_date;
    RAISE NOTICE '------------------------------------';

    FOR r_category IN cur_categories LOOP
        RAISE NOTICE 'Категорія: %, Продажі: $%', r_category.name, r_category.total_sales;
        v_total_sales := v_total_sales + r_category.total_sales;
    END LOOP;

    RAISE NOTICE '------------------------------------';
    RAISE NOTICE 'Загальні продажі: $%', v_total_sales;

    -- Перевірка, чи були продажі
    IF v_total_sales = 0 THEN
        RAISE EXCEPTION 'Немає продажів за вказаний період';
    END IF;

EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Помилка при створенні звіту: %', SQLERRM;
END;
$$;