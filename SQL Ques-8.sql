-- Question 8 (UNION and UNION ALL)
-- Create a report showing:
-- 1. Products with zero inventory (from LEFT JOIN)
-- 2. Products with over 400 units in any warehouse
-- 3. Products with value over $10,000 in any warehouse
-- Label each row with its source category.

-- Expected Output:
-- source_category | product_name    | quantity | value
-- ----------------|----------------|----------|-------
-- No Stock        | Smart Watch    | 0        | 0.00
-- High Stock      | Backpack       | 450      | 22495.50
-- High Value      | Gaming Mouse   | 350      | 20996.50


-- solution
select "No Stock" as source_category, p.product_name, 0 as quantity, 0.00 as value  
from products p left join inventory i on p.product_id = i.product_id 
where i.quantity is null
union all
select "High Stock" as source_category, p.product_name, i.quantity, (p.base_price * i.quantity) value 
from products p join inventory i on p.product_id = i.product_id 
where i.quantity > 400
union all
select "High Value" as source_category, p.product_name, i.quantity, (p.base_price * i.quantity) value 
from products p join inventory i on p.product_id = i.product_id 
where (p.base_price * i.quantity) > 10000;


-- we will select a new column "source_category" in the result having values ("No Stock", "High Stock", "High Value") based on following conditions. 
-- to find "NO Stock" in source_category column we need to left join product and inventory and then filter the quantity values based on null values
-- to find "High Stoch" in source_category column we need to join product and inventory and then filter result based on quantity > 400
-- to find "High value" in source_category column we need to join product and inventory and then filter result based on (p.base_price * i.quantity) > 10000
-- At last we will union all the record from these three queries to find the result.


