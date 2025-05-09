-- for the Employees_linkedin2 table, try to write a Recursive query. 
-- Create a new column, that shows how many managers were there above him.
-- For eg:
-- for employee_id 4: he has 2 managers above him (employee_id: 2 and 1)
-- for employee_id: 2 and 3, has only 1 manager (employee_id: 1)
-- for employee_id:1, he is the manager (He reports to no one as his manager_id is null)



use sql_practice;
select * from employees_linkedin2;


with recursive emp_hie as (
    select employee_id, 
        employee_name, 
        manager_id, 0 as managers_above 
    from employees_linkedin2 
    where manager_id is null 
union all
    select d.employee_id, 
        d.employee_name, 
        d.manager_id, 
        h.managers_above+1
    from emp_hie h 
    join employees_linkedin2 d 
    on h.employee_id = d.manager_id
)
select * from emp_hie;


-- we need to use recursive query to solve this question
-- we are using CTE(common table exprtession) or WITH clause
-- In CTE there will be one base query and one recursive query
		-- In the base query we will find the employee who does not have any manager (manager_id is null).
        -- Also, we are adding a column (manager_above) stating the number of manager above any employee (0 for manager_id = null).
        -- In the base query we are finding the employee having no manager (top most level).
        -- In the recursive query we will increase manager_above by 1 in each iteration.
        -- we are joining the CTE(emp_hie) with employees_linkedin2 table on (h.employee_id = d.manager_id)
        
        
        
        
        