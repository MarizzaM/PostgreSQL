drop function sp_delete;

create or replace function sp_delete(_id bigint) returns int

language plpgsql AS
    $$
        DECLARE
            rows_count int := 0;
        BEGIN
            WITH row AS (
            DELETE FROM orders
            USING customers
            WHERE orders.customer_id = customers.id
            RETURNING 1)
            select count(*) into rows_count from row;
            return rows_count;
        END;
    $$;

select * from sp_delete(2);
