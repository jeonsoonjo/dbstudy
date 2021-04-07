DROP TABLE employee;

-- 1. 데이터베이스 생성
CREATE TABLE department
(
    dept_no NUMBER, -- 부서번호 PK
    dept_name VARCHAR2(15) NOT NULL, -- 부서명
    LOCATION VARCHAR2(15) NOT NULL -- 부서위치
--  PRIMARY KEY(dept_no)
);

CREATE TABLE employee
(
    emp_no NUMBER, -- 사원번호 PK
    NAME VARCHAR2(20) NOT NULL, -- 사원이름
    depart NUMBER, -- department FK
    POSITION VARCHAR2(20), -- 직급
    gender CHAR(2), -- 성별
    hire_date DATE, -- 고용일
    salary NUMBER -- 급여
--  PRIMARY KEY(emp_no),
--  FOREIGN KEY(dept_no) REFERENCES department(dept_no)
);

-- alter문으로 PK, FK 지정
ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY(dept_no);
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY(emp_no);
ALTER TABLE employee ADD CONSTRAINT employee_fk FOREIGN KEY(depart) REFERENCES department(dept_no);



-- 2. 데이터 삽입
-- insert into 테이블명 values(칼럼값1, 칼럼2, ...); -- 전체 삽입
-- insert into 테이블명(칼럼1, 칼럼2, ...) values(칼럼값1, 칼럼값2, ...) -- 부분 삽입
-- 날짜 타입 작성
-- 1) '2021-04-02'
-- 2) '21-04-02'
-- 3) '2021/04/02'
-- 4) '21/04/02' -- 오라클 기본값

-- department 먼저 데이터 삽입 해야 한다(employee에서 참조하는 외래키가 있기 때문)
INSERT INTO department(dept_no, dept_name, LOCATION) VALUES(1, '영업부', '대구');
INSERT INTO department(dept_no, dept_name, LOCATION) VALUES(2, '인사부', '서울');
INSERT INTO department(dept_no, dept_name, LOCATION) VALUES(3, '총무부', '대구');
INSERT INTO department(dept_no, dept_name, LOCATION) VALUES(4, '기획부', '서울');

INSERT INTO employee VALUES(1001, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO employee VALUES(1002, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO employee VALUES(1003, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO employee VALUES(1004, '한성실', 2, '과장', 'F', '93-04-01', 5000000);


-- 3. 행(Row) 수정
-- update 테이블명 set 수정할 내용 where 조건;
-- 1) 영업부의 위치(location)를 '인천'으로 수정
UPDATE department SET LOCATION='인천' WHERE dept_no=1;

-- 2) '과장'과 '부장'의 월급(salary)을 10% 인상
-- update employee set salary=salary * 1.1 where position='과장' or position='부장'; -- 각각 써줘야 하니 불편하다(조건이 적을 때 유리)
UPDATE employee SET salary=salary * 1.1 WHERE POSITION IN('과장', '부장'); -- in( , ,)을 사용해 한 번에 처리한다

-- 3) '총무부' -> '총괄팀', '대구' -> '광주'로 수정
UPDATE department SET LOCATION='광주', dept_name='총괄팀' WHERE dept_no=3;



-- 4. 행(Row) 삭제
-- delete from 테이블명; -- 전체삭제
-- delete from 테이블명 where 조건; -- 부분삭제
-- 1) 모든 employee 행 삭제
DELETE FROM employee; -- rollback으로 복구 가능, 

-- 2) '기획부'만 삭제
DELETE FROM department WHERE dept_no='4';








