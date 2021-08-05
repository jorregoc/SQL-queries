-- Find a list of employee and branch names
SELECT first_name AS employee_and_branch_name
FROM employee
UNION
SELECT branch_name
FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS Non_Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- Find a list of all money spent or earned by the company
SELECT SUM(salary) AS money_spent_or_earned
FROM employee
UNION
SELECT SUM(total_sales)
FROM works_with;
