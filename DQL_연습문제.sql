-- 1. 다음 설명을 읽고 적절한 테이블을 생성하되, 기본키/외래키는 별도로 설정하지 마시오.

-- 1) BOOK 테이블
--    (1) BOOK_ID : 책 아이디, 숫자 (최대 11자리), 필수
--    (2) BOOK_NAME : 책 이름, 가변 길이 문자 (최대 100)
--    (3) PUBLISHER : 출판사, 가변 길이 문자 (최대 50)
--    (4) PRICE : 가격, 숫자 (최대 6자리)
CREATE TABLE book
(
    book_id NUMBER(11) NOT NULL, -- PK, 책 아이디
    book_name VARCHAR2(100), -- 책 이름
    publisher VARCHAR2(50), -- 출판사
    price NUMBER(6) -- 가격
);


-- 2) CUSTOMER 테이블
--    (1) CUSTOMER_ID : 고객 아이디, 숫자 (최대 11자리), 필수
--    (2) CUSTOMER_NAME : 고객 이름, 가변 길이 문자 (최대 20)
--    (3) ADDRESS : 고객 주소, 가변 길이 문자 (최대 50)
--    (4) PHONE : 고객 전화, 가변 길이 문자 (최대 20)
CREATE TABLE customer
(
    customer_id NUMBER(11) NOT NULL, -- PK, 고객 아이디
    customer_name VARCHAR2(20), -- 고객 이름
    address VARCHAR2(50), -- 주소
    phone VARCHAR2(20) -- 폰 번호
);


-- 3) ORDERS 테이블
--    (1) ORDER_ID : 주문 아이디, 숫자 (최대 11자리), 필수
--    (2) CUSTOMER_ID : 고객 아이디, 숫자 (최대 11자리)
--    (3) BOOK_ID : 책 아이디, 숫자 (최대 11자리)
--    (4) SALE_PRICE : 판매 가격, 숫자 (최대 6자리)
--    (5) ORDER_DATE : 주문일, 날짜
create table orders
(
    order_id number(11) not null, -- PK, 주문 아이디
    customer_id  NUMBER(11), -- customer FK
    book_id NUMBER(11), -- book FK
    sales_price number(6), -- 판매가격
    order_date date -- 주문날짜
);

ALTER TABLE orders RENAME COLUMN sale_price TO sales_price;


