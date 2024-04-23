CREATE INDEX contacts_index ON person_contact (contact_value);
EXPLAIN QUERY PLAN SELECT * FROM person_contact WHERE contact_value = 'user5@example.com'

CREATE UNIQUE INDEX product_index ON product_title (title);
EXPLAIN QUERY PLAN SELECT * FROM product_title WHERE title = 'Banana'

CREATE INDEX customer_index ON person (name, surname);
EXPLAIN QUERY PLAN SELECT * FROM person WHERE name = 'Yan'