USE CASE_STUDY2;


--Simple Queries:

--1. List all the employee details.

SELECT * FROM EMPLOYEE;

--2. List all the department details.

SELECT * FROM DEPARTMENT;

--3. List all job details.

SELECT * FROM JOB

--4. List all the locations.

SELECT * FROM LOCATION

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

SELECT FIRST_NAME,LAST_NAME, SALARY,COMM
FROM EMPLOYEE;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"

SELECT Employee_ID, Last_Name, Department_ID AS DEP_ID
FROM EMPLOYEE;

--7. List out the annual salary of the employees with their names only.

SELECT FIRST_NAME,LAST_NAME,MIDDLE_NAME, SALARY
FROM EMPLOYEE;

--WHERE Condition:
--1. List the details about "Smith".

SELECT * 
FROM EMPLOYEE
WHERE LAST_NAME ='Smith';

--2. List out the employees who are working in department 20.

SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID =20;

--3. List out the employees who are earning salaries between 3000 and4500.

SELECT * 
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000 AND 4500;

--4. List out the employees who are working in department 10 or 20.

SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (10,20);

--5. Find out the employees who are not working in department 10 or 30.

SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID NOT IN (10,20);

--6. List out the employees whose name starts with 'S'.

SELECT * 
FROM EMPLOYEE
WHERE FIRST_NAME  LIKE 'S%';

--7. List out the employees whose name starts with 'S' and ends with 'H'.

SELECT * 
FROM EMPLOYEE
WHERE FIRST_NAME  LIKE 'S%H';

--8. List out the employees whose name length is 4 and start with 'S'.

SELECT * 
FROM EMPLOYEE
WHERE FIRST_NAME  LIKE 'S%' AND LEN(FIRST_NAME)=4;

--9. List out employees who are working in department 10 and draw salaries more than 3500.

SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID =10 AND SALARY>3500;


--10. List out the employees who are not receiving commission.

SELECT * 
FROM EMPLOYEE
WHERE COMM IS NULL;

--ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

SELECT EMPLOYEE_ID,LAST_NAME
FROM EMPLOYEE
ORDER BY EMPLOYEE_ID DESC;

--2. List out the Employee ID and Name in descending order based on salary.

SELECT EMPLOYEE_ID,FIRST_NAME
FROM EMPLOYEE
ORDER BY SALARY DESC;

--3. List out the employee details according to their Last Name in ascending-order.

SELECT * 
FROM EMPLOYEE
ORDER BY FIRST_NAME ASC;


--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order. 

SELECT * 
FROM EMPLOYEE
ORDER BY LAST_NAME ASC,DEPARTMENT_ID DESC;

   
 --GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?

SELECT DEPARTMENT_ID, COUNT(*) AS EMP_COUNT
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--2. List out the department wise maximum salary, minimum salary and average salary of the employees.

SELECT DEPARTMENT_ID,MAX(SALARY)AS MAX_SALARY, MIN(SALARY) AS MIN_SALARY, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.

SELECT JOB_ID,MAX(SALARY)AS MAX_SALARY, MIN(SALARY) AS MIN_SALARY, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY JOB_ID;

--4. List out the number of employees who joined each month in ascendingorder.

SELECT MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY MONTH(HIRE_DATE)
ORDER BY MONTH(HIRE_DATE) ASC;

--5. List out the number of employees for each month and year in ascending order based on the year and month.

SELECT  YEAR(HIRE_DATE)AS JOIN_YEAR ,MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)
ORDER BY YEAR(HIRE_DATE) ASC,MONTH(HIRE_DATE) ASC;

--6. List out the Department ID having at least four employees.

SELECT DEPARTMENT_ID 
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>3;

--7. How many employees joined in the month of January?

SELECT MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY MONTH(HIRE_DATE)
HAVING MONTH(HIRE_DATE) =1;

--8. How many employees joined in the month of January or September?

SELECT MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY MONTH(HIRE_DATE)
HAVING MONTH(HIRE_DATE) IN(1,9);

--9. How many employees joined in 1985?

SELECT  YEAR(HIRE_DATE)AS JOIN_YEAR ,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE)
HAVING YEAR(HIRE_DATE)=1985

--10. How many employees joined each month in 1985?

