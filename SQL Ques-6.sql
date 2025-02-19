-- Question 6 (MERGE/UPSERT)
-- Using this temporary table structure and data:
CREATE TABLE inventory_updates (   			-- simply create a temperory table inventory_update
	u_inventory_id INT,
    u_product_id INT,
    u_warehouse_id INT,
    new_quantity INT,
    u_last_updated timestamp
);

INSERT INTO inventory_updates VALUES 		-- inserted two records in temperory tabler
(1, 1, 1, 100, current_timestamp),  		-- Update existing (to update a existing record)
(21, 20, 1, 500, current_timestamp); 		-- Insert new (to insert a new record)

select * from inventory;
select * from inventory_updates;

-- Write a MERGE (UPSERT) query to update inventory quantities, inserting new records if they don't exist.
-- The ON (DUPLICATE KEY UPDATE) clause is used with the INSERT INTO statement to specify how to handle duplicates based on a unique key or primary key constraint
insert into inventory(inventory_id, product_id, warehouse_id, quantity, last_updated) 
select u_inventory_id, u_product_id, u_warehouse_id, new_quantity, u_last_updated 
from inventory_updates
on duplicate key update
    quantity = VALUES(quantity),
    last_updated = VALUES(last_updated);
    
    
-- If a row with inventory_id = 1, product_id = 1 and warehouse_id = 1 does not exist, 
-- a new row will be inserted with the provided values in the temperory inventory_updates table.

-- If a conflicting row already exists, the (quantity) and the (last_updated) column of that existing row 
-- will be updated to the provided values in the temperory (inventory_updates) table.




-- tried on a simple example
-- Insert using ON DUPLICATE KEY UPDATE
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  email VARCHAR(100)
);

INSERT INTO users (user_id, username, email)
VALUES (1, 'john_doe', 'john@example.com'), (3, "Kartik", "kartik.com")
ON DUPLICATE KEY UPDATE email = 'kartik@tyagi.com';

INSERT INTO users (user_id, username, email)
VALUES (9, "skskjvnk", "kartik.com")
ON DUPLICATE KEY UPDATE email = 'kartik@tyagi.com';

select * from users;
select current_timestamp() as time;