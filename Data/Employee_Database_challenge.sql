-- --Creating tables for PH-EmployeeDB

-- DROP TABLE departments CASCADE; 
-- CREATE TABLE departments (
--      dept_no VARCHAR(4) NOT NULL,
--      dept_name VARCHAR(40) NOT NULL,
--      PRIMARY KEY (dept_no),
--      UNIQUE (dept_name)
-- );

-- SELECT * FROM departments;

-- DROP TABLE employees CASCADE;
-- CREATE TABLE employees (
--      emp_no INT NOT NULL,
--      birth_date DATE NOT NULL,
--      first_name VARCHAR NOT NULL,
--      last_name VARCHAR NOT NULL,
--      gender VARCHAR NOT NULL,
--      hire_date DATE NOT NULL,
--      PRIMARY KEY (emp_no)
-- );

-- SELECT * FROM employees;

-- DROP TABLE dept_manager;
-- CREATE TABLE dept_manager (
-- 	dept_no VARCHAR(4) NOT NULL,
--     emp_no INT NOT NULL,
--     from_date DATE NOT NULL,
--     to_date DATE NOT NULL,
-- FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
-- FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
--     PRIMARY KEY (emp_no, dept_no)
-- );

-- SELECT * FROM dept_manager;


-- DROP TABLE salaries;
-- CREATE TABLE salaries (
--   emp_no INT NOT NULL,
--   salary INT NOT NULL,
--   from_date DATE NOT NULL,
--   to_date DATE NOT NULL,
--   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
--   PRIMARY KEY (emp_no, from_date)
-- );

-- SELECT * FROM salaries
-- ORDER BY to_date DESC;

-- DROP TABLE dept_emp;
-- CREATE TABLE dept_emp (
--  	emp_no INT NOT NULL,
-- 	dept_no VARCHAR NOT NULL,
--  	from_date DATE NOT NULL,
--   	to_date DATE NOT NULL,
-- FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
-- FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
--     PRIMARY KEY (emp_no, dept_no)
-- );

-- SELECT * FROM dept_emp;


-- DROP TABLE title;
-- CREATE TABLE title (
--     emp_no INT NOT NULL,
--     title VARCHAR NOT NULL,
-- 	from_date DATE NOT NULL,
--     to_date DATE,
-- FOREIGN KEY (emp_no) REFERENCES employees (emp_no),	
-- PRIMARY KEY (emp_no, title, from_date)
-- );

-- SELECT * FROM title;

-- SELECT emp_no, first_name, last_name
-- FROM employees


-- SELECT title, from_date, to_date
-- From title


-- SELECT emp_no, first_name, last_name
-- INTO retirement_table
-- FROM employees

-- SELECT * FROM retirement_table

-- SELECT first_name, last_name
-- FROM employees
-- WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


-- SELECT first_name, last_name
-- FROM employees
-- WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- SELECT first_name, last_name
-- FROM employees
-- WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';


-- SELECT first_name, last_name
-- FROM employees
-- WHERE birth_date BETWEEN '1952-01-01' AND '1954-12-31';


-- Retirement eligibility
-- SELECT first_name, last_name
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Number of employees retiring
-- SELECT COUNT(first_name)
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- SELECT first_name, last_name
-- INTO retirement_info
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- SELECT * FROM retirement_info;
-- DROP TABLE retirement_info;

-- Create new table for retiring employees
-- SELECT emp_no, first_name, last_name
-- INTO retirement_info
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
-- SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
-- SELECT departments.dept_name,
--      dept_manager.emp_no,
--      dept_manager.from_date,
--      dept_manager.to_date
-- FROM departments
-- INNER JOIN dept_manager
-- ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
-- SELECT retirement_info.emp_no,
--     retirement_info.first_name,
-- 	retirement_info.last_name,
--     dept_emp.to_date
-- 	FROM retirement_info
-- 	LEFT JOIN dept_emp
-- 	ON retirement_info.emp_no = dept_emp.emp_no;
	
-- Shorten the code and provide greater readability by using an alias instead of a full tablename.	
-- SELECT d.dept_name,
--      dm.emp_no,
--      dm.from_date,
--      dm.to_date
-- 	FROM departments as d
-- INNER JOIN dept_manager as dm
-- ON d.dept_no = dm.dept_no;
	
-- SELECT ri.emp_no,
--     ri.first_name,
-- ri.last_name,
--     de.to_date
-- 	FROM retirement_info as ri
-- LEFT JOIN dept_emp as de
-- ON ri.emp_no = de.emp_no;

