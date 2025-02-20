-- Question 10 (Stored Procedure)
-- Create a stored procedure called `transfer_inventory` that:
-- - Takes source_warehouse_id, target_warehouse_id, product_id, and quantity as parameters
-- - Transfers specified quantity from source to target warehouse
-- - Includes error handling for insufficient stock
-- - Logs the transfer in a new audit_log table
-- - Returns success/failure message

-- Test the procedure with:
-- - Success case: Transfer 50 units of product_id 1 from warehouse 1 to warehouse 2
-- - Failure case: Try to transfer 1000 units (more than available)


-- created audit_log table for storing the transfer logs.
create table audit_log (
source_warehouse_id int,
target_warehouse_id int,
product_id int, 
quantity int
);


-- altered inventory table just to add incremental primary key when adding a new product in any warehouse
-- where that product doesn't exist
ALTER TABLE inventory modify inventory_id INT NOT NULL AUTO_INCREMENT;

-- select queries for different table
select * from warehouses;
select * from products;
select * from inventory;
select * from audit_log;




CREATE DEFINER=`root`@`localhost` PROCEDURE `transfer_inventory`(IN p_source_warehouse_id int, IN p_target_warehouse_id int, IN p_product_id int, IN p_quantity int)
BEGIN
    -- two temperory variable v_count and w_count
	declare v_count int;           
    declare w_count int;
    
    -- checking if the particular product is present in the source warehouse and if yes
    -- then is it in the sufficient quantity that is required to transfer from source warehouse to target warehouse
    select count(1) into v_count from inventory 
    where warehouse_id = p_source_warehouse_id
    and product_id = p_product_id
    and quantity >= p_quantity;
    
    if v_count > 0 then             -- if v_count > 0, it means there is any record satisfying the above conditions
        update inventory set quantity = quantity - p_quantity where product_id = p_product_id and warehouse_id = p_source_warehouse_id;
        -- in above query, we are simply decreasing the quantity from source warehouse

        select count(1) into w_count from inventory where product_id = p_product_id and warehouse_id = p_target_warehouse_id;
        -- checking if the product is already present in the target warehouse. 
        -- If w_count is more that one then there is any record with the product_id in target warehouse.

        if w_count > 0 then
			update inventory set quantity = quantity + p_quantity where warehouse_id = p_target_warehouse_id and product_id = p_product_id;
            -- In above query, we are simply increasing the quantity in the target warehouse.

        else
			insert into inventory (product_id, warehouse_id, quantity, last_updated) values (p_product_id, p_target_warehouse_id, p_quantity, current_timestamp());
            -- In above query inserting the product in the target warehouse if it is not present there.
        end if;
        
        insert into audit_log values (p_source_warehouse_id, p_target_warehouse_id, p_product_id, p_quantity);
        -- logging all the transactions/transfers in the audit_log table.


        select "Quantity modified, check audit table";
        -- Success message
	
    else
		select "Insufficient Quantity";
        -- failure message 

	end if;
END


-- calling the procedure by passing all 4 parameters.
call transfer_inventory(2, 1, 2, 20);

