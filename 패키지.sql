--菩虐瘤 积己
--∝ COMM_PKG 积己
CREATE OR REPLACE PACKAGE comm_pkg 
IS
  v_std_comm	NUMBER := 0.1 ; 
  PROCEDURE	reset_comm(p_new_comm 	NUMBER);
END comm_pkg;
/

SET SERVEROUTPUT ON 
EXECUTE DBMS_OUTPUT.PUT_LINE( COMM_PKG.V_STD_COMM ) ; 

--
DESC COMM_PKG

--
CREATE OR REPLACE PACKAGE BODY comm_pkg IS 
  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS 
    v_max_comm	employees.commission_pct%TYPE ;
  BEGIN
    SELECT MAX(commission_pct) INTO v_max_comm
    FROM employees ;
    RETURN (p_comm BETWEEN 0.0 AND v_max_comm) ;
  END validate ;

  PROCEDURE reset_comm (p_new_comm NUMBER) IS 
  BEGIN
    IF validate(p_new_comm) THEN
      v_std_comm := p_new_comm ;
    ELSE
      RAISE_APPLICATION_ERROR(-20210, 'Bad Commission');
    END IF;
  END reset_comm;

END comm_pkg;
/

--
CREATE OR REPLACE PACKAGE comm_pkg IS
  v_std_comm	NUMBER := 0.1 ; 
  PROCEDURE	reset_comm(p_new_comm 	NUMBER);
  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN ; 
END comm_pkg;
/

--
CREATE OR REPLACE PACKAGE BODY comm_pkg IS 
  PROCEDURE reset_comm (p_new_comm NUMBER) IS 
  BEGIN
    IF validate(p_new_comm) THEN
      v_std_comm := p_new_comm ;
    ELSE
      RAISE_APPLICATION_ERROR(-20210, 'Bad Commission');
    END IF;
  END reset_comm;

  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS 
    v_max_comm	employees.commission_pct%TYPE ;
  BEGIN
    SELECT MAX(commission_pct) INTO v_max_comm
    FROM employees ;
    RETURN (p_comm BETWEEN 0.0 AND v_max_comm) ;
  END validate ;

END comm_pkg;
/
desc comm_pkg;

--
CREATE OR REPLACE PACKAGE comm_pkg IS
  v_std_comm	NUMBER := 0.1 ; 
  PROCEDURE	reset_comm(p_new_comm 	NUMBER);
END comm_pkg;
/

CREATE OR REPLACE PACKAGE BODY comm_pkg IS 

  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN ; 

  PROCEDURE reset_comm (p_new_comm NUMBER) IS 
  BEGIN
    IF validate(p_new_comm) THEN
      v_std_comm := p_new_comm ;
    ELSE
      RAISE_APPLICATION_ERROR(-20210, 'Bad Commission');
    END IF;
  END reset_comm;

  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS 
    v_max_comm	employees.commission_pct%TYPE ;
  BEGIN
    SELECT MAX(commission_pct) INTO v_max_comm
    FROM employees ;
    RETURN (p_comm BETWEEN 0.0 AND v_max_comm) ;
  END validate ;

END comm_pkg;
/
desc comm_pkg;

--
create or replace package grade_pkg is
procedure update_tid(p_lnid varchar2);
function get_grade(p_lnid varchar2) return varchar2;
end grade_pkg;

create or replace package body grade_pkg is
    function get_grade(p_lnid varchar2) 
    return varchar2 is
        v_grade varchar2(20);
    begin
        select grade into v_grade
        from tcode
        where code = (select max(code)
                        from (select distinct lnid, code
                            from tcredit
                            where lnid = p_lnid
                            and end_dt >= to_date('2023/01/04','YYYY/MM/DD')
                            order by code)
                        where rownum <=2);
    end get_grade;
    
    PROCEDURE update_tid(p_lnid varchar2) is 
    BEGIN 
        UPDATE tid 
        SET grade = get_grade(p_lnid) 
        WHERE lnid  = p_lnid ; 
        
        EXCEPTION 
            WHEN OTHERS THEN 
                ROLLBACK ; 
                DBMS_OUTPUT.PUT_LINE(SQLERRM) ; 
    END ; 
end;
/

SET SERVEROUTPUT ON 
EXECUTE grade_pkg.update_tid('10022');
select * from tcredit;