-- Use Left Join for retirement_info and dept_emp tables
-- SELECT ri.emp_no,
--     ri.first_name,
--     ri.last_name,
-- de.to_date
-- INTO current_emp
-- FROM retirement_info as ri
-- LEFT JOIN dept_emp as de
-- ON ri.emp_no = de.emp_no
-- WHERE de.to_date = ('9999-01-01');

-- SELECT * FROM current_emp


-- Employee count by department number
-- SELECT COUNT(ce.emp_no), de.dept_no
-- FROM current_emp as ce
-- LEFT JOIN dept_emp as de
-- ON ce.emp_no = de.emp_no
-- GROUP BY de.dept_no;

-- Employee count by department number
-- SELECT COUNT(ce.emp_no), de.dept_no
-- FROM current_emp as ce
-- LEFT JOIN dept_emp as de
-- ON ce.emp_no = de.emp_no
-- GROUP BY de.dept_no
-- ORDER BY de.dept_no;


--List 1: Employee Information

-- Create new table for retiring employees
-- SELECT e.emp_no,
--     e.first_name,
-- e.last_name,
--     e.gender,
-- 	s.salary,
-- 	de.to_date
-- -- INTO emp_info
-- FROM employees as e
-- INNER JOIN salaries as s
-- ON (e.emp_no = s.emp_no)
-- INNER JOIN dept_emp as de
-- ON (e.emp_no = de.emp_no)
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- AND (de.to_date = '9999-01-01');


-- -- Check the table
-- SELECT * FROM emp_info;

--List 2: Management
-- List of managers per department
-- SELECT  dm.dept_no,
--         d.dept_name,
--         dm.emp_no,
--         ce.last_name,
--         ce.first_name,
--         dm.from_date,
--         dm.to_date
-- INTO manager_info
-- FROM dept_manager AS dm
--     INNER JOIN departments AS d
--         ON (dm.dept_no = d.dept_no)
--     INNER JOIN current_emp AS ce
--         ON (dm.emp_no = ce.emp_no);


--List 3: Department Retirees
-- SELECT ce.emp_no,
-- ce.first_name,
-- ce.last_name,
-- d.dept_name
-- -- INTO dept_info
-- FROM current_emp as ce
-- INNER JOIN dept_emp AS de
-- ON (ce.emp_no = de.emp_no)
-- INNER JOIN departments AS d
-- ON (de.dept_no = d.dept_no);

-- DROP TABLE retirement_titles
-- SELECT e.emp_no,
--     e.first_name,
-- 	e.last_name,
--     t.title,
-- 	t.from_date,
--     t.to_date
-- INTO retirement_titles
-- FROM employees as e
-- INNER JOIN title as t
-- ON (e.emp_no = t.emp_no)
-- WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- ORDER BY e.emp_no;   

--review retirement file
-- SELECT * FROM retirement_titles
-- SELECT COUNT (emp_no) FROM retirement_titles


-- SELECT DISTINCT ON (e.emp_no) e.emp_no,
--     e.first_name,
-- 	e.last_name,
--     e.birth_date,
--     de.from_date,
--     de.to_date,
--     t.title
-- INTO mentorship_eligibility
-- FROM employees as e
-- INNER JOIN dept_emp as de
-- ON (e.emp_no = de.emp_no)
-- INNER JOIN title as t
-- ON (e.emp_no = t.emp_no)
-- WHERE (de.to_date = '9999-01-01')
-- 		AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- ORDER BY e.emp_no;

--review mentorship_eligibility file
-- SELECT * FROM mentorship_eligibility
-- SELECT COUNT (emp_no) FROM mentorship_eligibility





-- Use Dictinct with Orderby to remove duplicate rows
-- SELECT DISTINCT ON (r.emp_no) r.emp_no,
-- r.first_name,
-- r.last_name,
-- r.title
-- INTO unique_titles
-- FROM retirement_titles as r
-- ORDER BY r.emp_no, r.to_date DESC;

--review unique titles file
-- Select * FROM unique_titles
-- SELECT COUNT (emp_no) FROM unique_titles

--Number of Employees by most recent job title about to retirement
-- SELECT COUNT(u.emp_no), u.title
-- INTO retiring_titles
-- FROM unique_titles as u
-- GROUP BY u.title
-- ORDER BY count DESC;


--review retirement_titles file
-- SELECT * FROM retiring_titles
-- SELECT SUM (count) FROM retiring_titles
