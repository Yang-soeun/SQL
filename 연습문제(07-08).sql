SELECT employee_id, last_name, rowid,
       DBMS_ROWID.ROWID_RELATIVE_FNO(rowid) AS FILE_NO, 
       DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) AS BLOCK_NO,
       DBMS_ROWID.ROWID_ROW_NUMBER(rowid)   AS ROW_NO
  FROM employees ;

-- ����
-- 1.
-- ��� 1) -- �ε����� ������� ����
select lnid, id_typ, bthday, gender, score
from tid
where id_typ = '1'
and to_char(bthday, 'MMDD') = to_char(sysdate, 'MMDD');

-- ��� 2) -- �ε����� ����� �� �ִ� ����
select lnid, id_typ, bthday, gender, score
from tid
where id_typ = '1'
and bthday in (select dt 
    from tdt 
    where mmdd = to_char(sysdate, 'MMDD'));

-- 2.
-- ���1) �Լ� ����
create or replace function ck_date (p_dt varchar2)
return number is
    v_ck date;
begin
    v_ck := to_date(p_dt, 'YYYYMMDD');
    return 1;--�����ϸ�
exception --���� �߻�
    when others then
        return 0;
end;
/ -- �̰� ���ϸ� ���� ��
select lnid, id_typ, bthday, ck_date(bthday),
gender, score, grade
from tidck
where ck_date(bthday) = 0; -- ���ܰ� �߻��� = �߸��� ��¥�� ���

/
-- ���2) validate_conversion �Լ� ���(12c NF)
select lnid, id_typ, bthday, gender, score, grade
from tidck
where validate_conversion(bthday as DATE, 'YYYYMMDD') = 0;

-- ���3)
select *
from tidck ti
where not exists (select 1 from tdt where yymmdd = ti.bthday);

-- 3.
SELECT lnact, lnact_seq, lnid, ln_dtexp_dt, ln_amt, exp_dt - 7, MAX(b.dt)  AS "���� ������"
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
