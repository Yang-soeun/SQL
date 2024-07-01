-- employess 테이블에서 salary의 평균, 최고급여,
-- 최소급여, 급여합계를 검색하시오
select avg(salary) as 평균, 
max(salary)as 최고급여, 
min(salary)as 최소급여, 
sum(salary)as 급여합계
from employees;

-- employees 테이블에서 입사일이 가장 빠른 hire_date와
-- 가장 늦게 입사한 hire_date를 검색하시오
select min(hire_date), max(hire_date)
from employees;

-- 50번 부서의 사원수를 검색하시오
select count(*)
from employees
where department_id = 50;

select count(commission_pct)
from employees
where department_id = 50;

select distinct department_id
from employees;

select count(*) from employees;

select avg(commission_pct) from employees;

select avg(nvl(commission_pct, 0)) from employees; --null 포함
