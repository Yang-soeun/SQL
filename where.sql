-- where
-- 문자열 조건은 작은 따옴표로 해야함
-- where 절에 오는 값은 데이터 형식과 정확히 일치해야 함
-- where 조건절 동작: 참과 거짓을 평가할 수 있는 조건식 정의

select employee_id, last_name, job_id, department_id
from employees
where department_id = 90; -- 조건

select last_name, job_id, department_id
from employees
where last_name = 'Whalen'; -- 비교하는 문자열은 대소문자 정확하게 일치해야 함

select last_name, job_id, department_id
from employees
where last_name = 'WHALEN'; -- 결과 안나옴

select last_name, hire_date
from employees
where hire_date = '03/10/17'; -- 결과 안나옴

select last_name, hire_date
from employees
where hire_date = '2003/10/17';

-- 비교연산자
select last_name, salary
from employees
where salary <> 3000; -- NOT 의미, != NOT 의미

select last_name, salary
from employees
where salary between 2500 and 3500; -- 이상, 이하

-- 문자에도 between 사용가능
select last_name, salary
from employees
where last_name between 'King' and 'Whalen'
order by last_name;

--in
select employee_id, last_name, salary, manager_id
from employees
where manager_id in (100, 101, 201); -- in에 해당하는 값만 나옴

-- like
select first_name
from employees where first_name like 'S%';

select last_name
from employees
where last_name like '_o%'; -- 앞에서 두번째 문자가 o

select last_name
from employees
where last_name like '%o_'; -- 뒤에서 두번째 문자가 o

update emp set ename = 'SC%TT' where ename = 'SCOTT';
select ename from emp;

-- escape: C%가 포함된 문자열 찾기
select ename from emp
where ename like '%C\%%' escape '\';

-- 이렇게 하면 C가 포함된 ename이 나옴
select ename from emp
where ename like '%C%%';

rollback;

-- null
select last_name, manager_id, commission_pct
from employees
where manager_id is null;

select last_name, job_id, commission_pct
from employees
where commission_pct is not null;

-- 대량으로 데이터를 로드하는 경우 다 가지고 올지, 하나도 안가지고 올지 정할 때 사용함
select * from dept where 3 = 3;

select * from dept where 3 = 0;

-- AND: 두 조건이 모두 참인 경우 true
-- OR: 두 조건 중 하나가 함인 경우 true
-- NOT: true는 false로, false는 true

select employee_id, last_name, job_id, salary
from employees
where salary >= 10000 and job_id like '%MAN%';

select employee_id, last_name, job_id, salary
from employees
where salary >= 10000 or job_id like '%MAN%';

-- 연산자 우선순위: AND > OR 
select last_name, department_id, salary
from employees
where department_id = 60
or department_id = 80
and salary > 1000;

-- 연습문제2
-- 1.
select last_name, salary
from employees
where salary > 12000;

-- 2.
select last_name, department_id
from employees
where employee_id = 176;

-- 3.
select last_name, salary
from employees
where not salary between 5000 and 12000;

-- 4.
select last_name, job_id, hire_date
from employees
where last_name in('Matos', 'Taylor')
order by hire_date;

-- 5.
select last_name, department_id
from employees
where department_id in(20, 50)
order by last_name;

-- 6.
select last_name as "Employee", salary as "Monthly Salary"
from employees
where (salary between 5000 and 12000) and department_id in(20, 50);

-- 7.
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

-- 8.
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';
