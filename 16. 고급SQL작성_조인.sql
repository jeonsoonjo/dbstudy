-- 테이블 삭제
DROP TABLE department;
DROP TABLE employee;

-- 테이블 생성
CREATE TABLE department
(
    dept_no NUMBER, -- PK, 부서번호
    dept_name VARCHAR2(10), -- 부서명
    location VARCHAR2(20) -- 위치
);

CREATE TABLE employee
(
    emp_no NUMBER, -- PK, 사원번호
    name VARCHAR2(15), -- 이름
    depart NUMBER, -- dept_no FK, 부서번호
    position VARCHAR2(10), -- 직급
    gender CHAR(2), -- 성별
    hire_date DATE, -- 입사일
    salary NUMBER -- 급여
);

-- 칼럼타입 수정
ALTER TABLE department MODIFY dept_no NUMBER;
ALTER TABLE department MODIFY dept_name VARCHAR2(10);
ALTER TABLE department MODIFY LOCATION VARCHAR2(20);
ALTER TABLE employee MODIFY depart NUMBER;

-- PK, FK 추가
ALTER TABLE department ADD CONSTRAINT depart_pk PRIMARY KEY(dept_no);
ALTER TABLE employee ADD CONSTRAINT emp_pk PRIMARY KEY(emp_no);
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY(depart) REFERENCES department(dept_no);

-- 데이터 삽입
INSERT INTO department 
    (dept_no, dept_name, location) 
VALUES 
    (1, '영업부', '대구'); -- 이렇게 정리하면 보기가 편하다
INSERT INTO department(dept_no, dept_name, location) VALUES (2, '인사부', '서울');
INSERT INTO department(dept_no, dept_name, location) VALUES (3, '총무부', '대구');
INSERT INTO department(dept_no, dept_name, location) VALUES (4, '기획부', '서울');

INSERT INTO employee 
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
    (1001, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO employee(emp_no, name, depart, position, gender, hire_date, salary) VALUES (1002, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO employee(emp_no, name, depart, position, gender, hire_date, salary) VALUES (1003, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO employee(emp_no, name, depart, position, gender, hire_date, salary) VALUES (1004, '한성일', 2, '과장', 'M', '93-04-01', 5000000);

COMMIT;



-- <<카테젼 곱>>
-- 두 테이블의 조인 조건(관계)이 잘못되거나 없을 때 나타난다
-- 1) 별명사용
SELECT
           e.emp_no
         , e.name
         , d.dept_name
         , e.position
         , e.hire_date
         , e.salary
 FROM employee e, department d;
 
-- 2) CROSS JOIN
SELECT
           e.emp_no
         , e.name
         , d.dept_name
         , e.position
         , e.hire_date
         , e.salary
 FROM employee e
CROSS JOIN department d;



-- <<내부조인>>
-- 양쪽 테이블에 모두 존재하는 데이터만 조인하는 것
-- 1) INNER JOIN ~ ON 비교
SELECT
           e.emp_no
         , e.name
         , d.dept_name
         , e.position
         , e.hire_date
         , e.salary
 FROM employee e INNER JOIN department d
     ON e.depart = d.dept_no;

-- 2) WHERE 비교
SELECT
           e.emp_no
         , e.name
         , d.dept_name
         , e.position
         , e.hire_date
         , e.salary
 FROM employee e, department d
WHERE e.depart = d.dept_no;


-- 외부조인 연습을 위한 데이터 추가
-- 참조무결성에 의해 아래 데이터는 삽입되지 않는다
-- 잠시 외래키 제약조건(emp_dept_fk)을 비활성화(disable)한다, 데이터를 삭제하는 건 좋지 않다
ALTER TABLE employee DISABLE CONSTRAINT emp_dept_fk;

INSERT INTO employee
    (emp_no, NAME, depart, POSITION, gender, hire_date, salary)
VALUES
    (1005, '김미나', 5, '사원', 'F', '18-05-01', 1000000);



-- <<외부조인>>
-- 모든 사원의 emp_no, name, dept_name, position 출력하기
-- 1-1) LEFT OUTER JOIN ~ ON 비교 (왼쪽 테이블은 모두 출력이 되고, 오른 쪽 테이블은 일치하는 정보만 출력된다)
SELECT
          e.emp_no
        , e.name
        , d.dept_name
        , e.position
FROM employee e LEFT OUTER JOIN department d
    ON e.depart=d.dept_no;
    
-- 1-2) WHERE절 사용 : 일치하는 정보만 출력되는 칼럼명에 (+)
SELECT
          e.emp_no
        , e.name
        , d.dept_name
        , e.position
FROM employee e, department d
WHERE e.depart = d.dept_no(+); 
  
-- 2-1) RIGHT OUTER JOIN ~ ON 비교(왼쪽 테이블은 일치하는 정보만 출력되고, 오른쪽 테이블은 모두 출력된다)
SELECT
          e.emp_no
        , e.name
        , d.dept_name
        , e.position
FROM employee e RIGHT OUTER JOIN department d
    ON e.depart=d.dept_no;
  
-- 2-2) WHERE절 사용 : 일치하는 정보만 출력되는 칼럼명에 (+)
select
          e.emp_no
        , e.name
        , d.dept_name
        , e.position
FROM employee e, department d
where e.depart(+) = d.dept_no;


-- 예제) 아래와 같이 조회하시오
-- department 테이블의 데이터는 모두 조회하고, employee 테이블의 데이터는 일치하는 것만 조회하시오
/*
    dept_no     사원수
    1               2
    2               2
    3               0
    4               0
*/
SELECT
          d.dept_no
        , COUNT(e.depart) AS 사원수 -- count(*)로 했으면 모든 칼럼이 나와서 0이 나오지 않는다
 FROM department d LEFT OUTER JOIN employee e
 ON d.dept_no=e.depart
 GROUP BY d.dept_no;
 
-- 리뷰1. 모든 사원들의 name, dept_name을 조회하기(부서가 없는 사원은 조회하지 말기)
SELECT
           e.name
         , d.dept_name
 FROM department d INNER JOIN employee e
     ON d.dept_no=e.depart; -- 내부조인
    
SELECT
            e.name
          , d.dept_name
  FROM department d, employee e
 WHERE d.dept_no=e.depart;
 
 
 -- 리뷰2. '서울'에서 근무하는 사원들의 emp_no, name 조회하기
SELECT
            emp_no
         ,  name
  FROM department d INNER JOIN employee e
      ON d.dept_no=e.depart
 WHERE d.location='서울';
    
SELECT
            emp_no
         ,  name
  FROM department d, employee e
 WHERE d.dept_no=e.depart
    AND d.location='서울';
 
 
 -- 리뷰3. 모든 사원들의 name, dept_name 조회하기(부서가 없는 사원도 조회하기)
 /*
    department    employee
    dept_no         depart
    1                   1
    2                   1
    3                   2
    4                   2
                         5 김미나
                         
    일치하는 부서번호가 없는 김미나도 출력하기 위해서, 오른쪽 외부 조인으로 처리한다                     
 */
 
SELECT
          e.name
       ,  d.dept_name
FROM department d RIGHT OUTER JOIN employee e
    ON d.dept_no=e.depart;
    
SELECT
           e.name
        ,  d.dept_name
 FROM department d, employee e
WHERE d.dept_no(+)=e.depart;  -- (+)가 있는 테이블은 일치하는 정보만 조회, (+)가 없는 테이블은 전체 조회









