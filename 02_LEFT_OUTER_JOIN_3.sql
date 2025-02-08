/*
[질문]
각 제품(product_id)의 평균 판매 가격(average_price)을 조회하는 SQL 쿼리를 작성합니다. 평균 판매 가격은 소수점 이하 2자리로 반올림합니다.
*/

# [SETTING]
USE practice;
DROP TABLE prices;
CREATE TABLE prices
(
    product_id INT,
    start_date DATE,
    end_date   DATE,
    price      INT,
    PRIMARY KEY(product_id, start_date, end_date)
);
INSERT INTO prices
    (product_id, start_date, end_date, price)
VALUES (1, '2025-02-17', '2025-02-28', 5),
    (1, '2025-03-01', '2025-03-22', 20),
    (2, '2025-02-01', '2025-02-20', 15),
    (2, '2025-02-21', '2025-03-31', 30),
    (3, '2025-02-21', '2025-03-31', 30);
SELECT *
FROM prices;

# [SETTING]
USE practice;
DROP TABLE units_sold;
CREATE TABLE units_sold
(
    product_id    INT,
    purchase_date DATE,
    units         INT,
    PRIMARY KEY(product_id, purchase_date)
);
INSERT INTO units_sold
    (product_id, purchase_date, units)
VALUES (1, '2025-02-25', 100),
    (1, '2025-03-01', 15),
    (2, '2025-02-10', 200),
    (2, '2025-03-22', 30);
SELECT *
FROM units_sold; 

# [코드 2-11] LEFT OUTER JOIN 문제 3 중간 코드
SELECT
	p.start_date,
	p.end_date,
    p.price,
	p.product_id,
	u.product_id,
	u.purchase_date,
	u.units
FROM prices AS p
LEFT OUTER JOIN units_sold AS u
ON p.product_id = u.product_id
ORDER BY p.product_id, p.start_date, u.purchase_date;

# [코드 2-12] LEFT OUTER JOIN 문제 3 중간 코드
SELECT
	p.start_date,
	p.end_date,
	p.price,
	p.product_id,
	u.product_id,
	u.purchase_date,
	u.units
FROM prices AS p
LEFT OUTER JOIN units_sold AS u
ON p.product_id = u.product_id
    AND p.start_date <= u.purchase_date 
    AND u.purchase_date <= p.end_date;
/* AND u.purchase_date BETWEEN p.start_date AND p.end_date 동일 */

# [코드 2-13] LEFT OUTER JOIN 문제 3 최종 코드
SELECT
    p.product_id,
    IFNULL(ROUND(SUM(u.units * p.price) / SUM(u.units), 2), 0) AS average_price
FROM prices AS p
LEFT OUTER JOIN units_sold AS u
ON p.product_id = u.product_id
    AND p.start_date <= u.purchase_date
    AND u.purchase_date <= p.end_date 
GROUP BY p.product_id;

# [코드 2-14] LEFT OUTER JOIN 문제 3 오답 코드
SELECT
	p.start_date,
	p.end_date,
	p.price,
	p.product_id,
	u.product_id,
	u.purchase_date,
	u.units
FROM prices AS p
LEFT OUTER JOIN units_sold AS u
ON p.product_id = u.product_id
WHERE p.start_date <= u.purchase_date
  AND u.purchase_date <= p.end_date; 