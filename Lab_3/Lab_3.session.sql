ALTER DOMAIN phone RENAME TO phone_deprecated;
CREATE DOMAIN phone AS VARCHAR(12)
    CHECK (value ~ '^\d{3}-\d{3}-\d{4}$');
ALTER TABLE organisator
    ALTER COLUMN phone
    SET DATA TYPE VARCHAR(12);
ALTER TABLE sponsor
    ALTER COLUMN phone
    SET DATA TYPE VARCHAR(12);
UPDATE organisator
    SET phone = '123-456-7890';
UPDATE sponsor
    SET phone = '123-456-7890';
ALTER TABLE organisator
    ALTER COLUMN phone
    SET DATA TYPE phone;
ALTER TABLE sponsor
    ALTER COLUMN phone
    SET DATA TYPE phone;

DROP DOMAIN phone_deprecated;

ALTER DOMAIN email ADD CONSTRAINT email_check CHECK (value ~ '^.+@.+\..+$');

ALTER TABLE sponsor ALTER COLUMN level SET NOT NULL;