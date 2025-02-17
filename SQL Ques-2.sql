-- Question 2
-- List all warehouses that store electronics products, along with the total quantity and total value of electronics inventory (quantity * base_price). 
-- Only include warehouses with electronics inventory worth over $20,000. Order by total value descending.
 
 use sql_practice;
 select  * from warehouses;
 select *from products;
 select * FROM INVENTORY;
 
-- solution
select w.warehouse_id, w.location, sum(i.quantity) as total_quantity, sum(i.quantity*p.base_price) as total_value   -- columns that we need to select with aggregation function
from products p 
inner join inventory i on p.product_id = i.product_id      			-- joining products and inventory on (product_d)
inner join warehouses w on i.warehouse_id = w.warehouse_id			-- joining wartehouse and inventory on (warehouse_id)
where p.category = "Electronics"         			-- first we will filter based on "Electronics" category
group by w.warehouse_id								-- grouping by (warehouse_id) because we are having multiple records for one warehouse_id
having sum(i.quantity*p.base_price) > 20000			-- filtering result based on sum(i.quantity*p.base_price) 
order by total_value desc;							-- ordering result by total_value


-- Just to try something
select *
from products p 
inner join inventory i on p.product_id = i.product_id
inner join warehouses w on i.warehouse_id = w.warehouse_id
where category = "Electronics";

select i.warehouse_id, p.category from products p inner join inventory i on p.product_id = i.product_id where category = "Electronics";

