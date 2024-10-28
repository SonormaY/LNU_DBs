-- Запит для створення XML документу з даними про замовлення, клієнтів, продукти та категорії
SELECT xmlelement(name "supermarket_data",
    xmlattributes('1.0' AS version),
    (SELECT xmlagg(xmlelement(name "order",
        xmlattributes(co.id AS order_id),
        xmlelement(name "date", co.operation_time),
        (SELECT xmlelement(name "customer",
            xmlattributes(c.person_id AS customer_id),
            xmlelement(name "name", p.name),
            xmlelement(name "surname", p.surname),
            xmlelement(name "discount", c.discount),
            (SELECT xmlagg(xmlelement(name "contact",
                xmlattributes(ct.name AS type),
                pc.contact_value
            ))
            FROM person_contact pc
            JOIN contact_type ct ON pc.contact_type_id = ct.id
            WHERE pc.person_id = c.person_id)
        )
        FROM customer c
        JOIN person p ON c.person_id = p.id
        WHERE c.person_id = co.customer_id),
        xmlelement(name "order_details",
            (SELECT xmlagg(xmlelement(name "product",
                xmlattributes(od.product_id AS product_id),
                xmlelement(name "title", pt.title),
                xmlelement(name "category", pc.name),
                xmlelement(name "manufacturer", m.name),
                xmlelement(name "price", od.price),
                xmlelement(name "discount_price", od.price_with_discount),
                xmlelement(name "quantity", od.product_amount)
            ))
            FROM order_details od
            JOIN product p ON od.product_id = p.id
            JOIN product_title pt ON p.product_title_id = pt.id
            JOIN product_category pc ON pt.product_category_id = pc.id
            JOIN manufacturer m ON p.manufacturer_id = m.id
            WHERE od.customer_order_id = co.id)
        ),
        xmlelement(name "total_amount", 
            (SELECT SUM(od.price_with_discount * od.product_amount) 
             FROM order_details od 
             WHERE od.customer_order_id = co.id)
        )
    ))
    FROM customer_order co
    WHERE co.operation_time >= CURRENT_DATE - INTERVAL '30 days'
    )
) AS supermarket_xml;