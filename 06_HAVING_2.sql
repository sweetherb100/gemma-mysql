/*
[질문]
단일 숫자는 my_numbers 테이블에 한 번만 나타나는 숫자입니다.
가장 큰 단일 숫자(max_num)를 조회하는 SQL 쿼리를 작성합니다.
단일 숫자가 없으면 NULL을 반환합니다.
*/

# [SETTING1]
USE practice;
DROP TABLE my_numbers;
CREATE TABLE my_numbers
(
    num INT
);
INSERT INTO my_numbers
    (num)
VALUES (8),
    (8),
    (3),
    (3),
    (1),
    (4),
    (5),
    (6);
SELECT *
FROM my_numbers; 

# [SETTING2]
USE practice;
DROP TABLE my_numbers;
CREATE TABLE my_numbers
(
    num INT
);
INSERT INTO my_numbers
    (num)
VALUES (8),
    (8),
    (7),
    (7),
    (3),
    (3),
    (3);
SELECT *
FROM my_numbers; 

# [코드 6-3] HAVING 문제 2 오답 코드
SELECT
    MAX(num)
FROM my_numbers
GROUP BY num
HAVING COUNT(num) = 1; 

# [코드 6-4] HAVING 문제 2 오답 코드
SELECT
    num,
    MAX(num)
FROM my_numbers
GROUP BY num
HAVING COUNT(num) = 1; 

# [코드 6-5] HAVING 문제 2 최종 코드
SELECT
    MAX(num) AS max_num
FROM (
	SELECT
		num
	FROM my_numbers
	GROUP BY num
	HAVING COUNT(num) = 1
) AS a; 

# [코드 6-6] 전체 테이블의 집계 함수 코드
SELECT
    COUNT(num) AS num_cnt
FROM my_numbers;