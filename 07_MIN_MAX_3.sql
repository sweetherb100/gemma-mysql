/*
[질문]
제품이 판매된 첫해에 대한 제품 ID(product_id), 연도(first_year), 수량(quantity), 가격(price)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE sales;
CREATE TABLE sales
(
    sale_id    INT,
    product_id INT,
    year       INT,
    quantity   INT,
    price      INT,
    PRIMARY KEY (sale_id)
);
INSERT INTO sales (sale_id, product_id, year, quantity, price)
VALUES (1, 100, 2022, 10, 5000),
    (2, 100, 2023, 12, 5000),
    (7, 200, 2025, 15, 9000);
SELECT *
FROM sales;

# [코드 7-6] MIN, MAX 문제 3 중간 코드
SELECT
    product_id,
    MIN(year) AS min_year
FROM sales
GROUP BY product_id; 

# [코드 7-7] MIN, MAX 문제 3 최종 코드
SELECT
    s.product_id,
    s.year,
    s.quantity,
    s.price
FROM sales AS s
INNER JOIN (
	SELECT
		product_id,
		MIN(year) AS min_year
	FROM sales
	GROUP BY product_id
) AS ss
ON s.product_id = ss.product_id
    AND s.year = ss.min_year; 

# [코드 7-8] MIN, MAX 문제 3 중간 코드
SELECT
    product_id,
    year,
    quantity,
    price,
    RANK() OVER (PARTITION BY product_id ORDER BY year) AS rk
FROM sales
ORDER BY product_id, year; 

# [코드 7-9] MIN, MAX 문제 3 최종 코드
SELECT
    product_id,
    year,
    quantity,
    price
FROM (
	SELECT
		product_id,
		year,
		quantity,
		price,
		RANK() OVER (PARTITION BY product_id ORDER BY year) AS rk
	FROM sales
) AS a
WHERE rk = 1; 
