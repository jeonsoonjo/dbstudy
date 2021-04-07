-- 오라클 내장 함수

DROP TABLE SCORE;

-- 1. 집계 함수
CREATE TABLE SCORE
(
    KOR NUMBER(3),
    ENG NUMBER(3),
    MAT NUMBER(3)
);

INSERT INTO SCORE VALUES(10,20,40);
INSERT INTO SCORE VALUES(30,60,80);
INSERT INTO SCORE VALUES(100,95,90);
INSERT INTO SCORE VALUES(90,65,80);
INSERT INTO SCORE VALUES(98,100,100);

-- 1-1) 국어(kor) 점수의 합계 구하기
SELECT SUM(KOR) FROM SCORE; -- 칼럼이 1개인 테이블로 보여진다
SELECT SUM(KOR) 합계 FROM SCORE; -- 칼럼의 이름을 지정하는 방법 -> 합계
SELECT SUM(KOR) AS 국어점수합계 FROM SCORE; -- -> 국어점수합계

-- 1-2) 모든 점수의 합계 구하기
SELECT SUM(KOR+ENG+MAT) 합계 FROM SCORE;
SELECT SUM(KOR)+SUM(ENG)+SUM(MAT) AS 전체점수합계 FROM SCORE;

-- 1-3) 국어(kor) 점수의 평균 구하기
SELECT AVG(KOR) AS 국어점수평균 FROM SCORE;

-- 1-4) 영어(eng) 점수의 최댓값 구하기
SELECT MAX(ENG) AS 영어점수최댓값 FROM SCORE;

-- 1-5)  수학(mat) 점수의 최솟값 구하기
SELECT MIN(MAT) AS 수학점수최솟값 FROM SCORE;

-- 1-6) 'NAME' 칼럼을 추가하고, 적당한 이름을 삽입하기
ALTER TABLE SCORE ADD NAME VARCHAR2(20);
UPDATE SCORE SET NAME='Jadu' WHERE KOR=10;
UPDATE SCORE SET NAME='zzanggu' WHERE KOR=30;
UPDATE SCORE SET NAME='babo' WHERE KOR=90;
UPDATE SCORE SET NAME='Bong' WHERE KOR=98;
UPDATE SCORE SET NAME='Soonjo' WHERE KOR=100;

-- 1-7) 국어점수 중 임의로 2개를 null로 수정
UPDATE SCORE SET KOR=NULL WHERE NAME='babo';
UPDATE SCORE SET KOR=NULL WHERE NAME='zzanggu';

-- 1-8) 이름의 개수 구하기
SELECT COUNT(NAME) FROM SCORE;

-- 1-9) 국어점수의 개수 구하기
SELECT COUNT(KOR) FROM SCORE;

-- 1-10) 학생의 개수 구하기(전체 칼럼)
SELECT COUNT(*) FROM SCORE;



-- 2. 문자 함수
-- 2-1) 대소문자 관련 함수
SELECT INITCAP(NAME) FROM SCORE; -- 첫 글자만 대문자, 나머지 소문자
SELECT UPPER(NAME) FROM SCORE; -- 전체 대문자
SELECT LOWER(NAME) FROM SCORE; -- 전체 소문자

-- 2-2) 문자열의 길이 반환 함수
SELECT LENGTH(NAME) FROM SCORE;

-- 2-3) 문자열의 일부 반환 함수
SELECT SUBSTR(NAME, 2, 3) FROM SCORE; -- (시작은 1부터) 2번째 글자부터 3글자를 반환

-- 2-4) 문자열에서 특정 문자의 포함된 위치 반환 함수
SELECT INSTR(NAME, 'Z') FROM SCORE; -- 대문자 Z의 위치 반환, 없으면 0 반환
SELECT INSTR(UPPER(NAME), 'Z') FROM SCORE; -- 대문자 Z, 소문자 z 모두 반환

-- 2-5) 왼쪽 패딩(채우기)
SELECT LPAD(NAME, 10, '*') FROM SCORE;

-- 2-6) 오른쪽 패딩
SELECT RPAD(NAME, 10, '#') FROM SCORE;

-- 2-7) 모든 name을 왼쪽 맞춤해서 출력하기
SELECT RPAD(NAME, 10, ' ') FROM SCORE;

