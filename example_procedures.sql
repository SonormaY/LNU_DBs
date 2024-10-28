DO $$
DECLARE
    new_product_id INTEGER;
BEGIN
    CALL add_product_and_update_price(
        'Organic Tomatoes',  -- p_title
        'Vegetables',        -- p_category
        'FreshFarms',        -- p_manufacturer
        1.99,                -- p_price
        'Fresh and juicy',   -- p_comment
        new_product_id       -- OUT parameter
    );
    
    RAISE NOTICE 'Новий продукт доданий з ID: %', new_product_id;
END $$;

CALL get_sales_report('2024-01-01', '2024-12-31');