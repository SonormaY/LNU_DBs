--Get customers, whose average purchase amount per order is more than 70. 
--Sort ascending total purchase sum, surname. 
--Scheme of result data set: name| surname | avg_purchase | sum_ purchase
SELECT p.name, p.surname,
ROUND(AVG(od.price_with_discount * od.product_amount), 2) AS avg_purchase,
SUM(od.price_with_discount * od.product_amount) AS sum_purchase
FROM order_details od 
INNER JOIN customer_order co ON co.id = od.customer_order_id
LEFT JOIN customer c ON c.person_id = co.customer_id
LEFT JOIN person p ON p.id = c.person_id
WHERE (co.customer_id IN (
  SELECT co.customer_id
  FROM order_details od
  INNER JOIN customer_order co ON co.id = od.customer_order_id
  GROUP BY co.customer_id
  HAVING AVG(od.price_with_discount * od.product_amount) > 70
) OR co.customer_id IS NULL)
GROUP BY p.name, p.surname
ORDER BY sum_purchase, p.surname;