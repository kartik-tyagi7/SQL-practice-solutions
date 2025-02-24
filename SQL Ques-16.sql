-- Question 16
-- Find all pairs of products that:
-- - Are in the same category
-- - Have price difference < $20
-- - Are stocked in same warehouse
-- List them as potential substitute products.

-- Expected Output:
-- category    | product1     | price1 | product2     | price2  | warehouse
-- ------------|------------- |--------|--------------|---------|----------
-- Electronics | Gaming Mouse | 59.99  | Keyboard     | 49.99   | Seattle
-- Sports      | Yoga Mat     | 29.99  | Water Bottle | 19.99   | Dallas


select * from warehouses;
select * from products;
select * from inventory;


select p1.category as category,
p1.product_name as product1,
p1.base_price as price1,										    -- selecting the required columns from all the tables
p2.product_name as product2,
p2.base_price as price2,
w.location as warehouse
from products p1 join products p2 on p1.category = p2.category      -- product should be from same category
join inventory i on p1.product_id = i.product_id 						
join warehouses w on w.warehouse_id = i.warehouse_id 
where p1.product_id != p2.product_id and 							-- product_id should not match (to avoid extra rows from the self join)
abs(p1.base_price - p2.base_price) < 20;							-- finding the difference between the base price of the products


-- we are joining products table with itself because we need to campare the price of different products with each other
-- then we will join with invnetory and warehouses because we need columns from warehouse table


