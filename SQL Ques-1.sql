-- Question-1 => Find all products and their current inventory levels in Seattle warehouse (warehouse_id = 1), 
-- including products with no inventory. Display product name, category, and quantity. Order by quantity descending, with NULLs last.


-- in this ques we need all the products
-- we will left join products and inventory table (putting products at the left position and inventory at the right)
-- at last will filter data using where clause and sort it in descending order based on quantity

select p.product_name, p.category, i.quantity
from products p 
left join inventory i on p.product_id = i.product_id        -- common column is product id
where i.warehouse_id = 1
order by i.quantity desc;


