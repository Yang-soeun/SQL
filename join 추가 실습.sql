select * from emp;
select * from dept;

-- 1.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno;

-- 2.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS';

-- 3.
select e.ename, e.sal, e.job, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.job = 'SALESMAN';


-- 4.
select e.ename, e.sal, e.job, d.loc, d.deptno
from emp e, dept d
where e.deptno = d.deptno
and e.job = 'SALESMAN';

-- 5.
select e.ename, e.sal, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal >= 3000;

-- 6.
select e.ename, e.job, e.sal, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.job ='SALESMAN';

-- 7.
select d.loc, sum(e.sal)
from emp e, dept d
where e.deptno = d.deptno
group by d.loc;

-- 8.
select d.loc, sum(e.sal)
from emp e, dept d
where e.deptno = d.deptno
and d.loc != 'DALLAS'
group by d.loc;

-- 9.
select e.ename, d.loc
from emp e, dept d
where e.deptno(+)= d.deptno;

-- 10.
select e.ename, d.loc
from emp e, dept d
where e.deptno (+)= d.deptno
union
select e.ename, d.loc
from emp e, dept d
where e.deptno = d.deptno(+);

-- 11.
select d.loc, sum(e.sal)
from emp e, dept d
where e.deptno = d.deptno
group by d.loc;

select d.loc, count(nvl(e.ename, 0))
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.loc;

-- 13
select 사원.ename, 관리자.ename
from emp 사원, emp 관리자
where 사원.mgr = 관리자.empno(+);

-- 14
select 사원.ename, 관리자.ename
from emp 사원, emp 관리자
where 사원.mgr = 관리자.empno
and 사원.sal > 관리자.sal;

-- 15.
select * from emp;
select 사원.ename, 관리자.ename
from emp 사원, emp 관리자
where 사원.hiredate < 관리자.hiredate;

-- 16.
select * from job_grades;
select e.ename, d.loc, e.sal, s.grade
from dept d, emp e, salgrade s
where e.deptno = d.deptno and
e.sal between s.losal and s.hisal;

select e.ename, d.loc
from emp e cross join dept d;
