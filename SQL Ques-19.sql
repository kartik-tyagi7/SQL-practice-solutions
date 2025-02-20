-- Question - 19
-- self join question
-- Create_the_Employees_table
CREATE TABLE Employees_linkedin2 (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(255),
hire_date DATE,
manager_id INT 
);

-- Insert_data_into_the_Employees_table
INSERT INTO Employees_linkedin2 (employee_id, employee_name, hire_date, manager_id) VALUES
(1, 'John Doe', '2023-01-15', NULL), 
(2, 'Jane Smith', '2023-02-20', 1),
(3, 'David Lee', '2023-03-10', 1),
(4, 'Sarah Jones', '2022-01-05', 2);

select * from Employees_linkedin2;


-- ques -> Write a query to find all employees who joined after their manager.
select e1.employee_name 
from Employees_linkedin2 e1 join Employees_linkedin2 e2 
on e1.manager_id = e2.employee_id and e1.hire_date > e2.hire_date;

-- In this question we will simply do a self join in Wmployees_linkdin2 table
-- we will compare the manager_id from first table and employee_id from the second table
-- then we will compare their hire date and will select employee_name from first table

