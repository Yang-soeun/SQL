SELECT employee_id, last_name, rowid,
       DBMS_ROWID.ROWID_RELATIVE_FNO(rowid) AS FILE_NO, 
       DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) AS BLOCK_NO,
       DBMS_ROWID.ROWID_ROW_NUMBER(rowid)   AS ROW_NO
  FROM employees ;

-- 퀴즈
-- 1.
-- 방법 1) -- 인덱스를 사용하지 못함
select lnid, id_typ, bthday, gender, score
from tid
where id_typ = '1'
and to_char(bthday, 'MMDD') = to_char(sysdate, 'MMDD');

-- 방법 2) -- 인덱스를 사용할 수 있는 형태
select lnid, id_typ, bthday, gender, score
from tid
where id_typ = '1'
and bthday in (select dt 
    from tdt 
    where mmdd = to_char(sysdate, 'MMDD'));

-- 2.
-- 방법1) 함수 생성
create or replace function ck_date (p_dt varchar2)
return number is
    v_ck date;
begin
    v_ck := to_date(p_dt, 'YYYYMMDD');
    return 1;--성공하면
exception --예외 발생
    when others then
        return 0;
end;
/ -- 이거 안하면 오류 남
select lnid, id_typ, bthday, ck_date(bthday),
gender, score, grade
from tidck
where ck_date(bthday) = 0; -- 예외가 발생한 = 잘못된 날짜인 경우

/
-- 방법2) validate_conversion 함수 사용(12c NF)
select lnid, id_typ, bthday, gender, score, grade
from tidck
where validate_conversion(bthday as DATE, 'YYYYMMDD') = 0;

-- 방법3)
select *
from tidck ti
where not exists (select 1 from tdt where yymmdd = ti.bthday);

-- 3.
SELECT lnact, lnact_seq, lnid, ln_dtexp_dt, ln_amt, exp_dt - 7, MAX(b.dt)  AS "사전 고지일"
  FROM (SELECT lnact, lnact_seq, lnid, ln_dt, exp_dt, ln_amt
          FROM tacct
         WHERE lmt_typ IS NULL 
           AND repay   IS NULL
           AND dlq_dt  IS NULL 
           AND exp_dt BETWEEN TO_DATE('2023/04/01')
                          AND TO_DATE('2023/05/01') - 1/86400 ) a 
  JOIN (SELECT dt
          FROM tdt 
         WHERE holiday IS NULL) b 
   ON  b.dt BETWEEN a.exp_dt - 14 AND a.exp_dt - 7 
GROUP BY lnact, lnact_seq, lnid, ln_dt, exp_dt, ln_amt
ORDER BY a.exp_dt ;
