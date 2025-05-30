/*
ID가 2인 고객(referee_id)이 추천하지 않은 고객(customer_id)의 이름(name)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE customer;
CREATE TABLE customer
(
    customer_id   INT,
    name          VARCHAR(255),
    referee_id    INT,
    PRIMARY KEY (customer_id)
);
INSERT INTO customer
    (customer_id, name, referee_id)
VALUES (1, 'Will', NULL),
    (2, 'Jane', NULL),
    (3, 'Alex', 2),
    (4, 'Bill', NULL),
    (5, 'Zack', 1),
    (6, 'Mark', 2);
SELECT *
FROM customer; 

# [코드 12-1] NOT IN 문제 1 중간 코드
SELECT
	customer_id,
	name
FROM customer
WHERE referee_id = 2;

# [코드 12-2] NOT IN 문제 1 최종 코드
SELECT
    name
FROM customer
WHERE customer_id NOT IN
(
	SELECT
		customer_id
	FROM customer
	WHERE referee_id = 2
); 

# [코드 12-3] NOT IN 문제 1 오답 코드
SELECT
    name
FROM customer
WHERE referee_id != 2; 

# [코드 12-4] NOT IN 문제 1 최종 코드
SELECT
    name
FROM customer
WHERE referee_id != 2
	OR referee_id IS NULL; 

# [코드 12-5] NOT IN의 옳은 사용법 코드
SELECT
    customer_id
FROM customer
WHERE customer_id NOT IN (1);

# [코드 12-6] NOT IN의 잘못된 사용법1 코드
SELECT
    customer_id
FROM customer
WHERE customer_id NOT IN (1, NULL);

# [코드 12-7] NOT IN의 잘못된 사용법2 코드
SELECT
    customer_id,
    referee_id
FROM customer
WHERE customer_id NOT IN (referee_id);