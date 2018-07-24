CREATE TABLE EMP(
EMPNO NUMBER(6),
ENAME VARCHAR2(20) NOT NULL,
JOB VARCHAR2(10) NOT NULL,
MGR NUMBER(4),
DEPTNO NUMBER(3),
SAL NUMBER(7,2)
);
desc emp;
alter table emp add(commission number(10));
create table dept (deptno number(2) not null primary key,dname varchar(10),loc varchar(10));
alter table emp modify empno number(6) primary key not null;
alter table emp add foreign key (deptno) references dept(deptno);
desc emp;
ALTER TABLE DEPT MODIFY (DNAME VARCHAR(20));
ALTER TABLE DEPT MODIFY LOC VARCHAR(20);
alter table emp add (dob date);
insert ALL 
into dept values (10,'MANAGEMENT','MAIN BLOCK')
into dept values (20,'DEVELOPMENT','MANUFACTURING UNIT')
into dept values (30,'MAINTAINANCE','MAIN BLOCK')
into dept values (40,'TRANSPORT','ADMIN BLOCK')
into dept values (50,'SALES','HEAD OFFICE')
SELECT * FROM DUAL;
SELECT * FROM DEPT;
INSERT ALL
INTO EMP VALUES(7399,'ASANT','SALESMAN',7566,20,1600,300,'20-FEB-81')
INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,30,1600,300,'20-FEB-81')
INTO EMP VALUES(7521,'WARD','SALESMAN',7698,30,1250,500,'22-FEB-82')
INTO EMP VALUES(7566,'JONES','MANAGER',7839,20,5975,500,'02-APR-81')
INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,30,9850,1400,'01-MAY-79')
INTO EMP VALUES(7611,'SCOTT','HOD',7839,10,3000,0,'12-JUNE-76')
INTO EMP VALUES(7839,'CLERK','CEO',NULL,10,9900,0,'16-MARCH-72')
INTO EMP VALUES(7368,'FORD','SUPERVIS',7366,20,8000,0,'17-DEC-80')
INTO EMP VALUES(7599,'ALLEY','SALESMAN',7698,30,1600,300,'20-FEB-81')
INTO EMP VALUES(7421,'DRANK','CLERK',7698,30,1250,300,'22-JAN-82')
SELECT * FROM DUAL;
SELECT * FROM EMP;
SELECT * FROM (SELECT * FROM EMP NATURAL JOIN DEPT) ORDER BY LOC;
DELETE FROM EMP WHERE JOB IN ('SUPERVIS');
SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO IN (30);
SELECT ENAME,DEPTNO,DNAME,LOC FROM (SELECT * FROM EMP NATURAL JOIN DEPT) WHERE DEPTNO IN (30);
SELECT * FROM (SELECT ENAME,SAL ROW_NUMBER() OVER (ORDER BY SAL ASC) AS ROW_NUM FROM EMP ) TT WHERE ROW_NUM = 2;
select sum(Sal),job from emp group by job;
select ename from emp where length(ename)=5;
select ename from emp where ename like 'C%' or ename like 'B%';
SELECT MAX(SAL) ,MIN(SAL) , MAX(SAL)-MIN(SAL) as sal_diff from emp group by job;
select sal,ename from emp where sal>=1500 and sal<=3500;
select deptno,sum(Sal) as total_sal from emp having sum(sal)>12000 group by deptno;



DECLARE 
   message  varchar2(20):= 'Hello, World!'; 
BEGIN 
   dbms_output.put_line(message||'fuck'); 
END;

SET SERVEROUTPUT ON
declare
    f1 number(5,2);
    f2 number(5,2);
    f3 number(5,2);
begin
    f1:=:f1;
    f2:=:f2;
    f3:=f1+f2;
    dbms_output.put_line(f1||'+'||f2||'='||f3);
    end;

SET SERVEROUTPUT ON   
declare
    empname emp.ename%type;
    empdept emp.deptno%type;
    empsal emp.sal%type;
    empjob emp.job%type;
begin
    select ename,deptno,sal,job into empname,empdept,empsal,empjob from emp where ename like 'BLAKE';
    
    IF(EMPNAME='ALLEN')THEN
       select ename,deptno,sal,job into empname,empdept,empsal,empjob from emp where ename like 'SCOTT';
    ELSE
         select ename,deptno,sal,job into empname,empdept,empsal,empjob from emp where ename like 'ALLEN';
       END IF;
       
       dbms_output.put_line(empname||empdept||empsal||empjob);
    END;
/    
set serveroutput on
DECLARE
    n number:=10;
    i number:=0;
begin
    while i < n loop
        i:=i+2;
         dbms_output.put_line('fuckity fuck');
    end loop;
end;

set serveroutput on
DECLARE
    cursor c is select * from emp where emp.deptno=20;
     type namearray is varray(100) of emp.ename%type;
     type jobarray is varray(100) of emp.job%type;
    enamear namearray :=namearray();
    jobar jobarray := jobarray();
    counter integer :=1;
begin
    select ename,job bulk collect into enamear,jobar from emp where deptno=20;
    for i in c loop
        dbms_output.put_line(counter||'  '||enamear(counter)||'  '||jobar(counter));
        counter:=counter+1;
    end loop;
end;

--set serveroutput on
create or replace trigger new_trigger
before delete or update or insert 
of sal on emp
for each row 
when (new.sal>old.sal)
declare 
salch emp.sal%type;
begin
    salch:=:NEW.sal - :OLD.sal;
     dbms_output.put_line('Old salary: ' || :OLD.sal); 
   dbms_output.put_line('New salary: ' || :NEW.sal); 
   dbms_output.put_line('Salary difference: ' || salch); 
END; 

update emp set sal=sal+100 where job='CEO';
INSERT INTO EMP VALUES (7777,'SAMWISE','DEV',7777,30,1250,300,'07-JUL-95');
DELETE FROM EMP WHERE EMPNO=7777;

set serveroutput on;
DECLARE 
   CURSOR cur is 
      SELECT *  
      FROM (select * from emp natural join dept); 
   emp_rec cur%rowtype; 
BEGIN 
   OPEN cur; 
   LOOP 
      FETCH cur into emp_rec; 
      EXIT WHEN cur%notfound; 
      DBMS_OUTPUT.put_line(emp_rec.empno || '  ' || emp_rec.ename || '  '|| emp_rec.loc||'  '||emp_rec.deptno); 
   END LOOP; 
END; 
