-- Question 14 (Single-Row and Multi-Row Subqueries)
-- Find products that meet ALL these conditions:
-- - Price higher than average category price (single-row subquery)
-- - Stocked in warehouses with >80% capacity utilization (multi-row subquery)
-- - Total inventory value higher than any Sports category product (multi-row subquery)

-- Expected Output:
-- product_name    | category   | price  | total_value | warehouses
-- ----------------|------------|--------|-------------|-----------------
-- Gaming Mouse    | Electronics| 199.99 | 45000.50    | Seattle, Dallas
-- Smart Watch     | Electronics| 159.99 | 42500.75    | Chicago, Boston



select * from products;
select * from inventory;
select * from warehouses;


select p.product_name,
p.category,
p.base_price,
sum(i.quantity*p.base_price) total_value,
sum(i.quantity) quantity,
w.location
from products p join inventory i
on p.product_id = i.product_id
join warehouses w 
on i.warehouse_id = w.warehouse_id
where p.base_price > (
    select avg(base_price) as temp 
    from products 
    group by category 
    having category = p.category)
and 
w.warehouse_id = (
    select warehouse_id from (
        select product_id, 
        sum(quantity) qt, 
        warehouse_id from inventory 
        group by product_id 
        having product_id = i.product_id 
        and qt > .01 * (w.capacity)) temp)
and
i.quantity * p.base_price > (
    select max(i1.quantity * p1.base_price) 
    from products p1 join inventory i1 
    on p1.product_id = i1.product_id 
    where p1.category = "Sports") 
    
group by p.product_name;


--  we need to select the products which satisfies the following condition
		-- product having price heigher than average category price
				-- to do this we are finding average price for each category
                -- comapring the average category price wioth the priduct price in the outer query
		-- product stocked in warehouses with >80% capacity utilization
				-- finding the warehouse id having quantity of any product more than 80% of capacity of warehouse
		-- products having total inventory value higher than any Sports category product
				-- finding the product having maximum value (quantity * bnase_price) withing sports category
                -- selecting the product from outer query having more value than the product from the inner subquery.
-- at last selecting the required columns in the outer query




-- extra queries
-- desc inventory;
-- select product_id, sum(quantity) qt, warehouse_id from inventory group by product_id having qt > 0.01 * (w.capacity);
-- select product_id, sum(quantity) qt, warehouse_id from inventory group by product_id;
-- select category, avg(base_price) from products group by category;
-- select product_id, sum(quantity) qt, warehouse_id from inventory group by product_id;


 