-- 2-8) 모든 name을 다음과 같이 출력하기
-- Jadu : Ja**
-- zzanggu : jj*****
-- babo : ba**
-- Bong : Bo**
-- Soonjo : So****
SELECT RPAD(SUBSTR(NAME, 1, 2), LENGTH(NAME), '*') FROM SCORE;

-- 2-9) 문자 연결 함수
-- oracle에서 연산자 || 는 or이 아니라 연결 연산자이다
-- Jadu 10 10 10 와 같이 출력하기
SELECT NAME || ' ' || KOR || ' ' || ENG || ' ' || MAT FROM SCORE;

-- 2-10) 공백 붙이기
SELECT CONCAT(NAME, ' ') FROM SCORE; -- 이름 뒤에 공백 붙이기(concat은 인수 2개만 가능)
SELECT CONCAT(CONCAT(NAME, ' '), KOR) FROM SCORE; 

-- 2-11) 불필요한 문자열 제거 함수(좌우만 가능하고, 중간에 포함된 건 불가능)
SELECT LTRIM(NAME) FROM SCORE; -- 왼쪽 공백 제거
SELECT LENGTH(LTRIM(NAME)) FROM SCORE; -- 왼쪽 공백 제거 후 글자수
SELECT RTRIM(NAME) FROM SCORE;
SELECT LENGTH(RTRIM(NAME)) FROM SCORE;
SELECT TRIM(NAME) FROM SCORE; -- 양쪽
SELECT LENGTH(TRIM(NAME)) FROM SCORE;

-- 2-12)
INSERT INTO SCORE(KOR, ENG, MAT, NAME) VALUES(80,80,80,'james bond');
-- 아래와 같이 출력하기
-- first_name   last_name
-- james         bond
SELECT
    SUBSTR(NAME, 1, INSTR(NAME, ' ')-1) AS FIRST_NAME, -- instr 공백의 위치 구하는 함수
    SUBSTR(NAME, INSTR(NAME, ' ')+1) AS LAST_NAME
    FROM SCORE;
-- 공백이 있는 이름에 한해서만 가능하다



-- 3. 숫자 함수
-- 테이블을 사용하지 않는 select문에서는 dual 테이블을 사용한다
DESC DUAL;

-- 3-1) 반올림 함수
-- ROUND(값, 자릿수)
SELECT ROUND(123.4567, 2) FROM DUAL; -- 소수 자릿수 2자리로 반올림 --> 123.46
SELECT ROUND(123.4567, 1) FROM DUAL; -- 소수 자릿수 1자리로 반올림 --> 123.5
SELECT ROUND(123.4567, 0) FROM DUAL; -- 정수로 반올림 --> 123
SELECT ROUND(123.4567) FROM DUAL; -- 정수로 반올림 --> 123 (자릿수 생략 가능)
SELECT ROUND(123.4567, -1) FROM DUAL; -- 일의 자리에서 십의 자리로 반올림 --> 120
SELECT ROUND(123.4567, -2) FROM DUAL; -- 십의 자리에서 백의 자리로 반올림 --> 100

-- 3-2) 올림 함수
-- ceil(값) : 정수로 올림
-- 자릿수 조정을 계산을 통해서 처리한다
SELECT CEIL(123.4567) FROM DUAL; --> 124

-- (1) 소수 자릿수 2자리로 올림
-- 100(10의 2제곱)을 곱한다 -> ceil() 처리한다 -> 100으로 나눈다
SELECT CEIL(123.4567 * 100) / 100 FROM DUAL; --> 123.46

-- (2) 소수 자릿수 1자리로 올림
-- 10(10의 제곱)을 곱한다 -> ceil() 처리한다 -> 10으로 나눈다
SELECT CEIL(123.4567 * 10) / 10 FROM DUAL; --> 12.5

-- (3) 십의 자리로 올림
-- 10의 -1제곱을 곱한다(10분의 1 = 0.1) -> ceil() 처리한다 -> 10의 -1제곱으로 나눈다
SELECT CEIL(123.4567 * 0.1) / 0.1 FROM DUAL; --> 130

-- (4) 백의 자리로 올림
-- 10의 -2제곱을 곱한다(100분의 1 = 0.01) -> ceil() 처리한다 -> 100의 -2제곱으로 나눈다
SELECT CEIL(123.4567 * 0.01 ) / 0.01 FROM DUAL; --> 200

