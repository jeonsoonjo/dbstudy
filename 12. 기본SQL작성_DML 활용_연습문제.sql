-- <테이블 삭제>
-- 외래키 가진 테이블 먼저 삭제
DROP TABLE lecture;
DROP TABLE enroll;
DROP TABLE student;
-- 외래키가 없는 테이블 나중에 삭제
DROP TABLE course;
DROP TABLE professor;


-- <데이터베이스 생성>
-- 교수(professor) 테이블
CREATE TABLE professor
(
    professor_no NUMBER(5), -- PK, 교수번호
    professor_name VARCHAR2(15), -- 교수이름
    professor_major VARCHAR2(20) -- 교수전공
);

-- 과목(course) 테이블
CREATE TABLE course
(
    course_no NUMBER(5), -- PK, 과목번호
    course_name VARCHAR(30), -- 과목명
    course_score NUMBER -- 이수학점
);

-- 학생(student) 테이블
CREATE TABLE student
(
    student_no VARCHAR2(10), -- PK, 학번
    student_name VARCHAR2(15), -- 학생이름
    student_address VARCHAR2(30), -- 학생주소
    student_grade VARCHAR2(10), -- 학년
    professor_no NUMBER(5) -- professor FK
);

-- 수강신청(enroll) 테이블
CREATE TABLE enroll
(
    enroll_no NUMBER(5), -- PK, 수강신청번호
    student_no VARCHAR2(10), -- student FK
    course_no NUMBER(5), -- course FK
    enroll_date DATE -- 신청일자
);

-- 강의(lecture) 테이블
CREATE TABLE lecture
(
    lecture_no NUMBER(5), -- PK, 강의번호
    professor_no NUMBER(5), -- professor FK
    enroll_no NUMBER(5), -- enroll FK
    lecture_name VARCHAR2(30), -- 강의이름
    lecture_classroom VARCHAR2(15) -- 강의실
);

-- alter문으로 pk, fk 지정
ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY(professor_no);
ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY(student_no);
ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY(course_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_pk PRIMARY KEY(enroll_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY(lecture_no);

ALTER TABLE student ADD CONSTRAINT student_professor_fk FOREIGN KEY(professor_no) REFERENCES professor(professor_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_student_fk FOREIGN KEY(student_no) REFERENCES student(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_course_fk FOREIGN KEY(course_no) REFERENCES course(course_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_professor_fk FOREIGN KEY(professor_no) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_enroll_fk FOREIGN KEY(enroll_no) REFERENCES enroll(enroll_no);

-- 학생(student)테이블 학년(student_grade) 칼럼타입 수정
ALTER TABLE student MODIFY student_grade VARCHAR2(10);
-- 학생(student)테이블 학생주소(student_location) 칼럼명 수정(오타났었음)
ALTER TABLE student RENAME COLUMN sutdent_location TO student_location;
-- 기타 칼럼명 수정
ALTER TABLE student RENAME COLUMN student_location TO student_address;


-- <데이터 삽입>
-- 교수(professor) : 교수번호, 이름, 전공
INSERT INTO professor VALUES(1001, '윤건우', '경제학');
INSERT INTO professor VALUES(1002, '전지연', '생물학');
INSERT INTO professor VALUES(1003, '성봉현', '경영학');
INSERT INTO professor VALUES(1004, '엄지', '회계학');
INSERT INTO professor VALUES(1005, '최보람', '법학');

-- 과목(course) : 과목번호, 과목명, 이수학점
INSERT INTO course VALUES(3001, '경영', 15);
INSERT INTO course VALUES(3002, '경제', 5);
INSERT INTO course VALUES(3003, '회계', 10);
INSERT INTO course VALUES(3004, '법학', 10);
INSERT INTO course VALUES(3005, '생물', 10);

-- 학생(student) : 학번, 이름, 주소, 학년
INSERT INTO student(student_no, student_name, student_address, student_grade) VALUES('2001', '전순조', '서울', '고2');
INSERT INTO student(student_no, student_name, student_address, student_grade) VALUES('2002', '전현준', '인천', '고3');
INSERT INTO student(student_no, student_name, student_address, student_grade) VALUES('2003', '김이순', '영광', '고1');
INSERT INTO student(student_no, student_name, student_address, student_grade) VALUES('2004', '전승훈', '흑산도', '고3');
INSERT INTO student(student_no, student_name, student_address, student_grade) VALUES('2005', '성삼송', '파주', '고2');

-- 학생테이블에 교수번호 입력 못 해서 따로 update 함
UPDATE student SET professor_no='1001' WHERE student_no='2004';
UPDATE student SET professor_no='1004' WHERE student_no='2001';
UPDATE student SET professor_no='1003' WHERE student_no='2003';
UPDATE student SET professor_no='1002' WHERE student_no='2002';
UPDATE student SET professor_no='1005' WHERE student_no='2005';

-- 수강(enroll) : 수강신청번호, 학번, 과목번호, 신청일자
INSERT INTO enroll VALUES(4001, '2001', 3001, sysdate);
INSERT INTO enroll VALUES(4002, '2004', 3003, sysdate);
INSERT INTO enroll VALUES(4003, '2002', 3005, sysdate);

---- 강의(lecture) 테이블
--CREATE TABLE lecture
--(
--    lecture_no NUMBER(5), -- PK, 강의번호
--    professor_no NUMBER(5), -- professor FK
--    enroll_no NUMBER(5), -- enroll FK
--    lecture_name VARCHAR2(30), -- 강의이름
--    lecture_classroom VARCHAR2(15) -- 강의실
--);
-- 강의(lecture) : 강의번호, 교수번호, 수강신청번호, 강의이름, 강의실
INSERT INTO lecture VALUES(1111, 1001, 4001, '경제란무엇인가', 'A101');
INSERT INTO lecture VALUES(2111, 1004, 4002, '회계란무엇인가', 'B101');
INSERT INTO lecture VALUES(3111, 1002, 4003, '생물이란 무엇인가', 'A202');

-- 변경된 내용 DB에 저장
COMMIT;
