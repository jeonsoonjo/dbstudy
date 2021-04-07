DROP TABLE customer;
DROP TABLE bank;

-- 1. 일일이 쓰기
--CREATE TABLE bank
--(
--    bank_code VARCHAR2(20),
--    bank_name VARCHAR2(30),
--    PRIMARY KEY(bank_code)
--);
--
--CREATE TABLE customer
--(
--    NO NUMBER,
--    NAME VARCHAR2(30) NOT NULL,
--    phone VARCHAR2(30),
--    age NUMBER,
--    bank_code VARCHAR2(20),
--    PRIMARY KEY(NO),
--    UNIQUE(phone),
--    CHECK(age BETWEEN 0 AND 100),
--    FOREIGN KEY(bank_code) REFERENCES bank(bank_code)
--);

-- 2. 제약조건 한 번에 쓰기(모델링으로 봤을때 제일 깔끔하다)
CREATE TABLE bank
(
    bank_code VARCHAR2(20),
    bank_name varchar2(15),
    CONSTRAINT bank_pk PRIMARY KEY(bank_code)
);

CREATE TABLE customer
(
    NO NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age NUMBER,
    bank_code VARCHAR2(20),
    CONSTRAINT customer_pk PRIMARY KEY(NO),
    CONSTRAINT customer_phone_uq UNIQUE(phone),
    CONSTRAINT customer_age_ck CHECK(age BETWEEN 0 AND 100),
    CONSTRAINT customer_bank_fk FOREIGN KEY(bank_code) REFERENCES bank(bank_code)
);

-- 3. 테이블 변경
-- ALTER TABLE 테이블명 ADD, REMOVE, MODIFY 등
CREATE TABLE bank
(
    bank_code VARCHAR2(20),
    bank_name VARCHAR2(30)
);

CREATE TABLE customer
(
    NO NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age NUMBER(3),
    bank_code VARCHAR2(20)
);

-- ALTER문을 사용해 제약조건 넣기
ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY(bank_code);
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY(NO);
ALTER TABLE customer ADD CONSTRAINT customer_phone_uq UNIQUE(phone);
ALTER TABLE customer ADD CONSTRAINT customer_age_ck CHECK(age BETWEEN 0 AND 100);
ALTER TABLE customer ADD CONSTRAINT customer_bank_fk FOREIGN KEY(bank_code) REFERENCES bank(bank_code);

-- 4. 테이블 구조 확인
DESC bank;
DESC customer;

-- 5. 칼럼 추가
-- ALTER TABLE 테이블명 ADD 칼럼명 칼럼타입 [제약조건]; -- 제약조건은 생략가능
-- 5-1) bank 테이블의 bank_phone 칼럼 추가하기
ALTER TABLE bank ADD bank_phone VARCHAR2(15);

-- 6. 칼럼 수정
-- ALTER TABLE 테이블명 MODIFY 칼럼명 칼럼타입 [제약조건];
-- 6-1) bank_name 칼럼타입을 varchar2(15)로 수정하기
ALTER TABLE bank MODIFY bank_name VARCHAR2(15);

-- 6-2) customer 테이블의 age 칼럼타입을 number(3)로 수정하기
ALTER TABLE customer MODIFY age NUMBER(3);

-- 6-3) customer 테이블의 phone 칼럼타입을 제약조건 not null로 수정하기
ALTER TABLE customer MODIFY phone VARCHAR2(30) NOT NULL; -- 칼럼타입은 그대로 써줘야 한다(생략 불가)

-- 6-4) customer 테이블의 phone 칼럼을 null로 수정하기
ALTER TABLE customer MODIFY phone VARCHAR2(30) NULL;

-- 7. 칼럼 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
ALTER TABLE bank DROP COLUMN bank_phone;

-- 8. 칼럼명 변경
-- ALTER TABLE 테이블명 rename column 기존칼럼명 TO 신규칼럼명;
-- 8-1) customer 테이블의 phone 칼럼명을 contact로 수정하기
ALTER TABLE customer RENAME COLUMN phone TO contact;