-- 4) 아래 INSERT 문은 변경 없이 그대로 사용한다.
INSERT ALL
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (1, '축구의역사', '굿스포츠', 7000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (2, '축구아는 여자', '나무수', 13000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (3, '축구의 이해', '대한미디어', 22000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (4, '골프 바이블', '대한미디어', 35000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (5, '피겨 교본', '굿스포츠', 6000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (6, '역도 단계별 기술', '굿스포츠', 6000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (7, '야구의 추억', '이상미디어', 20000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (8, '야구를 부탁해', '이상미디어', 13000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (9, '올림픽 이야기', '삼성당', 7500)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (10,'올림픽 챔피언', '피어슨', 13000)
SELECT * FROM DUAL;

INSERT ALL
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (2, '김연아', '대한민국 서울', '000-6000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (4, '추신수', '미국 텍사스', '000-8000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (5, '박세리', '대한민국 대전', NULL)
SELECT * FROM DUAL;

INSERT ALL 
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (1, 1, 1, 6000, '2014-07-01')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (2, 1, 3, 21000, '2014-07-03')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (3, 2, 5, 8000, '2014-07-03')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (4, 3, 6, 6000, '2014-07-04')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (5, 4, 7, 20000, '2014-07-05')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (6, 1, 2, 12000, '2014-07-07')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (7, 4, 8, 13000, '2014-07-07')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (8, 3, 10, 12000, '2014-07-08')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (9, 2, 10, 7000, '2014-07-09')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (10, 3, 8, 13000, '2014-07-10')
SELECT * FROM DUAL;


-- 2. BOOK, CUSTOMER, ORDERS 테이블들의 적절한 칼럼에 기본키를 추가하시오.
ALTER TABLE book ADD CONSTRAINT book_pk PRIMARY KEY(book_id);
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY(customer_id);
ALTER TABLE orders ADD CONSTRAINT order_pk PRIMARY KEY(order_id);


-- 3. 외래키가 필요한 테이블을 선정하고 적절한 칼럼에 외래키를 추가하시오.
ALTER TABLE orders ADD CONSTRAINT orders_book_fk FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE orders ADD CONSTRAINT orders_customer_fk FOREIGN KEY(customer_id) REFERENCES customer(customer_id);


-- 4. 2014년 7월 4일부터 7월 7일 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
SELECT *
 FROM orders
WHERE order_date NOT BETWEEN '2014-07-04' AND '2014-07-07';
/** 위 처럼 조회하면 book_id는 나오지만 book_name은 안 나온다(상식적으로 책 이름을 아는게 좋다) */

SELECT o.order_id
         , b.book_name
         , c.customer_name
         , o.sales_price
         , o.order_date
 FROM customer c, book b, orders o
WHERE c.customer_id=o.customer_id
   AND b.book_id=o.book_id
   AND order_date NOT BETWEEN '2014-07-04' AND '2014-07-07';
/** inner join으로 하면 복잡해지니 참조 테이블이 3개 이상일 경우에는 간편한 where절 활용 */        


-- 5. 박지성의 총 구매액(SALES_PRICE)을 조회하시오.
-- customer, orders
-- 1) 내부조인
SELECT c.customer_name AS 고객이름
         , SUM(o.sales_price) AS 총구매액
 FROM customer c INNER JOIN orders o
     ON c.customer_id=o.customer_id
WHERE c.customer_name='박지성'
GROUP BY c.customer_name; -- 직계함수를 보여주고자 group by를 써야 한다(select절에서 customer_name을 조회할 것이기 때문)

-- 2) 서브쿼리(내부조인, 서브쿼리가 가능할 땐, 내부조인으로.. 서브쿼리는 복잡함)
SELECT p.customer_name AS 고객이름
         , SUM(p.sales_price) AS 총구매액
 FROM (SELECT o.sales_price
                     , c.customer_name
             FROM customer c, orders o
            WHERE c.customer_id=o.customer_id
               AND c.customer_name='박지성') p
GROUP BY p.customer_name;

-- 3) 스칼라 서브쿼리
SELECT c.customer_name AS 고객이름
         , (SELECT SUM(o.sales_price) -- 실행순서 3
             FROM orders o
            WHERE c.customer_id=o.customer_id) AS 총구매액
 FROM customer c -- 실행순서 1
WHERE c.customer_name='박지성'; -- 실행순서 2


-- 6. 박지성이 구매한 도서의 수를 조회하시오.
-- customer, orders
-- 박지성 고객의 주문아이디 수량을 확인하면 쉽게 알 수 있다
-- 1) 내부조인
SELECT c.customer_name AS 고객이름
         , COUNT(o.order_id) AS 총구매횟수
 FROM customer c INNER JOIN orders o
     ON c.customer_id=o.customer_id
WHERE c.customer_name='박지성' -- 이 조건을 빼면 고객마다 몇 권을 구매했는지 알 수 있다
GROUP BY c.customer_name;

-- 2) where절
SELECT c.customer_name AS 고객이름 
         , COUNT(o.order_id) AS 총구매횟수
 FROM customer c, orders o
WHERE c.customer_id=o.customer_id
    AND c.customer_name='박지성'
GROUP BY c.customer_name;


-- 7. 박지성이 구매한 도서를 발간한 출판사(PUBLISHER)의 수를 조회하시오.
-- customer, orders, book 
-- 참조테이블이 3개 이상이면 where절 활용
-- 1) 내부조인(3개 이상)
SELECT  c.customer_name AS 고객이름
          , COUNT(DISTINCT b.publisher) AS 출판사수 -- 같은 출판사는 중복되지 않게
  FROM customer c INNER JOIN orders o
      ON c.customer_id=o.customer_id INNER JOIN book b
      ON b.book_id=o.book_id
WHERE c.customer_name='박지성'
GROUP BY c.customer_name;

SELECT c.customer_name AS 고객이름
         , COUNT(DISTINCT b.pulisher) AS 출판사수
 FROM customer c, book b, orders o
 WHERE c.customer_id=o.customer_id
    AND b.book_id=o.book_id
    AND c.customer_name='박지성'
GROUP BY c.customer_name;



-- 8. 고객별로 분류하여 각 고객의 이름과 각 고객별 총 구매액을 조회하시오. 주문 이력이 없으면 0으로 조회하시오.
-- 1) 외부조인
SELECT  c.customer_name
          , NVL(SUM(o.sales_price), 0) AS 총구매액 -- NVL(표현식, null일때 사용할 값)
  FROM customer c LEFT OUTER JOIN orders o -- 박세리는 주문한 적이 없기 때문에(null) 고객테이블에서 박세리 정보를 가져온다
      ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

-- 2) where절
SELECT c.customer_name
         , NVL(SUM(o.sales_price), 0) AS 총구매액
 FROM customer c, orders o
WHERE c.customer_id=o.customer_id(+)
GROUP BY c.customer_name;


-- 9. 주문한 이력이 없는 고객의 이름을 조회하시오.
-- 서브쿼리
-- select 고객이름 from 고객테이블 where customer_id not in(주문한 customer_id FROM 주문테이블);
SELECT c.customer_name AS 고객이름
 FROM customer c
WHERE c.customer_id NOT IN(SELECT DISTINCT o.customer_id
                                            FROM orders o);


-- 10. 고객별로 총 구매횟수를 조회하시오.
SELECT c.customer_name AS 고객이름
         , COUNT(o.order_id) AS 총구매횟수
 FROM customer c INNER JOIN orders o
     ON c.customer_id=o.customer_id
-- WHERE c.customer_name='박지성' -- 이 조건을 빼면 고객마다 몇 권을 구매했는지 알 수 있다(위 6번 문제)
GROUP BY c.customer_name;


-- 11. 고객별로 총 구매횟수를 조회하시오. 주문 이력이 없으면 0으로 조회하시오
SELECT c.customer_id AS 고객아이디 -- 혹시나 동일 고객이름이 있을 수 있기 때문에 아이디(PK)로 구분하기
          , c.customer_name AS 고객이름
          , NVL(COUNT(o.order_id), 0) AS 총구매횟수 -- NVL(표현식, null일때 사용할 값)
  FROM customer c LEFT OUTER JOIN orders o -- 박세리는 주문한 적이 없기 때문에(null) 고객테이블에서 박세리 정보를 가져온다
      ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.customer_name;






