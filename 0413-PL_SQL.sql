-- HR 계정의 employees 테이블 복사하기
CREATE TABLE employees
AS (SELECT * FROM hr.employees);

-- 제약조건을 저장하고 있는 데이터 사전
DESC user_constraints;

-- 제약조건명 확인하기
SELECT *
FROM user_constraints
WHERE table_name='EMPLOYEES';

-- 제약조건명 변경하기
ALTER TABLE employees ADD CONSTRAINT employees_pk PRIMARY KEY(employee_id);

-- PL/SQL
-- 접속마다 최초 1회만 하면 된다
-- 결과를 확면에 띄우기
-- 디폴트 : set serveroutput off
SET SERVEROUTPUT ON;

-- 기본 구성
/*
    DECLEARE
        변수 선언;
    BEGIN
        작업;
    END;
*/

-- 화면 출력
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello PL/SQL');
END;


-- 변수 선언(스칼라 변수)
DECLARE
    my_name VARCHAR2(20);
    my_age NUMBER(3);
BEGIN
     -- 변수에 값을 대입(대입연산자 :=)
    my_name := '에밀리';
    my_age := 30;
    DBMS_OUTPUT.PUT_LINE('내 이름은 ' || my_name || '입니다.');
    DBMS_OUTPUT.PUT_LINE('내 나이는 ' || my_age || '입니다');
END;


-- 변수 선언(참조 변수)
-- 기존의 칼럼의 타입을 그대로 사용한다
-- 계정.테이블.칼럼%TYPE
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE; -- v_first_name VARCHAR2(20);
    v_last_name EMPLOYEES.LAST_NAME%TYPE; -- v_last_name VARCHAR2(25);
BEGIN
    -- 테이블의 데이터를 변수에 저장하기
    -- select 칼럼 into 변수 from 테이블; 칼럼->변수
    /*   SELECT fist_name INTO v_first_name
           FROM employees
          WHERE employee_id=100;
          
        SELECT last_name INTO v_last_name
          FROM employees
        WHERE employee_id=100;
    */
    SELECT first_name, last_name INTO v_first_name, v_last_name
     FROM employees
    WHERE employee_id=100;
    DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name);
END;
    

-- < IF문 >
DECLARE
    score NUMBER(3);
    grade CHAR(1);
BEGIN
    score := 50;
    IF score >= 90 THEN 
        grade := 'A';
    ELSIF score >= 80 THEN
        grade := 'B';
    ELSIF score >= 70 THEN
        grade := 'C';
    ELSIF score >= 60 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('점수는 ' || score || '점이고, 학점은 ' || grade || '학점입니다.');
END;


-- < CASE문 >
DECLARE
    score NUMBER(3);
    grade CHAR(1);
BEGIN
    score := 90;
    CASE
        WHEN score >= 90 THEN
            grade := 'A';
        WHEN score >= 80 THEN
            grade := 'B';
        WHEN score >= 70 THEN
            grade := 'C';
        WHEN score >= 60 THEN
            grade := 'D';
        ELSE
            grade := 'F';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('점수는 ' || score || '점이고, 학점은 ' || grade || '학점입니다.');
END;

-- 문제) 사원번호가 200인 사원의 연봉(salary)을 가져와서,
-- 5000 이상이면 '고액연봉자', 아니면 공백을 출력하시오.
DECLARE
     v_salary EMPLOYEES.SALARY%TYPE;
     v_result varchar2(20);
BEGIN
     SELECT  salary INTO v_salary
         FROM employees
        WHERE employee_id=200;
        IF v_salary >= 5000 THEN
            v_result := '고액연봉자';
        ELSE
            v_result := '';
        END IF;
        DBMS_OUTPUT.PUT_LINE('결과 : ' || v_result);
END;


-- < WHILE문 >
-- 1~100까지 모두 더하기
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 1;
    WHILE N <= 100 LOOP
        total := total+n;
        n := n+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;


-- < FOR문 >
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    FOR n IN 1 .. 100 LOOP
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;
    

-- < EXIT문(java의 break문) >
-- 1부터 누적합계를 구하다가 최초 누적합계가 3000 이상인 경우 반복문을 종료하고
-- 해당 누적합계를 출력하시오
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 1;
    WHILE TRUE LOOP -- 무한루프
        total := total+n;
        IF total >= 3000 THEN
            EXIT;
        END IF;
        n := n+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;

DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 1;
    WHILE TRUE LOOP
        total := total+n;
        EXIT WHEN total >= 3000;
        n := n+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;


