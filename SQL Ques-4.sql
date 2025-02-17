-- Question 4
-- Generate a report showing all possible product-warehouse combinations for 'Sports' category products and 'Large' type warehouses to help with expansion planning. 
-- Show product name, warehouse location, and warehouse capacity.

-- Expected Output:
-- product_name  | location    | capacity
-- -------------|-------------|----------
-- Yoga Mat     | Dallas, TX  | 15000
-- Yoga Mat     | Chicago, IL | 20000
-- Yoga Mat     | Houston, TX | 16000
-- Running Shoes| Dallas, TX  | 15000
-- more records (all combinations)


-- Solution
-- here we will apply cross join ->
-- In ques the ask is to generate all possible product-warehouse combination so, cross join would be the best fit because it will give
-- all the rows from products table multiply by all the records from warehouse table


select * from warehouses;   -- simply checked what are the fields in the warehouse table
select * from products;     -- check the fields in products table

select p.product_name, w.location, w.capacity 
from warehouses w cross join products p 
where p.category = "Sports" and w.warehouse_type = "Large";

-- after cartesian product we will apply a where condition to filter the records that are of "Sports" category and "Large" warehouse type.
