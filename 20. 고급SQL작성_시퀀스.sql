-- 시퀀스
-- 1. 일렬번호 생성 객체이다
-- 2. 주로 기본키(인공키)에서 사용한다
-- 3. currval : 시퀀스가 생성해서 사용한 현재 번호
-- 4. nextval : 시퀀스가 생성해야 할 다음 번호


-- 시퀀스 생성
CREATE SEQUENCE employee_seq
INCREMENT BY 1 -- 번호가 1씩 증가한다
START WITH 1000 -- 번호 시작이 1000이다
NOMAXVALUE -- 최대값 없음
NOMINVALUE -- 최소값 없음
NOCYCLE -- 번호 순환이 없다
NOCACHE; -- 메모리에 캐시하지 않는다. 항상 유지


-- employee3 테이블에 행 삽입
-- emp_no는 시퀀스로 입력
INSERT INTO employee3
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
    (employee_seq.nextval, '구창민', 1, '과장', 'M', '95-05-01', 500000);
    
    
-- 시퀀스 값 확인
SELECT employee_seq.currval
 FROM dual;
 
 
-- 시퀀스 목록 확인
 SELECT *
  FROM user_sequences;
  

-- ROWNUM : 가상 행 번호(조건으로 사용할 수 있다)
-- ROWID : 데이터가 저장된 물리적 위치 정보
SELECT ROWNUM, ROWID, emp_no, name
 FROM employee;
 

-- 최고 빠른 검색 : rowid를 이용한 검색(오라클의 검색 방식)
SELECT emp_no, name
 FROM employee
WHERE ROWID='AAAE/yAABAAALCxAAB';

-- 그 다음 빠른 검색 : index를 이용한 검색(휴먼의 검색 방식)
SELECT emp_no, name
 FROM employee
WHERE emp_no=1003; -- index 번호를 매겼으니 이름으로 검색하지 말자
  

-- ROWNUM의 WHERE절 사용
-- 주의.
-- 1. 1을 포함하는 검색만 가능하다
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다
-- 3. 특정 위치를 지정한 검색은 불가능하다
SELECT emp_no, name
 FROM employee
WHERE ROWNUM=1; -- 검색 가능
  
SELECT emp_no, name
 FROM employee
WHERE ROWNUM=2; -- 1이 아니면 검색 불가능
  
SELECT emp_no, name
 FROM employee
WHERE ROWNUM BETWEEN 1 AND 3; -- 1이 포함되어 있어서 검색 가능함ㅋㅋ
  
SELECT emp_no, name
 FROM employee
WHERE ROWNUM BETWEEN 3 AND 5; -- 검색 불가

-- 1 이외의 번호로 시작하는 모든 ROWNUM을 사용하기 위해서는
-- ROWNUM에 별명을 주고 별명을 사용하면 검색이 가능하다

-- 실행 순서 때문에 처리 안 되는 쿼리문
SELECT ROWNUM AS rn -- 실행순서 3
         , emp_no
         , name
 FROM employee -- 실행순서 1
WHERE rn=2; -- 실행순서 2
  
SELECT e.emp_no, name
 FROM (SELECT ROWNUM AS rn
                  , emp_no
                  , NAME
            FROM employee) e
WHERE e.rn=2;




-- 연습문제
-- 1. 다음 테이블 생성하기
-- 게시판(글번호, 글제목, 글내용, 글작성자, 작성일자)
-- 회원(회원번호, 아이디, 이름, 가입일자)
DROP TABLE board;
DROP TABLE member;

CREATE TABLE member
(
    m_no NUMBER(5), -- 회원번호
    m_id VARCHAR2(10), -- 회원 아이디 PK
    m_name VARCHAR2(10), -- 회원 이름
    m_date DATE -- 가입일자
);

CREATE TABLE board
(
    b_no NUMBER(5), -- 글 번호 PK
    b_title VARCHAR2(100), -- 글 제목
    b_content VARCHAR2(1000), -- 글 내용
    m_id VARCHAR2(10), -- 회원아이디, member FK
    b_date DATE -- 작성일자
);

ALTER TABLE board RENAME COLUMN w_date TO b_date;

-- 2. 각 테이블에서 사용할 시퀀스 생성하기
-- 게시판시퀀스(1~무제한)
-- 회원시퀀스(100000~999999)
DROP SEQUENCE board_seq;
DROP SEQUENCE member_seq;

CREATE SEQUENCE board_seq
INCREMENT BY 1 -- 번호가 1씩 증가한다
START WITH 1 -- 번호 시작이 1000이다
NOMAXVALUE -- 최대값 없음
NOMINVALUE -- 최소값 없음
NOCYCLE -- 번호 순환이 없다
NOCACHE;

CREATE SEQUENCE member_seq
INCREMENT BY 1 -- 번호가 1씩 증가한다
START WITH 1 -- 번호 시작이 1000이다
MAXVALUE 999999 -- 최대값 없음
NOMINVALUE -- 최소값 없음
NOCYCLE -- 번호 순환이 없다
NOCACHE; 