SELECT  YEAR(HIRE_DATE)AS JOIN_YEAR ,MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985;

--11. How many employees joined in March 1985?

SELECT  YEAR(HIRE_DATE)AS JOIN_YEAR ,MONTH(HIRE_DATE) AS JOIN_MONTH,COUNT(*) AS JOIN_EMP_COUNT
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE)=3;

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT DEPARTMENT_ID 
FROM EMPLOYEE
WHERE YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE)=2
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>2 ;


Joins:
--1. List out employees with their department names.

SELECT CONCAT(E.FIRST_NAME ,' ', E.MIDDLE_NAME,' ', E.LAST_NAME) AS EMP_NAME, D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id

--2. Display employees with their designations.

SELECT CONCAT(E.FIRST_NAME ,' ', E.MIDDLE_NAME,' ', E.LAST_NAME) AS EMP_NAME, J.Designation
FROM JOB J
JOIN EMPLOYEE E
ON E.JOB_ID = J.Job_ID


--3. Display the employees with their department names and regional groups.

SELECT CONCAT(E.FIRST_NAME ,' ', E.MIDDLE_NAME,' ', E.LAST_NAME) AS EMP_NAME,D.NAME,L.City
FROM DEPARTMENT D
JOIN LOCATION L
ON D.Location_Id=L.Location_ID
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id

--4. How many employees are working in different departments? Display with department names.

SELECT COUNT(E.EMPLOYEE_ID) AS EMPLOYEE_COUNT, D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name;

--5. How many employees are working in the sales department?

SELECT COUNT(E.EMPLOYEE_ID) AS EMPLOYEE_COUNT, D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING D.Name = 'Sales';

--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.

SELECT COUNT(E.EMPLOYEE_ID) AS EMPLOYEE_COUNT, D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING COUNT(E.EMPLOYEE_ID)>=5
ORDER BY D.Name ASC;

--7. How many jobs are there in the organization? Display with designations.

SELECT COUNT(E.JOB_ID)AS JOB_COUNT, J.Designation
FROM JOB J
JOIN EMPLOYEE E
ON E.JOB_ID = J.Job_ID
GROUP BY J.DESIGNATION


--8. How many employees are working in "New York"?

SELECT COUNT(E.EMPLOYEE_ID)AS EMP_COUNT,L.City
FROM DEPARTMENT D
JOIN LOCATION L
ON D.Location_Id=L.Location_ID
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
WHERE L.CITY = 'New York'
GROUP BY L.CITY;


--9. Display the employee details with salary grades. Use conditional statement to create a grade column.

SELECT * ,
(CASE
   WHEN SALARY >2500 THEN 'GRADE 1'
   WHEN SALARY >2000 THEN 'GRADE 2'
   WHEN SALARY >1500 THEN 'GRADE 3'
   WHEN SALARY >1000 THEN 'GRADE 4'
   ELSE
   'GRADE 5'
END   ) AS SALARY_GRADE
FROM EMPLOYEE
ORDER BY SALARY DESC;

--10. List out the number of employees grade wise. Use conditional statementto create a grade column.

WITH GRADE AS (
SELECT * ,
(CASE
   WHEN SALARY >2500 THEN 'GRADE 1'
   WHEN SALARY >2000 THEN 'GRADE 2'
   WHEN SALARY >1500 THEN 'GRADE 3'
   WHEN SALARY >1000 THEN 'GRADE 4'
   ELSE
   'GRADE 5'
END   ) AS SALARY_GRADE
FROM EMPLOYEE
)
SELECT COUNT(*)AS EMP_COUNT,SALARY_GRADE
FROM GRADE
GROUP BY SALARY_GRADE;


--11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

WITH GRADE AS (
SELECT SALARY,
(CASE
   WHEN SALARY >2500 THEN 'GRADE 1'
   WHEN SALARY >2000 THEN 'GRADE 2'
   WHEN SALARY >1500 THEN 'GRADE 3'
   WHEN SALARY >1000 THEN 'GRADE 4'
   ELSE
   'GRADE 5'
END   ) AS SALARY_GRADE
FROM EMPLOYEE
)
SELECT COUNT(*)AS EMP_COUNT,SALARY_GRADE
FROM GRADE
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY SALARY_GRADE;


--12. Display all employees in sales or operation departments.

