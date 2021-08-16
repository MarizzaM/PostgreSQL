create or replace function sp_delete(_id bigint) returns int

language plpgsql AS
    $$
        DECLARE
            rows_count int := 0;
        BEGIN

            DELETE FROM orders
            USING customers
            WHERE orders.customer_id = _id;
            
            WITH row AS (
            DELETE FROM customers
            WHERE customers.id = _id
            RETURNING 1)
            select count(*) into rows_count from row;
            return rows_count;
        END;
    $$;

select * from sp_delete(5);