-- < CONTINUE문 >
-- 1~100 사이 모든 짝수의 합계를 구하시오
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 0;
    WHILE n < 100 LOOP
        n := n+1;
        IF MOD(n, 2) = 1 THEN -- 2로 나눴을 때 나머지가 1이라면 -> 홀수라면
            CONTINUE;
        END IF;
        total := total+n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('짝수 합계 : ' || total);
END;


-- < 테이블 타입 >
-- 테이블의 데이터를 가져와서 배열처럼 사용하는 타입
DECLARE
    i NUMBER; -- index
    -- first_name_type : EMPLOYEES테이블의 FIRST_NAME칼럼값을 배열처럼 사용할 수 있는 타입
    TYPE first_name_type IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
    -- first_names : EMPLOYEES테이블의 FIRST_NAME칼럼값을 실제로 저장하는 변수(배열)
    first_names first_name_type;
BEGIN
    i := 0;
    FOR v_row IN (SELECT first_name, last_name FROM employees) LOOP
        first_names(i) := v_row.first_name; -- first_name은 배열에 저장, last_name은 출력만
        DBMS_OUTPUT.PUT_LINE(first_names(i) || ' ' || v_row.last_name);
        i := i+1;
    END LOOP;
END;

-- 문제) 부서번호(department_id)가 50인 부서의 first_name, last_name을 가져와서
-- 새로운 테이블 employees50에 삽입하시오
CREATE TABLE employees50
        AS (SELECT first_name, last_name FROM employees WHERE 1=0);
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    FOR v_row IN (SELECT first_name, last_name FROM employees WHERE department_id=50) LOOP
        v_first_name := v_row.first_name;
        v_last_name := v_row.last_name;
        INSERT INTO employees50(first_name, last_name) VALUES (v_first_name, v_last_name);
    END LOOP;
    COMMIT;
END;

SELECT first_name, last_name FROM employees50;


-- < 레코드 타입 >
-- 여러 칼럼(열)이 모여서 하나의 레코드(행, row)가 된다
-- 여러 데이터를 하나로 모으는 개념 : 객체(변수 + 함수)의 하위 개념 -> 구조체(변수)
DECLARE
    TYPE person_type IS RECORD
    (
        my_name VARCHAR2(20),
        my_age NUMBER(3)
    );
    man person_type; -- person_type의 man
    woman person_type; -- person_type의 woman
BEGIN
    man.my_name := '제임스';
    man.my_age := 20;
    woman.my_name := '엘리스';
    woman.my_age := 30;
    DBMS_OUTPUT.PUT_LINE(man.my_name || ' ' || man.my_age);
    DBMS_OUTPUT.PUT_LINE(woman.my_name || ' ' || woman.my_age);
END;


-- < 테이블형 레코드 타입 >
-- 부서번호(department_id)가 50인 부서의 first_name, last_name을 가져와서
-- 새로운 테이블 employees2에 삽입하시오
DROP TABLE employees2;

CREATE TABLE employees2
    AS (SELECT * FROM employees WHERE 1=0);

DECLARE
    row_data SPRING.EMPLOYEES%ROWTYPE; -- EMPLOYEES테이블의 ROW전체를 저장할 수 있는 변수
    emp_id NUMBER(3);
BEGIN
    FOR emp_id IN 100 .. 206 LOOP
        SELECT * INTO row_data
          FROM SPRING.EMPLOYEES
        WHERE employee_id=emp_id;
        INSERT INTO employees2 VALUES row_data;
    END LOOP;
END;

SELECT first_name, last_name FROM employees2;
    

-- < 예외처리 >
DECLARE
    v_last_name VARCHAR2(25); -- 칼럼의 타입보다 크거나 같으면 문제 없다(작은 건 안 됨)
BEGIN
    SELECT last_name INTO v_last_name -- last_name을 조회해서 v_last_name에 저장해라
     FROM employees
    WHERE department_id=50; -- 없는 사원
    DBMS_OUTPUT.PUT_LINE('결과 : ' || v_last_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 없다');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 많다');
END;
    

-- < 모든 예외처리 >
DECLARE
    v_last_name VARCHAR2(25); -- 칼럼의 타입보다 크거나 같으면 문제 없다(작은 건 안 됨)
BEGIN
    SELECT last_name INTO v_last_name
     FROM employees
     -- WHERE department_id=50; -- 많은 사원
    WHERE employee_id=1; -- 없는 사원
    DBMS_OUTPUT.PUT_LINE('결과 : ' || v_last_name);
EXCEPTION
        when others then
        DBMS_OUTPUT.PUT_LINE('예외 코드 :  ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('예외 메시지 :  ' || SQLERRM);
END;


