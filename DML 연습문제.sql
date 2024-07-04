select * from emp;
select * from dept;

-- 1.
update emp set sal = sal*1.1, comm = 6000
where job = 'SALESMAN'; 
select * from emp;

-- 2. 
update dept set loc = 'BUSAN'
where loc = 'BOSTON';
select * from dept;
rollback;

-- 3.
create table empty_emp as select * from emp where 1 = 2;
select * from empty_emp;

 -- 4.
 insert into empty_emp select * from emp;
 select * from empty_emp;
 
 -- 5.
 insert into emp(empno, ename, sal, hiredate) 
 values(1949, 'jack', 4000, sysdate);
 
 -- 6.
 select * from dept;
 insert into dept values(50, 'Marketing', 'seoul');
 
 -- 7.
 select * from emp;
 update emp set sal = 9000
 where ename = 'SCOTT';
 
 -- 8.
 update emp set comm = 600
 where job = 'SALESMAN';
 

 -- 9.
update emp set deptno = 30
where sal >= 3000;

-- 10.
delete from emp
where ename = 'SCOTT';

-- 11.
delete from emp
where job = 'SALESMAN';

-- 12.
delete from emp
where comm is null;

-- 13.
update emp set sal = 5000, job = 'SALESMAN', deptno = 30
where ename = 'SCOTT';

-- 14.
update emp set job = 'SALESMAN'
where sal > (select sal from emp where ename = 'SCOTT');

--15.
update emp set deptno = 40
where hiredate > (select hiredate from emp where ename = 'ALLEN');

-- 16.
update emp set sal = (select sal from emp where ename = 'SMITH')
where ename = 'KING';

-- 17.
update emp set comm = (select comm from emp where ename = 'ADAMS')
where job = 'SALESMAN';




