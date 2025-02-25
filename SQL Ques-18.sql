-- Question 18 (Role-Based Access Control)
-- Create a permission structure for an inventory management system with these roles:
-- - Inventory Manager: Full access to all tables
-- - Stock Clerk: Can view all tables, update inventory quantities
-- - Analyst: Can only view (SELECT) all tables
-- - Auditor: Can only view inventory and audit_log tables

-- Expected Output after running GRANT commands:
-- Role              | Select | Insert | Update | Delete | References| Trigger
-- ------------------|--------|--------|--------|--------|-----------|----------
-- inventory_manager | Yes    | Yes    | Yes    | Yes    | Yes       | Yes
-- stock_clerk       | Yes    | No     | Partial| No     | No        | No
-- analyst           | Yes    | No     | No     | No     | No        | No
-- auditor           | Partial| No     | No     | No     | No        | No


create role 'inventory_manager';		-- created role 'inventory_manager'
create role 'stock_clerk';				-- created role 'stock_clerk'
create role 'analyst';					-- created role 'analyst'
create role 'auditor';					-- created role 'auditor'


grant select, insert, update, delete, references, trigger on * . * to 'inventory_manager';
-- granting the required permissions(select, insert, update, delete, references, trigger) on all tables to 'inventory_manager' role.

grant select on * . * to 'stock_clerk';
-- granting select on all tables to 'stock_clerk' role.

grant update on inventory to 'stock_clerk';
-- granting update on 'inventory' table to 'stock_clerk' role.

grant select on * . * to 'analyst';
-- granting select on all tables to 'analyst' role. 

grant select on inventory to 'auditor';
-- granting select on 'inventory' table to 'auditor' role.

grant select on audit_log to 'auditor';
-- granting select on 'audit_log' table to 'auditor' role.


show grants for 'inventory_manager';        -- checking premission