-- 3. 각 테이블에 적절한 기본키, 외래키, 데이터(5개) 추가하기
ALTER TABLE member ADD CONSTRAINT m_id_pk PRIMARY KEY(m_id);
ALTER TABLE board ADD CONSTRAINT b_no_pk PRIMARY KEY(b_no);
ALTER TABLE board ADD CONSTRAINT b_m_id_fk FOREIGN KEY(m_id) REFERENCES MEMBER(m_id);

INSERT INTO member (m_no, m_id, m_name, m_date) VALUES (member_seq.NEXTVAL, 'soonjo', '전순조', sysdate);
INSERT INTO member (m_no, m_id, m_name, m_date) VALUES (member_seq.NEXTVAL, 'bong', '김봉현', '20-04-13');
INSERT INTO member (m_no, m_id, m_name, m_date) VALUES (member_seq.NEXTVAL, 'jiyeon', '전지연', '21-01-23');
INSERT INTO member (m_no, m_id, m_name, m_date) VALUES (member_seq.NEXTVAL, 'gunwoo', '윤건우', sysdate);
INSERT INTO member (m_no, m_id, m_name, m_date) VALUES (member_seq.NEXTVAL, 'gugu', '구구', '07-12-25');
SELECT * FROM member;

INSERT INTO board (b_no, b_title, b_content, m_id, b_date) VALUES (board_seq.NEXTVAL, '출석', '가입인사 드립니다', 'gunwoo', '21-04-08');
INSERT INTO board (b_no, b_title, b_content, m_id, b_date) VALUES (board_seq.NEXTVAL, '공지사항', '[필독]공지사항입니다', 'gugu', '20-11-06');
INSERT INTO board (b_no, b_title, b_content, m_id, b_date) VALUES (board_seq.NEXTVAL, '질문', '이거 어떻게 해야 하나요?', 'soonjo', '21-03-21');
INSERT INTO board (b_no, b_title, b_content, m_id, b_date) VALUES (board_seq.NEXTVAL, '공지', '공지입니다', 'bong', sysdate);
INSERT INTO board (b_no, b_title, b_content, m_id, b_date) VALUES (board_seq.NEXTVAL, '질문', '질문드립니다', 'soonjo', sysdate);
SELECT * FROM board;

COMMIT;



-- 4. 게시판을 글제목의 가나다순으로 정렬하고 첫 번째 글 조회하기
SELECT b.b_no -- 실행순서 3
         , b.b_title
         , b.b_content
         , b.m_id
         , b.b_date
 FROM (SELECT b_no
                     , b_title
                     , b_content
                     , m_id
                     , b_date
             FROM board
            ORDER BY b_title ASC) b -- 실행순서 1
WHERE ROWNUM=1; -- 실행순서 1



-- 5. 게시판을 글번호의 가나다순으로 정렬하고 1~3 글 조회하기
SELECT b.b_no
         , b.b_title
         , b.b_content
         , b.m_id
         , b.b_date
 FROM (SELECT b_no
                     , b_title
                     , b_content
                     , m_id
                     , b_date
             FROM board
            ORDER BY b_no ASC) b
 WHERE ROWNUM <=3;



-- 6. 게시판을 최근 작성일자순으로 정렬하고 3~5번째 글 조회하기
SELECT a.* --  실행순서 4
 FROM (SELECT b.b_no
                     , b.b_title
                     , b.b_content
                     , b.m_id
                     , b.b_date
                     , ROWNUM AS rn -- 실행순서 2
            FROM (SELECT b_no
                                , b_title
                                , b_content
                                , m_id
                                , b_date
                         FROM board
                        ORDER BY b_date DESC) b) a -- 실행순서 1
WHERE a.rn BETWEEN 3 AND 5; --  실행순서 3



-- 7. 가장 먼저 가입한 회원 조회하기
SELECT m.m_no
         , m.m_id
         , m.m_name
         , m.m_date
 FROM (SELECT  m_no
                      , m_id
                      , m_name
                      , m_date
              FROM member
             ORDER BY m_date asc) m
WHERE ROWNUM=1;



-- 8. 3번째로 가입한 회원 조회하기
SELECT    m2.m_no
            , m2.m_id
            , m2.m_name
            , m2.m_date
    FROM (SELECT m1.m_no
                        , m1.m_id
                        , m1.m_name
                        , m1.m_date
                        , ROWNUM AS rn
                FROM (SELECT m_no
                                    , m_id
                                    , m_name
                                    , m_date
                            FROM member
                           ORDER BY m_date) m1) m2
WHERE m2.rn=3;



-- 9. 가장 나중에 가입한 회원 조회하기
SELECT  m.m_no
          , m.m_id
          , m.m_name
          , m.m_date
  FROM (SELECT m_no
                      , m_id
                      , m_name
                      , m_date
              FROM member
             ORDER BY m_date DESC) m
WHERE ROWNUM=1;





  
  
  
  