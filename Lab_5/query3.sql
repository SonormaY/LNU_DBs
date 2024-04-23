--Get list of products which price are higher than the average price of producs in this category. 
--Sort ascendidng by product id. Scheme of result data set: id | title | price

SELECT p.id, p.comment as title, p.price
FROM product p
INNER JOIN product_title ON p.product_title_id = product_title.id
WHERE p.price > (
	SELECT AVG(product.price)
	FROM product
	INNER JOIN product_title pt ON product.product_title_id = pt.id
	WHERE pt.product_category_id == product_title.product_category_id
)
ORDER BY p.id ASC