SELECT COUNT(*)AS EMP_COUNT, D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING D.Name IN ('Sales','Operations');

--SET Operators:

--1. List out the distinct jobs in sales and accounting departments.

SELECT DISTINCT J.DESIGNATION,D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON J.Job_ID = E.JOB_ID
WHERE D.NAME IN ('Accounting','Sales');


--2. List out all the jobs in sales and accounting departments.

SELECT J.DESIGNATION,D.NAME
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON J.Job_ID = E.JOB_ID
WHERE D.NAME IN ('Accounting','Sales');

--3. List out the common jobs in research and accounting departments in ascending order.

WITH JOBS AS (
SELECT J.DESIGNATION AS DESIGNATION,D.NAME AS DEPARTMENT
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON J.Job_ID = E.JOB_ID
WHERE D.NAME IN ('Acounting','Research')
)
SELECT DISTINCT J1.DESIGNATION
FROM JOBS J1,JOBS J2
WHERE J1.DESIGNATION = J2.DESIGNATION AND J1.DEPARTMENT != J2.DEPARTMENT

--ALTERNATE METHOD

SELECT J.DESIGNATION
FROM DEPARTMENT D
JOIN EMPLOYEE E ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON J.Job_ID = E.JOB_ID
WHERE D.NAME = 'Accounting'

INTERSECT

SELECT J.DESIGNATION
FROM DEPARTMENT D
JOIN EMPLOYEE E ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON J.Job_ID = E.JOB_ID
WHERE D.NAME = 'Research';

--Subqueries:


--1. Display the employees list who got the maximum salary.

SELECT * 
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE)


--2. Display the employees who are working in the sales department.

SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME = 'Sales')

--ALTERNATE METHOD

SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales'


--3. Display the employees who are working as 'Clerk'.

SELECT * 
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE Designation = 'Clerk')

--4. Display the list of employees who are living in "New York".

SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Location_Id = (SELECT Location_Id FROM LOCATION WHERE CITY = 'New York')


--5. Find out the number of employees working in the sales department.

SELECT COUNT(E.EMPLOYEE_ID) AS EMP_COUNT, E.DEPARTMENT_ID
FROM EMPLOYEE E
WHERE E.DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME = 'Sales')
GROUP BY E.DEPARTMENT_ID

--ALTERNATE METHOD

SELECT COUNT(E.EMPLOYEE_ID) AS EMP_COUNT,D.NAME AS DEPARTMENT
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales'
GROUP BY D.NAME

--6. Update the salaries of employees who are working as clerks on the basis of 10%.

UPDATE EMPLOYEE
SET SALARY = SALARY + SALARY * 0.1
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE Designation = 'Clerk')


--7. Delete the employees who are working in the accounting department.


DELETE  FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT D.DEPARTMENT_ID FROM DEPARTMENT D 
                       WHERE D.NAME = 'Accounting')

--8. Display the second highest salary drawing employee details.

SELECT TOP 1 SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT TOP 2 SALARY FROM EMPLOYEE
                 ORDER BY SALARY DESC)
ORDER BY SALARY ASC;



--9. Display the nth highest salary drawing employee details.

DECLARE @N INT=2;--CHANGE @N AS PER YOUR CHOICE
WITH TOP_nth_SALARY as(
SELECT SALARY,
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNK
FROM EMPLOYEE
)
SELECT SALARY
FROM TOP_nth_SALARY
WHERE RNK = @N



--10. List out the employees who earn more than every employee in department 30.

SELECT *
FROM EMPLOYEE
WHERE SALARY =(SELECT MAX(SALARY)
               FROM EMPLOYEE
               WHERE DEPARTMENT_ID = 30)
	  AND DEPARTMENT_ID = 30 ;


--11. List out the employees who earn more than the lowest salary in department.

SELECT *
FROM EMPLOYEE E
WHERE SALARY > (
    SELECT MIN(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
);


--12. Find out which department has no employees.

SELECT D.NAME
FROM DEPARTMENT D
WHERE D.Department_Id NOT IN ( SELECT DISTINCT Department_Id
                               FROM EMPLOYEE );

--13. Find out the employees who earn greater than the average salary for their department

SELECT *
FROM EMPLOYEE E
WHERE SALARY > (
    SELECT avg(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);