-- Question 13 (LEAD/LAG Analysis)
-- Analyze inventory changes by comparing:
-- - Current quantity with previous month
-- - Current quantity with next month
-- - Percentage change from previous
-- - Projected next month change
-- For each product in a specific warehouse.

-- Expected Output:
-- product_name    | current_qty | prev_month_qty | next_month_qty | pct_change | projected_change
-- ----------------|-------------|----------------|----------------|------------|------------------
-- Wireless Earbuds| 150         | 120            | 180            | +25%       | +20%
-- Gaming Mouse    | 200         | 180            | 220            | +11%       | +10%
-- Smart Watch     | 175         | NULL           | 160            | NULL       | -8.5%


select * from products;
select * from inventory;
select * from warehouses;


select temp.product_name, 
temp.current_qty, 
temp.prev_month_qty, 
temp.pct_change, 
temp.projected_change 
from (
	select p.product_name as product_name, 
    i.last_updated,
	i.quantity as current_qty, 
	lag(i.quantity) over(partition by p.product_id order by i.last_updated) as prev_month_qty,
	lead(i.quantity) over(partition by p.product_id order by i.last_updated) as next_month_qty,
	round(((i.quantity - lag(i.quantity) over(partition by p.product_id order by i.last_updated)) / lag(i.quantity) over(partition by p.product_id order by i.last_updated)) * 100, 1) as pct_change,
	round(((lead(i.quantity) over(partition by p.product_id order by i.last_updated) - i.quantity) / i.quantity) * 100, 1) as projected_change
	from products p join inventory i
	on p.product_id = i.product_id) as temp
where month(temp.last_updated) = month(current_timestamp());



-- need to join product and inventory table on product_id
-- need to find out the current month quantity, previous month quantity and the next month quantity for each product
		-- using lag() function to find previous month quantity
		-- using lead() function to find next month quantity
-- also need to find the percentage change in quantity from previous to current month and from current to next month. 
		-- used percentage formula to get the percentage change from prev to current month and from current to next month
        -- for pct_change ->  ((current_qty - prev_month_qty) / prev_month_qty) * 100
        -- for projected_change ->  ((next_month_qty - current_qty) / current _qty) * 100
        -- rounding the percentage upto 1 decimal place
-- at last we are filtering the rows that have timestamp same as current timestamp to get only the data of current month
		-- because we only need to campare with the current month


