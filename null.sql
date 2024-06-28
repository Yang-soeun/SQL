-- null
-- null first
select empno, ename, sal, comm
from emp
order by comm NULLS FIRST; -- null을 젤 앞으로

-- null last
select empno, ename, sal, comm
from emp
order by comm desc NULLS LAST; -- null을 젤 뒤로