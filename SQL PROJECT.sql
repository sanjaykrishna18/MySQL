# creating database
create database project;

use project

-- created table employee, department_info and skill


select * from employee;
select * from department_info;
select * from skill;

-- Display all the employees who are getting 2500 and excess salaries in department 20.
select * from employee where sal >= 2500 and dep_no = 20;

-- Display all the managers working in 20 & 30 department.
select * from employee where job = 'manager' AND DEP_NO > 10;

-- Display all the managers who don’t have a manager
select * from employee where mgr is null;

-- Display all the employees who are getting some commission with their designation is neither MANANGER nor ANALYST
SELECT * FROM EMPLOYEE WHERE JOB = 'ANALYST' OR 'MANAGER' AND COMM>1;

-- Display all the ANALYSTs whose name doesn’t ends with ‘S’
select * from employee where job = 'analyst' and job not like '%s';

-- Display all the employees who total salary is more than 2000.
select *, sal+comm as total_sal from employee having total_sal > 2000;

-- Display all the employees whose naming is having letter ‘E’ as the last but one character
select * from employee where emp_name not like '%e_';

-- Display all the employees who are getting some commission in department 20 & 30.
select * from employee where dep_no in (20,30) and comm>0;

-- Display all the managers whose name doesn't start with A & S
select emp_name,job from employee where job = 'manager' and emp_name not like '[as]%';

 -- Display all the employees who earning salary not in the range of 2500 and 5000 in department 10 & 20
Select * from employee where  Sal not between 2500 and 5000 and dep_no in (10,20);

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annual sal.
SELECT EMP_NO, EMP_NAME, SAL, SAL/30 AS D_SAL, 12*SAL AS A_SAL FROM EMPLOYEE order by A_SAL ASC;

-- List the Enames those are having five characters in their Names.
SELECT EMP_NAME FROM EMPLOYEE WHERE LENGTH(EMP_NAME) = 5;

# GROUPING
-- Display job-wise maximum salary
SELECT JOB , MAX(SAL)
FROM EMPLOYEE
group by JOB;


-- Display the departments that are having more than 3 employees under it.
SELECT JOB,COUNT(EMP_NAME)
FROM EMPLOYEE
GROUP BY JOB
HAVING COUNT(EMP_NAME) > 3;



#Display department-wise total salaries for all the Managers and Analysts, only if the average salaries for the same is greater than or  equal to 3000 #
SELECT JOB, SUM(SAL), AVG(SAL)
FROM EMPLOYEE 
where job in ('manager','analyst')
group by job
having avg(sal) >= 3000;


-- Select only the duplicate records along-with their count.
select name,count(name)
from skill
group by name
having count(name) > 1;

-- Select only the non-duplicate records.
select distinct(name) from skill;

-- Select only the duplicate records that are duplicated only once.

select name,count(name)
from skill
group by name
having count(name) < 2;

# sub queries

-- Display all the employees who are earning more than all the managers.
select * from employee 
where sal > (select max(sal) from employee where job = 'manager')

-- Display all the employees who are earning more than any of the managers

select * from employee
where sal > (select min(sal) from employee where job = 'manager');

-- Select employee number, job & salaries of all the Analysts who are earning more than any of the managers.

select emp_no, job, sal from employee
where job = 'analyst' and sal > (select min(sal) from employee where job = 'manager');

-- Select department name & location of all the employees working for CLARK.
SELECT DEP_ID,DEP_NAME,LOCATION FROM DEPARTMENT_INFO WHERE DEP_ID=(SELECT DEP_NO FROM EMPLOYEE WHERE EMP_NAME='CLARK');

-- Select all the departmental information for all the managers
SELECT * FROM DEPARTMENT_INFO WHERE DEP_ID IN  (SELECT DEP_NO FROM EMPLOYEE WHERE JOB = 'MANAGER');

-- Select all the departmental information for all the managers
SELECT * FROM EMPLOYEE WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE);

-- Display the second maximum salary
SELECT  MAX(SAL) FROM EMPLOYEE WHERE SAL < (SELECT MAX(SAL) FROM EMPLOYEE);

-- Display third maximum salary
SELECT MAX(SAL) FROM EMPLOYEE WHERE SAL <(SELECT  MAX(SAL) FROM EMPLOYEE WHERE SAL < (SELECT MAX(SAL) FROM EMPLOYEE));

-- Display all the managers & clerks who work in Accounts and Marketing departments
SELECT * FROM EMPLOYEE WHERE JOB IN ('MANAGER' ,'CLERK')  AND DEP_NO IN (SELECT DEP_ID FROM DEPARTMENT_INFO WHERE 
DEP_NAME IN ('ACCOUNTING','SALES'));

-- Display all the salesmen who are not located at DALLAS.
SELECT * FROM EMPLOYEE WHERE JOB = 'CLERK' AND DEP_NO IN (SELECT DEP_ID FROM DEPARTMENT_INFO WHERE LOCATION <> 'DALAS');

-- Select all the employees who are earning same as SMITH
SELECT * FROM EMPLOYEE WHERE SAL = (SELECT SAL FROM EMPLOYEE WHERE EMP_NAME = 'SMITH');

-- Display all the employees who are getting more than the average salaries of all the employees
SELECT * FROM EMPLOYEE WHERE SAL < (SELECT AVG(SAL) FROM EMPLOYEE); 

-- Select all the employees who work in DALLAS.
select  employee.* ,department_info.location  from employee ,department_info 
where employee.dep_no=department_info.dep_ID and department_info.location='DALLAS';

-- Select department name & location of all the employees working for CLARK
select
employee.emp_name,
department_info.dep_name,
department_info.location
from employee, department_info
where employee.dep_no = department_info.dep_id and employee.emp_name = 'clark';

-- Select all the departmental information for all the managers
select department_info.* from employee, department_info
where employee.dep_no = department_info.dep_id and employee.job = 'manager';

