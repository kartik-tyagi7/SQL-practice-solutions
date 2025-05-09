-- Question 5
-- Generate a warehouse analytics report showing:
-- 		Total number of products
-- 		Average quantity per product
-- 		Total inventory value
-- 		Maximum and minimum stock levels
-- 		Number of distinct categories
-- Group by warehouse location and only show warehouses with total inventory value > $50,000.

-- Expected Output:
-- location    | product_count| avg_quantity | total_value | max_stock | min_stock | category_count
-- ------------|--------------|--------------|-------------|-----------|-----------|---------------
-- Chicago, IL | 8            | 245.5        | 75890.50    | 500       | 125       | 4
-- Dallas, TX  | 7            | 232.1        | 68720.25    | 450       | 100       | 3
-- [...]


-- in this question we will join three tables (products, warehouses, inventory) using inner join (because we will utilize columns from all 3 tables)
-- table products and inventory are connected with (product_id) column 
-- product_id(foreign key) in inventory table is referencing product_id(primary key) in the products table.
-- table inventory and warehouses are connected with (warehouse_id) column 
-- warehouse_id(foreign key) in inventory table is referencing product_id(warehouse_id) in the warehouses table.
-- after that we will group by the records by (location)
-- at last we will filter the records with where condition (total inventory value > 50000)

select w.location location, 
count(p.product_id) product_count, 
avg(i.quantity) avg_quantity, 
sum(p.base_price * i.quantity) total_value, 
max(i.quantity) max_stock, 
min(i.quantity) min_stock, 
count(p.category) category_count
from products p inner join inventory i on p.product_id = i.product_id
inner join warehouses w on i.warehouse_id = w.warehouse_id 
group by w.location having sum(p.base_price * i.quantity) > 50000;  
