-- DISTINCT values

select distinct salary
from Salaries;

Select distinct s.salary
from employees as e
join salaries as e
on e.emp_no = s.emp_no;

-- ALIAS - Renaming column heading to 'Employee Age' and 'Employee Salary' using JOIN. Since there is no age column in employees table

select
  e.emp_no,
  timestampdiff(year, e.birth_date, CURDATE()) as employee_age,
  s.salary as employee_salary
from employees e
join salaries s
on e.emp_no = s.emp_no
where s.to_date = '9999-01-01';

-- CLAUSE and OPERATORS 
-- 1. Retrieve employees with a salary greater than ₹50,000 and hired before 2016-01-01
-- We need employees who satisfy two conditions:
   -- Their salary must be greater than ₹50,000.
   -- Their hire date must be earlier than January 1, 2016.

select 
*from employees e
join salaries s
on e.emp_no = s.emp_no
where s.salary > 50000
and e.hire_date < '2016-01-01';

 -- Find the employee whose designation is missing and fill it with "Data Scientist"
   --   Find the employee records where the designation is missing.
   --  Update the missing designation to Data Scientist.


select emp_no, title, from_date, to_date	
From titles
where title is null or trim(title) = '';

SELECT emp_no, title, from_date, to_date
FROM titles
LIMIT 1;

SELECT emp_no, title, from_date
FROM titles
WHERE title = '';

UPDATE titles
SET title = 'Data Scientist'
WHERE emp_no = 10001 AND from_date = '1986-06-26' AND title = '';

UPDATE titles
SET title = 'Data Scientist'
WHERE title = '';

UPDATE titles
SET title = ''
WHERE emp_no = 10001 AND from_date = '1986-06-26';

   SELECT emp_no, title, from_date
   FROM titles
   WHERE emp_no = 10001 AND from_date = '1986-06-26';

UPDATE titles
SET title = 'Data Scientist'
WHERE emp_no = 10001 AND from_date = '1986-06-26' AND title = '';


-- SORTING and GROUPING: 
  -- Order By Find employees sorted by department ID in ascending order and salary in descending order 

select
 *from employees e
join salaries s
  on e.emp_no = s.emp_no
join dept_emp de
  on e.emp_no = de.emp_no
order by de.dept_no ASC, s.salary desc;

-- LIMIT -- Display the first 5 employees hired in the year 2018.

 -- Need to find the empoyee hired date range first
 select MIN(hire_date), MAX(hire_date)
  From employees;
select
 *from employees
    where hire_date >= '2018-01-01'
    and hire_date < '2019-01-01'
  order by 	hire_date asc
  limit 5;
  -- There no employee hired between 2018 and 2019. Hence no data 
  
  -- Aggregate Functions
  -- Need to Calculate total/ Sum of current salaries in the Finance department
select SUM(s.salary) AS finance_salary_total
from salaries as s
join dept_emp as de ON s.emp_no = de.emp_no
join departments AS d ON de.dept_no = d.dept_no
where d.dept_name = 'Finance'
  and s.to_date = '9999-01-01'
  and de.to_date = '9999-01-01';
  
  -- Need to find the Minimum age (age is calculated from birth_date)
select MIN(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS min_age
from employees;
  
-- GROUP BY
-- Average salary for each job title containing 'Analyst'

select t.title, AVG(s.salary) AS avg_salary
from titles AS t
join salaries AS s ON t.emp_no = s.emp_no
where t.title LIKE '%Analyst%'
  and t.to_date = '9999-01-01'
  and s.to_date = '9999-01-01'
group by t.title;
  
  -- There is no job title in the as "Analyst" in the Titles table. Hence wanted to check if the same queries is being displayed when using title present in the Tittle table ( Engineer )
  
  select distinct title from titles;
  
  select t.title, AVG(s.salary) AS avg_salary
from titles AS t
join salaries AS s ON t.emp_no = s.emp_no
where t.title LIKE '%Engineer%'
  and t.to_date = '9999-01-01'
  and s.to_date = '9999-01-01'
group by t.title;

-- HAVING 
  -- Need to find deparments with less than 3 employees	--
select d.dept_name, count(*) as emp_count
  from departments as d
  join dept_emp as de on d.dept_no = de.dept_no
  and de.to_date = '9999-01-01'
  group by d.dept_name
  having count(*) < 20000;
     
select d.dept_name, count(*) as emp_count
  from departments as d
  join dept_emp as de on d.dept_no = de.dept_no
  and de.to_date = '9999-01-01'
  group by d.dept_name
  having count(*) < 3;
   -- There are no departments with less <3 employee, so no data. Hence to verify used a count (*) < 20000.
   
   -- JOINS
   -- Inner Join  - Need to find employees designation and  departments 
        
describe employees;
describe departments;
describe dept_emp;
describe titles;
    
    SELECT
    e.first_name,
    e.last_name,
    t.title AS designation,
    d.dept_name
from employees e
inner join dept_emp de
    on e.emp_no = de.emp_no
inner join titles t
    on e.emp_no = t.emp_no
inner join departments d
    on de.dept_no = d.dept_no;
    
-- LEFT JOIN
-- List all departments along with the total number of employees in each department, including departments with no employees.
    
   select 
   d.dept_no,
   d.dept_name,
    count(de.emp_no) as total_employees
  from departments d
  Left join dept_emp de
    on d.dept_no = de.dept_no
  group by d.dept_no, d.dept_name;
  
  -- We use LEFT JOIN, as it includes every department: even when there are no employees in any deparments
   
   -- RIGHT JOIN
   -- Display all locations along with the names of employees assigned to each location. If no employees are assigned to a location, display NULL for employee name."
  
  describe location;
  show tables;
  SELECT
    d.dept_name,
    e.first_name,
    e.last_name
from dept_emp de
right join departments d
    on de.dept_no = d.dept_no
left join employees e
    on de.emp_no = e.emp_no;
  
