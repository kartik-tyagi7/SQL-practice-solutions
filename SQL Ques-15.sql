-- Question 15 (RANK, DENSE_RANK, ROW_NUMBER)
-- Create a warehouse performance report showing:
-- - Regular ranking by total inventory value
-- - Dense ranking by number of products
-- - Row number by average quantity
-- Include only warehouses handling >5 products.

-- Expected Output:
-- warehouse    | total_value| value_rank | products | product_rank | avg_qty | qty_rn
-- -------------|------------|------------|----------|--------------|---------|--------
-- Chicago      | 120500.75  | 1          | 12       | 1            | 245     | 3
-- Dallas       | 120500.75  | 1          | 10       | 2            | 300     | 1
-- Seattle      | 98750.50   | 3          | 10       | 2            | 280     | 2


select * from warehouses;   
select * from inventory;
select * from products;


select w.location, 
sum(i.quantity * p.base_price) as total_value,
-- total inventory value will be calculated by sum(i.quantity * p.base_price) for every warehouse_id. 
rank() over(order by sum(i.quantity * p.base_price) desc) as value_rank,
-- above rank() function will assign rank for each row based on total_value in decreasing order.
count(*) as product,
-- the above statement will count the total number of product in each warehouse.
dense_rank() over(order by count(*)) as product_rank,
-- above dense_rank function will assign densed rank for each row based on the number of product in each warehouse.
round(avg(i.quantity) over(rows between unbounded preceding and current row)) as avg_qty,
-- finding the average quantity in each warehouse 
row_number() over(rows between unbounded preceding and unbounded following) as qty_rn
-- assigning row number by using row_number() over the complete window of rows
from products p 
join inventory i
on p.product_id = i.product_id   			
join warehouses w 
on w.warehouse_id = i.warehouse_id
group by w.warehouse_id;   			-- grouping the records by warehouse_id



-- in this question we need to join all three tables because we are utilising all three of them to find the required result


