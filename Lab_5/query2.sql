-- Get a list of categories, where each product has at least one purchase. 
-- Sort ascending by id. Scheme of result data set: id| name

SELECT pc.id, pc.name
FROM product_category pc
WHERE NOT EXISTS (
    SELECT product.id
    FROM product
    JOIN product_title ON product.product_title_id = product_title.id
    WHERE product_title.product_category_id = pc.id
    AND NOT EXISTS (
        SELECT 1
        FROM order_details
        WHERE order_details.product_id = product.id
    )
)
AND EXISTS (
    SELECT 1
    FROM product
    JOIN product_title ON product.product_title_id = product_title.id
    WHERE product_title.product_category_id = pc.id
)
ORDER BY pc.id ASC;