-- 3-3) 내림 함수
-- floor(값) : 정수로 내림
-- ceil()와 같은 방식으로 사용한다
SELECT FLOOR(567.8989 * 100) / 100 FROM DUAL; --> 567.89
SELECT FLOOR(567.8989 * 10) / 10 FROM DUAL; --> 567.8
SELECT FLOOR(567.8989 * 1) / 1 FROM DUAL; --> 567 
SELECT FLOOR(567.8989 * 0.1) / 0.1 FROM DUAL; --> 560
SELECT FLOOR(567.8989 * 0.01) / 0.01 FROM DUAL; --> 500

-- 3-4) 결사 함수
-- trunc(값, 자릿수)
SELECT TRUNC(567.8989, 2) FROM DUAL; -- 소수 자릿수 2자리로 결사 --> 567.89
SELECT TRUNC(567.8989, 1) FROM DUAL; -- 소수 자릿수 1자리로 결사 --> 567.8
SELECT TRUNC(567.8989, 0) FROM DUAL; -- 정수로 결사 --> 567
SELECT TRUNC(567.8989) FROM DUAL; -- 정수로 결사(0은 생략가능) --> 567
SELECT TRUNC(567.8989, -1) FROM DUAL; -- 십의 자리로 결사 --> 560
SELECT TRUNC(567.8989, -2) FROM DUAL; -- 백의 자리로 결사 --> 500

-- 내림과 결사의 차이는 있다
-- 결과는 같아도 음수에서 차이가 발생한다
SELECT FLOOR(-1.5) FROM DUAL; --> -2
SELECT TRUNC(-1.5) FROM DUAL; --> -1
-- floor은 계산해서 -1.5보다 더 작은 정수를 출력한다
-- trunc는 소수점 이하를 무조건 자르고 출력한다

-- 3-5) 절대값
-- abs(값)
SELECT ABS(-5) FROM DUAL; --> 5

-- 3-6) 부호 판별
-- sign(값)
-- 값이 양수이면 1
-- 값이 음수이면 -1
-- 값이 0이면 0
SELECT SIGN(5) FROM DUAL; --> 1
SELECT SIGN(-5) FROM DUAL; --> -1
SELECT SIGN(0) FROM DUAL; --> 0

-- 3-7) 나머지
-- mod(A, B) : A를 B로 나눈 나머지
SELECT MOD(7, 2) FROM DUAL; --> 1

-- 3-8) 제곱
-- power(A, B) : A의 B제곱
SELECT POWER(10, 2) FROM DUAL; --> 100
SELECT POWER(10, 1) FROM DUAL; --> 10
SELECT POWER(10, 0) FROM DUAL; --> 1
SELECT POWER(10, -1) FROM DUAL; --> 0.1
SELECT POWER(10, -2) FROM DUAL; --> 0.01



-- 4. 날짜 함수
-- 4-1) 현재 날짜
-- sysdate
SELECT SYSDATE FROM DUAL;

-- 4-2) 현재 날짜(타입이 timestamp)
-- systimestamp
SELECT SYSTIMESTAMP FROM DUAL;

-- 4-3) 년/월/일/시/분/초/ 추출
-- extract(단위 from 날짜)
SELECT EXTRACT(YEAR FROM SYSDATE) AS 현재년도,
           EXTRACT(MONTH FROM SYSDATE) AS 현재월,
           EXTRACT(DAY FROM SYSDATE) AS 현재일,
           EXTRACT(HOUR FROM SYSTIMESTAMP) AS 현재시,
           EXTRACT(MINUTE FROM SYSTIMESTAMP) AS 현재분,
           EXTRACT(SECOND FROM SYSTIMESTAMP) AS 현재초
FROM DUAL;

-- 4-4) 날짜 연산(이전, 이후)
-- 1일 : 숫자 1
-- 12시간 : 숫자 0.5
SELECT SYSDATE+1 AS 내일,
         SYSDATE -1 AS 어제,
         SYSDATE + 0.5 AS 열두시간후,
         SYSTIMESTAMP + 0.5 AS 열두시간후
FROM DUAL;

-- 4-5) 개월 연산
-- add_months(날짜, N) : N개월 후
SELECT ADD_MONTHS(SYSDATE, 3) AS 삼개월후,
         ADD_MONTHS(SYSDATE, -3) AS 삼개월전
FROM DUAL;
-- months_between(날짜1, 날짜2) : 두 날짜 사이 경과한 개월수(날짜1-날짜2)
-- months_between(최근날짜, 이전날짜)
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-01-01')) FROM DUAL;
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-01-01'))) FROM DUAL;



