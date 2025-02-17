-- Question - 7 
-- Find product categories where:
-- - Average inventory value > $10,000
-- - At least 3 different products in stock
-- - Maximum quantity of any product > 200
-- Show category, product count, avg value, and highest stocked product name.

-- Expected Output:
-- category    | product_count | avg_value | highest_stocked_product
-- ------------|--------------|-----------|----------------------
-- Electronics | 5            | 12500.75  | Gaming Mouse
-- Sports      | 4            | 11200.50  | Yoga Mat
-- [...]

-- solution
select p.category, count(p.product_id) product_count, avg(p.base_price*i.quantity) avg_value, p.product_name   -- list of required column
from products p inner join inventory i         		-- joining products and inventory column(they are used to fetch diffrent columns)
on p.product_id = i.product_id						-- common column between products and inventory is product_id
group by p.category						-- here will are grouping by category because we need count, average, and product_name based on category of the product
having avg(p.base_price*i.quantity) > 10000 		-- condition after group by , average invontory value is calculated by avg(p.base_price*i.quantity)
and count(i.product_id) >= 3 			-- condition to filter result based on count(i.product_id)
and max(i.quantity) > 200;				-- condition to filter result based on max(i.quantity)



