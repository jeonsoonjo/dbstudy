-- 1:1 관계
-- 테이블의 생성 순서, 부모테이블 먼저 생성(PK가 먼저 생성되어야 함) 
CREATE TABLE school
(
    school_code NUMBER(2) PRIMARY KEY, -- number 타입 길이는 꼭 정하지 않아도 된다
    school_name VARCHAR2(100)
);

CREATE TABLE student
(
    school_code NUMBER(2) REFERENCES school(school_code), -- 외래키 생성할 때는 기본키와 같은 타입이어야 한다(타입, 길이 모두 같아야 한다, 칼럼명은 상관 없음)
    student_name VARCHAR2(100)
);

-- 테이블의 삭제 순서, 자식테이블 먼저 삭제(FK가 먼저 삭제되어야 함)
DROP TABLE student;
DROP TABLE school;




-- N:M 관계
-- 학생 테이블
CREATE TABLE student
(
    student_no NUMBER(5) PRIMARY KEY, -- NUMBER 보단 VARCAHR2 추천, 숫자보다 문자가 더 빠르다
    student_name VARCHAR2(50),
    student_age NUMBER(2)
);
-- 과목 테이블
CREATE TABLE subject
(
    subject_code VARCHAR2(2) PRIMARY KEY,
    subject_name VARCHAR2(100),
    subject_professor VARCHAR2(50)
);
-- 수강신청 테이블
CREATE TABLE subject_apply
(
    apply_no NUMBER(3) PRIMARY KEY,
    student_no NUMBER(5) REFERENCES student(student_no),
    subject_code VARCHAR2(2) REFERENCES subject(subject_code)
);

-- 삭제할 때는 자식(외래키가 있는) 부터
DROP TABLE subject_apply;
DROP TABLE subject;
DROP TABLE student;





-- 연습문제
-- 제약조건 추가(PK, FK)
-- 테이블 생성 순서 조정
-- 칼럼 수정(칼럼명, 타입)


-- 회원 테이블
CREATE TABLE members --  member는 키워드라서 권장 하지 않음
(
    members_no NUMBER, -- 회원번호(PK)
    members_id VARCHAR2(30), -- 아이디
    members_pw VARCHAR2(30), -- 비밀번호
    members_name VARCHAR2(15), -- 이름
    members_email VARCHAR2(50), -- 이메일
    members_phone VARCHAR2(15), -- 전화번호
    members_date DATE, -- 가입일
    PRIMARY KEY(members_no) -- 별도로 빼서도 작업이 가능하다
);

-- 게시판 테이블
CREATE TABLE board
(
    board_no NUMBER, -- 게시글번호
    board_title VARCHAR2(1000), -- 제목
    board_content VARCHAR2(4000), -- 내용 -- varchar2 타입 최대 사이즈 4000
    board_hit NUMBER, -- 조회수
    members_no NUMBER, -- 작성자(member FK)
    board_date DATE, -- 작성일자
    PRIMARY KEY(board_no),
    FOREIGN KEY(members_no) REFERENCES members(members_no) -- 별도로 빼서 작업할 때는 foreign key 를 써야 한다
);

-- 테이블 조건을 하나씩 보고 참조하는 것이 있는지 아닌지 확인
-- 참조하는 것이 없으면 먼저 생성(기본키 위주)
-- 다음 기본키를 참조하는 외래키 테이블을 생성


-- 제조사 테이블
CREATE TABLE manufacturer
(
    manufacturer_no VARCHAR2(12), -- 사업자번호(PK)
    manufacturer_name VARCHAR2(100), -- 제조사명
    manufacturer_phone VARCHAR2(15), -- 연락처
    PRIMARY KEY(manufacturer_no)
);

-- 창고 테이블
CREATE TABLE warehouse
(
    warehouse_no NUMBER PRIMARY KEY, -- 창고번호(PK)
    warehouse_name VARCHAR2(5), -- 창고이름
    warehouse_location VARCHAR2(100), -- 창고위치
    warehouse_used VARCHAR2(1) -- 사용여부
);

-- 택배업체 테이블
CREATE TABLE delivery_service
(
    delivery_service_no VARCHAR2(12), -- 택배업체 사업자번호(PK)
    delivery_service_name VARCHAR2(20), -- 택배업체명
    delivery_service_phone VARCHAR2(15), -- 택배업체 연락처
    delivery_service_address VARCHAR2(100), -- 택배업체 주소
    PRIMARY KEY(delivery_service_no)
);

-- 배송 테이블
CREATE TABLE delivery
(
    delivery_no NUMBER, -- 배송번호(PK)
    -- 참조하는 칼럼타입은 같아야 하지만, 칼럼명은 달라도 된다
    delivery_service VARCHAR2(12), -- 배송업체(택배업체)(delivery_service FK)
    delivery_date DATE, -- 배송날짜
    PRIMARY KEY(delivery_no),
    FOREIGN KEY(delievery_service_no) REFERENCES delivery_service(delievery_service_no)
);

-- 주문 테이블
CREATE TABLE orders
(
    orders_no NUMBER, -- 주문번호(PK)
    members_no NUMBER, -- 주문회원(members FK)
    delivery_no NUMBER, -- 배송번호(delivery FK)
    orders_pay VARCHAR2(10), -- 결제방법
    orders_date DATE, -- 주문일자
    PRIMARY KEY(orders_no),
    FOREIGN KEY(members_no) REFERENCES members(members_no),
    FOREIGN KEY(delivery_no) REFERENCES delivery(delivery_no)
);

-- 제품 테이블
CREATE TABLE product
(
    product_code VARCHAR2(10), -- 제품번호(PK)
    product_name VARCHAR2(50), -- 제품명
    product_price NUMBER, -- 가격
    product_category VARCHAR2(15), -- 카테고리
    orders_no NUMBER, -- 주문번호(orders FK)
    manufacturer_no VARCHAR2(12), -- 제조사(manufacturer FK)
    warehouse_no NUMBER, -- 창고번호(warehouse FK)
    PRIMARY KEY(product_code),
    FOREIGN KEY(orders_no) REFERENCES orders(orders_no),
    FOREIGN KEY(manufacturer_no) REFERENCES manufacturer(manufacturer_no),
    FOREIGN KEY(warehouse_no) REFERENCES warehouse(warehouse_no)
);



