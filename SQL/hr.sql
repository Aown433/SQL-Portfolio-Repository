desc EMPLOYEE1 
create table EMPLOYEE1(
emp_salary number(18),
emp_id number(3),
emp_depart varchar(10),
emp_depart_id number(10),
emp_name varchar(15),
emp_hire_date number(5)
);
insert into EMPLOYEE1 values(18000,1, 'IT', 101, 'ali hamza',2010);
insert into EMPLOYEE1 values(19000,1, 'IT', 102, 'ali ',2005);
insert into EMPLOYEE1 values(21000,1, 'ECNOMICS', 103, ' hamza',2014);
insert into EMPLOYEE1 values(2000,1, 'CS', 104, 'ali ch',2018);
insert into EMPLOYEE1 values(17000,1, 'AI', 105, 'aown',2021);
select instr ('corportae floor ' , 'or' , 1, 1)from dual ; k

select 
rtrim(rpad(emp_name,10,'@'),'@')from EMPLOYEE1;
select substr('pakistan pak is tann ',-4 , 3)from dual ;
select 
rtrim(emp_name,10,'@')from EMPLOYEE1;
SELECT  MAX (emp_salary)
AS emp_salary
FROM EMPLOYEE1;

SELECT  MAX (emp_salary) as emp_salary
FROM EMPLOYEE1
Group by emp_depart_id
HAVING MAX(emp_salary)>18000;


SELECT  Avg (emp_salary)
AS emp_salary
FROM EMPLOYEE1;

SELECT emp_depart_id, 
COUNT (*) as employee_count
FROM EMPLOYEE1
WHERE emp_id >104 OR emp_hire_date <2018
Group by emp_depart_id;

SELECT * FROM EMPLOYEE1;
