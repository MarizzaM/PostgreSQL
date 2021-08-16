drop procedure sp_insert_or_update;

create or replace procedure sp_insert_or_update(_name text, _age int)
language plpgsql AS
    $$
        DECLARE
        new_id bigint;
            BEGIN
            IF NOT EXISTS(SELECT 1 FROM customers WHERE name = _name) THEN

                INSERT INTO customers (name, age)
                VALUES (_name, _age)
                RETURNING id INTO new_id;

            ELSE
                UPDATE customers
                    SET age = _age
                WHERE
                    name = _name;
                END IF;
            END;
    $$;

call sp_insert_or_update('Sam', 120);
