-- null
-- null first
select empno, ename, sal, comm
from emp
order by comm NULLS FIRST; -- null�� �� ������

-- null last
select empno, ename, sal, comm
from emp
order by comm desc NULLS LAST; -- null�� �� �ڷ