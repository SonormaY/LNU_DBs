--Get the leading manufacturers for each product title. If the product was not sold, the leader-manufacturer is NULL. 
--Sort ascendidng by title id. Scheme of result data set: product_id| title | manufacturer_id | manufacturer
ELECT pt.id AS product_id, pt.title, pr.manufacturer_id, m.name AS manufacturer
FROM product_title pt
LEFT JOIN product pr ON pt.id = pr.product_title_id
LEFT JOIN manufacturer m ON m.id = pr.manufacturer_id
WHERE
    (
        SELECT COALESCE(SUM(od_inner.product_amount), 0)
        FROM order_details od_inner
        WHERE od_inner.product_id = pr.id
    ) = (
        SELECT COALESCE(MAX(total_amount), 0)
        FROM (
            SELECT pr_inner.manufacturer_id, COALESCE(SUM(od_inner.product_amount), 0) AS total_amount
            FROM product pr_inner
            LEFT JOIN order_details od_inner ON od_inner.product_id = pr_inner.id
            WHERE pr_inner.product_title_id = pt.id
            GROUP BY pr_inner.manufacturer_id
        ) AS inner_query
    )
GROUP BY pt.id
ORDER BY pt.id
