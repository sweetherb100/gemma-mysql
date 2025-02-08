/*
[질문]
product 테이블의 모든 제품(product_id)을 구매한 고객 ID(customer_id)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE customer;
CREATE TABLE customer
(
    customer_id INT,
    product_id INT
);
INSERT INTO customer
    (customer_id, product_id)
VALUES (1, 5),
    (1, 6),
    (2, 6),
    (3, 5),
    (3, 6);
SELECT *
FROM customer; 

# [SETTING]
USE practice;
DROP TABLE product;
CREATE TABLE product
(
    product_id INT,
    PRIMARY KEY(product_id)
);
INSERT INTO product
    (product_id)
VALUES (5),
    (6);
SELECT *
FROM product; 

# [코드 6-10] HAVING 문제 4 중간 코드
SELECT
  COUNT(product_id)
FROM product;

# [코드 6-11] HAVING 문제 4 최종 코드
SELECT
    customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) =
(
	SELECT
		COUNT(product_id)
	FROM product
);
