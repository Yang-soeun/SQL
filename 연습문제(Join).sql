-- ���� ������ ������ �ִ� ��ü ��Ͽ����� �÷��� ���� �˷���
select * from user_tab_columns
where column_name = 'LNACT';


-- 1��
select * from trepay_plan;
SELECT * 
  FROM trepay_plan 
 WHERE pay_dt BETWEEN TO_DATE('2023/01/20','YYYY/MM/DD')
                  AND TO_DATE('2023/01/31','YYYY/MM/DD')
   AND (lnact, lnact_seq) IN (SELECT lnact, lnact_seq
                                FROM tacct
                               WHERE dlq_dt IS NULL 
                                 AND repay  IS NULL) 
ORDER BY pay_dt, lnact, lnact_seq ;
