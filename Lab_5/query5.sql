/*Calculate how many more (in percentage) products were sold when their discount 
was more than 5% (id and title of the product, the quantity of this product purchased 
with this discount, the quantity of this product purchased without a discount or with 
a discount below 5%, the difference in percentage between the number of product sold 
with discount and without one). Sort ascending by product id. 
Scheme of result data set: id | title | count_with_discount_5 | count_without_discount_5 | difference*/
SELECT
    pr.id, pr.comment as title,
    COALESCE((
        SELECT SUM(od.product_amount)
        FROM order_details od
        WHERE od.product_id = pr.id AND (od.price - od.price_with_discount) / od.price * 100 >= 6
    ), 0) AS count_with_discount_5,
    COALESCE((
        SELECT SUM(od.product_amount)
        FROM order_details od
        WHERE od.product_id = pr.id AND (od.price - od.price_with_discount) / od.price * 100 <6
    ), 0) AS count_without_discount_5,
    ROUND(COALESCE(100.0 * (COALESCE((
        SELECT SUM(od.product_amount)
        FROM order_details od
         WHERE od.product_id = pr.id AND (od.price - od.price_with_discount) / od.price * 100 >= 6
    ), 0) - COALESCE((
        SELECT SUM(od.product_amount)
        FROM order_details od
        WHERE od.product_id = pr.id AND (od.price - od.price_with_discount) / od.price * 100 < 6
    ), 0)) / COALESCE((
        SELECT SUM(od.product_amount)
        FROM order_details od
        WHERE od.product_id = pr.id), 0), 0), 2) as difference
FROM product pr
ORDER BY pr.id;