-- Question 12 (Cumulative Sum and Average)
-- Generate a monthly sales trend analysis showing:
-- - Running total of inventory value
-- - Running average of quantity
-- - Percentage of total inventory
-- Ordered by warehouse location and product category.

-- Expected Output:
-- location    | category   | quantity | running_total | running_avg | pct_of_total
-- ------------|------------|----------|---------------|-------------|-------------
-- Chicago, IL | Electronics| 250      | 12500.00      | 250.00      | 15.5
-- Chicago, IL | Sports     | 300      | 27500.00      | 275.00      | 28.3
-- Dallas, TX  | Electronics| 200      | 37500.00      | 250.00      | 35.8


select * from warehouses;
select * from products;
select * from inventory;

-- in this question we are using over clause to divide the table in set of records called window
-- we can use any aggregation function over a window or any king of window function for any calculation.
-- rows between unbounded preceding and current row -> means at a particular record all the records preceding that record must be taken in that window
-- rows between unbounded preceding and unbounded following -> entire table is treated as one window
-- rows between 2 preceding and 2 following -> at a particular row, rows from 2 preceding to 2 following would be treated as a window.
-- by using above window method we are calculating cummulative sum as running_total and cummulative average as running_avg
-- and percentage of total inventory at every record


select w.location, p.category, i.quantity,
round(sum(p.base_price * i.quantity) over(rows between unbounded preceding and current row),2) as running_total,   	-- cummulative sum as running_total
round(avg(i.quantity) over(rows between unbounded preceding and current row), 2) as running_avg,					-- cummulative average as running_avg
round((p.base_price * i.quantity) / sum(p.base_price * i.quantity) over(rows between unbounded preceding and unbounded following) * 100 , 1) as pct_of_total

-- simply joining all three tables because we are utilising all three of them for different columns
from products p 
join inventory i
on p.product_id = i.product_id   			
join warehouses w 
on w.warehouse_id = i.warehouse_id
order by w.location, p.category;   		-- ordering the resultant records by location then category


