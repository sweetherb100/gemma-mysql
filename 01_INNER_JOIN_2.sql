/*
[질문]
2025년 2월에 100개 이상 주문한 제품 이름(product_name)과 수량(unit)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE products;
CREATE TABLE products
(
    product_id       INT,
    product_name     VARCHAR(40),
    product_category VARCHAR(40),
    PRIMARY KEY(product_id)
);
INSERT INTO products (product_id, product_name, product_category)
VALUES (1, 'MySQL Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
    (3, 'HP', 'Laptop'),
    (4, 'Lenovo', 'Laptop'),
    (5, 'MySQL Kit', 'T-shirt');
SELECT *
FROM products;

# [SETTING]
USE practice;
DROP TABLE orders;
CREATE TABLE orders
(
    product_id INT,
    order_date DATE,
    unit       INT,
    PRIMARY KEY(product_id, order_date)
);
INSERT INTO orders (product_id, order_date, unit)
VALUES (1, '2025-02-05', 60),
    (1, '2025-02-10', 70),
    (2, '2025-01-18', 30),
    (2, '2025-02-11', 80),
    (3, '2025-02-17', 2),
    (3, '2025-02-24', 3),
    (4, '2025-03-01', 20),
    (4, '2025-03-04', 30),
    (4, '2025-03-07', 60),
    (5, '2025-02-25', 50),
    (5, '2025-02-27', 50),
    (5, '2025-03-01', 50);
SELECT *
FROM orders;

# [코드 1-3] INNER JOIN 문제 2 중간 코드
SELECT
    product_id,
    SUM(unit) AS unit
FROM orders
WHERE DATE_FORMAT(order_date, '%Y-%m') = '2025-02'
GROUP BY product_id
HAVING SUM(unit) >= 100;

# [코드 1-4] INNER JOIN 문제 2 최종 코드
SELECT
    p.product_name,
    o.unit
FROM (
	SELECT
		product_id,
		SUM(unit) AS unit
	FROM orders
	WHERE DATE_FORMAT(order_date, '%Y-%m') = '2025-02'
	GROUP BY product_id
	HAVING SUM(unit) >= 100
) AS o
INNER JOIN products AS p
ON o.product_id = p.product_id;

# [코드 1-5] 직접 테이블명을 사용하여 조인 코드
SELECT *
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id;

# [코드 1-6] 서브 쿼리를 사용하여 조인 코드
SELECT *
FROM (
   SELECT *
   FROM products
) AS p
INNER JOIN (
   SELECT *
   FROM orders
) AS o
ON p.product_id = o.product_id;