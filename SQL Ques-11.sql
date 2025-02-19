-- Question 11 (COALESCE, NULLIF, LPAD/RPAD)
-- Create a report showing formatted product details with:
-- - Product code (LPAD with zeros to 5 digits)
-- - Product name (RPAD with dots to 30 characters)
-- - Current stock (COALESCE with 'Out of Stock')
-- - Stock status (NULLIF comparison with minimum threshold)
-- For all products in Electronics category.

-- Expected Output:
-- product_code | formatted_name               | stock_level | status
-- -------------|------------------------------|-------------|--------
-- 00001        | Wireless Earbuds............ | 150         | NORMAL
-- 00002        | Gaming Mouse................ | Out of Stock| LOW
-- 00006        | Smart Watch................. | 175         | NULL



select lpad(p.product_id, 5, 0) as product_code,     
-- lpad will add required no. of zero in the left of product_id (total length required is 5)
rpad(p.product_name, 30, ".") as formatted_name,	 
-- rpad will add required no. of dots in the rioght of product_id (total length required is 30)
coalesce(quantity , "Out of stock") as stock_level,  
-- coalecse function will add "Out of stock" where there are null values in quantity column
nullif(
case when i.quantity > 0 and i.quantity <=100 then "LOW" 
when i.quantity > 100 and i.quantity <= 400 then "NORMAL"
when i.quantity > 400 then "High" 
else "Empty" end, null) as status
-- the nullif function takes two parameters, 
-- both are equal it return null and if both are unequal if returns the first parameter.
-- In first parameter, gave all the conditions, range and their respective value.
-- In second parameter, simply provided null.

from inventory i join products p on i.product_id = p.product_id  -- joined inventory and product table to get required columns
where p.category = "Electronics";

     


select lpad(product_id, 5, 0) from products;
select * from inventory;
select coalesce(quantity , "Out of stock") from inventory;