-- 5. 형 변환 함수
-- 5-1) 날짜 변환 함수
-- to_date(문자열, [형식])
-- 형식
-- YYYY, YY
-- MM, M
-- DD, D
-- HH, H
-- MI
-- SS
SELECT TO_DATE('2021-04-01'),
         TO_DATE('2021/04/01'),
         TO_DATE('2021/01/04', 'yyyy/dd/mm'), -- 전달할 형식에 따라 다르다
         TO_DATE('20210401', 'yyyymmdd'),
         TO_DATE('0401, 21', 'mmdd, yy')
FROM DUAL;

-- 5-2) 숫자 변환 함수
-- to_number(문자열)
SELECT TO_NUMBER('100') FROM DUAL;

SELECT NAME, KOR
   FROM SCORE
   WHERE KOR >= '50'; -- 내부적으로 where kor >= to_number('50') 처리된다
   
-- 5-3) 문자열 변환 함수
-- to_char(값, [형식])
-- (1) 숫자 형식
SELECT TO_CHAR(123), -- 문자열 123
          TO_CHAR(123, '999999'), -- 문자열 '   123' (공백 3개)
          TO_CHAR(123, '000000'), -- 문자열 '000123'
          TO_CHAR(1234, '9,999'), -- 문자열 천 단위 구분 기호로 표시
          TO_CHAR(12345, '9,999'), -- ##### (자릿수가 안 맞아서 뜨는 오류, 형식이 숫자보다 작은 경우)
          TO_CHAR(12345, '99,999'), -- 12,345
          TO_CHAR(3.14, '9.999'), -- 3.140 (.)으로 표시
          TO_CHAR(3.14, '9.99'), -- 3.14
          TO_CHAR(3.14, '9.9'), -- 3.1
          TO_CHAR(3.14, '9'), -- 3
          TO_CHAR(3.5, '9') -- 4 (반올림)
   FROM DUAL; 

-- (2) 날짜 형식
SELECT TO_CHAR(SYSDATE, 'yyyy.mm.dd'),
          TO_CHAR(SYSDATE, 'year month day'),
          TO_CHAR(SYSDATE, 'hh:mi:ss')
   FROM DUAL;



-- 6. 기타 함수
-- 6-1) null 처리 함수
-- (1) nvl(값, 값이 null일때 사용할 값)
SELECT KOR,
           NVL(KOR, 0)
    FROM SCORE; -- nvl(kor, 0) : null 대신 0을 사용
    
-- 집계함수(sum, avg, max, min, count 등)들은 null 값을 무시한다
SELECT AVG(KOR) AS 평균1,
           AVG(NVL(KOR, 0)) AS 평균2
    FROM SCORE;
    
SELECT NVL(KOR, 0)+ENG+MAT AS 총점 FROM SCORE;

-- (2) nvl2(값, 값이 null이 아닐때, 값이 null일때)
SELECT NVL2(KOR, KOR+ENG+MAT, ENG+MAT) AS 총점 FROM SCORE;

-- 6-2) 분기 함수
-- decode(표현식, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
-- 동등비교만 가능
SELECT DECODE('가을', -- 표현식 : 칼럼을 이용한 식(없을땐 직접 바꿔서 진행..)
                    '봄', '꽃놀이', -- 표현식이 '봄' 이면 '꽃놀이'가 결과
                    '여름', '물놀이',
                    '가을', '단풍놀이',
                    '겨울', '눈싸움') AS 계절별놀이
    FROM DUAL;
    
-- 6-3) 분기 표현식
-- case 표현식
--   when 비교식 then 결과값
--   ...
--   else 나머지 경우
-- end ;

-- case
--   when 조건식 then 결과값
--   ...
--   else 나머지경우
-- end

-- case 평균
--   when >= 90 then 'A학점'

SELECT NAME,
         (NVL(KOR, 0)+ENG+MAT) / 3 AS 평균,
         (CASE 
                WHEN (NVL(KOR, 0)+ENG+MAT) / 3 >=90 THEN 'A학점'
                WHEN (NVL(KOR, 0)+ENG+MAT) / 3 >=80 THEN 'B학점'
                WHEN (NVL(KOR, 0)+ENG+MAT) / 3 >=70 THEN 'C학점'
                WHEN (NVL(KOR, 0)+ENG+MAT) / 3 >=60 THEN 'D학점'
                ELSE 'F학점'
          END) AS 학점
    FROM SCORE;




