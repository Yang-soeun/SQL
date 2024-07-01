-- group by
select department_id, sum(salary)
from employees
group by department_id;

select department_id, job_id, sum(salary)
from employees
where department_id > 40
group by department_id, job_id
order by department_id;


-- 최고 급여가 10000가 넘는 부서에 대해
-- 부서번호와 최고 급여를 표시
select department_id, max(salary) as 최고급여
from employees
group by department_id
having max(salary) > 10000;

-- $99,999는 자리수 보다 크게 해야 정상적으로 나옴
select department_id, to_char(max(salary), '$99,999') as 최고급여
from employees
group by department_id
having max(salary) > 10000;

-- 부서번호가 있고
-- 부서별 근무 인원수가 3명 이상인 행을 검색하여
-- 부서번호, 부서별 총급여와 평균급여를 검색, 부서번호로 정렬
select * from emp;
select deptno, sum(sal), round(avg(sal), 2), count(*)
from emp
where deptno is not null
group by deptno
having count(*) >= 3
order by deptno;

select round(max(avg(salary)), 2)
from employees
group by department_id;

-- 중첩된 그룹함수는 single 칼럼 사용 못함
--select department_id, max(avg(salary))
--from employees
--group by department_id;

-- 이건 가능
select max(avg(salary))
from employees
group by department_id;


