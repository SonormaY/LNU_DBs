-- Сесія 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Сесія 2
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Сесія 1: Оновлення ціни продукту
UPDATE product SET price = 2.00 WHERE id = 1;

-- Сесія 2: Спроба прочитати ціну продукту
SELECT price FROM product WHERE id = 1;
-- Результат: 1.50 (стара ціна, тому що транзакція 1 ще не зафіксована)

-- Сесія 1: Фіксація змін
COMMIT;

-- Сесія 2: Повторне читання ціни продукту
SELECT price FROM product WHERE id = 1;
-- Результат: 2.00 (нова ціна, тому що транзакція 1 вже зафіксована)

-- Сесія 2: Спроба оновити той самий продукт
UPDATE product SET price = 2.50 WHERE id = 1;
-- Ця операція буде успішною, оскільки немає конфлікту

-- Сесія 2: Фіксація змін
COMMIT;

-- Будь-яка сесія: Перевірка фінальної ціни
SELECT price FROM product WHERE id = 1;
-- Результат: 2.50