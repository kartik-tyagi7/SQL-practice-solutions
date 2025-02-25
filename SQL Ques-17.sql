-- Question 17 (FIRST_VALUE, LAST_VALUE, NTILE)
-- Analyze product performance by:
-- - First and last products sold in each category
-- - Product price quartiles within category
-- - Comparison with category boundaries

-- Expected Output:
-- category    | product_name | price | first_sold | last_sold | quartile | price_range
-- ------------|-------------|-------|------------|-----------|----------|-------------
-- Electronics | Smart Watch | 199.99| Earbuds    | Keyboard  | 4        | High
-- Sports      | Yoga Mat    | 29.99 | Shoes      | Weights   | 2        | Medium-Low

select * from products;
select * from inventory;


select *, 
case when quartile = 1 then 'Low' 
when quartile = 2 then 'Medium' 
when quartile = 3 then 'High' end as price_range 
from (
	select p.category, 
    p.product_name, 
    p.base_price,
	first_value(p.product_name) over(partition by p.category order by i.last_updated asc) as first_sold,
	last_value(p.product_name) over
		(partition by p.category order by i.last_updated asc rows between unbounded preceding and unbounded following) as last_sold,
	ntile(3) over(partition by p.category) as quartile
from products p join inventory i 
on p.product_id = i.product_id) as temp;


-- we are joining product and inventory table on product_id
-- simply selecting category, product_name, base_price from joined table
-- Now,
	-- we need first sold and last product in each category.
        -- we will partition the data by category and order by last_updated asc.
        -- then will find first_value() for first sold product
        -- and last_value() for last sold product.
        -- we need to apply framing clause in last_value() for expected and correct result
        
-- then 
    -- we will divide each category in 3 quartile using ntile() function
    -- ntile() will take a number as parameter.
    -- will categorise the entire data in three category ('Low', 'Medium', 'High') based on the value assigned by ntile()
    
-- at last
    -- select the required columns from the above query using a outer query.

	
    