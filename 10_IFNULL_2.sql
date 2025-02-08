/*
[질문]
각 사용자(buyer_id)의 가입 날짜(join_date)와 2025년에 구매한 주문 수(orders_in_2025)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE users;
CREATE TABLE users
(
    user_id        INT,
    join_date      DATE,
    favorite_item_id INT,
    PRIMARY KEY(user_id)
);
INSERT INTO users
    (user_id, join_date, favorite_item_id)
VALUES (1, '2024-01-01', 2),
    (2, '2024-02-09', 1),
    (3, '2024-01-19', 3),
    (4, '2024-05-21', 4);
SELECT *
FROM users; 

# [SETTING]
USE practice;
DROP TABLE orders;
CREATE TABLE orders
(
    order_id   INT,
    order_date DATE,
    item_id    INT,
    buyer_id   INT,
    seller_id  INT,
    PRIMARY KEY(order_id)
);
INSERT INTO orders
    (order_id, order_date, item_id, buyer_id, seller_id)
VALUES (1, '2025-08-01', 4, 1, 2),
    (2, '2024-08-02', 2, 1, 3),
    (3, '2025-08-03', 3, 2, 3),
    (4, '2024-08-04', 1, 4, 2),
    (5, '2024-08-04', 1, 3, 4),
    (6, '2025-08-05', 2, 2, 4);
SELECT *
FROM orders;

# [코드 10-8] IFNULL 문제 2 중간 코드
SELECT
    order_date,
    DATE_FORMAT(order_date, '%Y') AS order_year1,
    YEAR(order_date) AS order_year2,
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    MONTH(order_date) AS order_month
FROM orders; 

# [코드 10-9] IFNULL 문제 2 중간 코드
SELECT
    buyer_id,
    COUNT(*) AS orders_in_2025
FROM orders
WHERE DATE_FORMAT(order_date, '%Y') = '2025'
GROUP BY buyer_id; 

# [코드 10-10] IFNULL 문제 2 중간 코드
SELECT
    u.join_date,
    u.user_id,
    o.buyer_id,
    o.orders_in_2025
FROM users AS u
LEFT OUTER JOIN (
	SELECT
		buyer_id,
		COUNT(*) AS orders_in_2025
	FROM orders
	WHERE DATE_FORMAT(order_date, '%Y') = '2025'
	GROUP BY buyer_id
) AS o
ON u.user_id = o.buyer_id;

# [코드 10-11] IFNULL 문제 2 최종 코드
SELECT
    u.user_id AS buyer_id,
    u.join_date,
    IFNULL(o.orders_in_2025, 0) AS orders_in_2025
FROM users AS u
LEFT OUTER JOIN (
	SELECT
		buyer_id,
		COUNT(*) AS orders_in_2025
	FROM orders
	WHERE DATE_FORMAT(order_date, '%Y') = '2025'
	GROUP BY buyer_id
) AS o
ON u.user_id = o.buyer_id; 

# [코드 10-12] IFNULL 문제 2 중간 코드
SELECT
	u.join_date,
	u.user_id,
	o.buyer_id,
	o.order_date,
	o.order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.buyer_id
	AND YEAR(o.order_date) = 2025;

# [코드 10-13] IFNULL 문제 2 최종 코드
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2025
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.buyer_id
	AND YEAR(o.order_date) = 2025
GROUP BY u.user_id, u.join_date;