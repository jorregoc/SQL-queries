-- Find names of all employees who have sold over 30.000 to a single client
SELECT employee.emp_id, employee.first_name, works_with.total_sales, works_with.client_id
FROM employee
RIGHT JOIN works_with ON employee.emp_id = works_with.emp_id
WHERE works_with.total_sales > 30000;
-- or
SELECT employee.first_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 30000);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_name 
FROM client
WHERE client.branch_id IN(
							SELECT branch.branch_id
							FROM branch
							JOIN employee ON branch.mgr_id = employee.emp_id
							WHERE employee.emp_id = 102
);
-- or
SELECT client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
                          FROM branch
                          WHERE branch.mgr_id = 102);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you don't know Michael's ID
SELECT client.client_name 
FROM client
WHERE client.branch_id IN	(
							SELECT branch.branch_id
							FROM branch
							JOIN employee ON branch.mgr_id = employee.emp_id
							WHERE employee.first_name = 'Michael' AND employee.last_name = 'Scott'
							);
                            
-- Find the names of employees who work with clients handled by the scranton branch
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;

-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client_name
FROM client
WHERE client_id IN (
					SELECT client_id
					FROM (
							SELECT SUM(works_with.total_sales) AS totals, client_id
							FROM works_with
							GROUP BY client_id) AS total_client_sales
					WHERE totals > 100000
                    );