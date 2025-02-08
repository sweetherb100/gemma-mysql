/*
[질문]
고객이 원하는 배송 날짜(customer_pref_delivery_date)가 주문 날짜(order_date)와 동일한 경우 immediate라고 하고, 그렇지 않으면 scheduled라고 합니다.
immediate 주문의 백분율을 조회하는 SQL 쿼리를 작성합니다.
백분율은 소수점 이하 2자리로 반올림합니다.
*/

# [SETTING]
USE practice;
DROP TABLE delivery;
CREATE TABLE delivery
(
    delivery_id                 INT,
    customer_id                 INT,
    order_date                  DATE,
    customer_pref_delivery_date DATE,
    PRIMARY KEY(delivery_id)
);
INSERT INTO delivery
    (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES (1, 1, '2024-08-01', '2024-08-02'),
    (2, 5, '2024-08-02', '2024-08-02'),
    (3, 1, '2024-08-11', '2024-08-11'),
    (4, 3, '2024-08-24', '2024-08-26'),
    (5, 4, '2024-08-21', '2024-08-22'),
    (6, 2, '2024-08-11', '2024-08-13');
SELECT *
FROM delivery; 

# [코드 8-1] SUM, COUNT 문제 1 중간 코드
SELECT
    SUM(CASE
			WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0
		END) AS sum_case
FROM delivery; 

# [코드 8-2] SUM, COUNT 문제 1 최종 코드
SELECT
    ROUND((SUM(CASE WHEN order_date = customer_pref_delivery_date
            THEN 1 ELSE 0 END) / COUNT(*) * 100), 2) AS immediate_percentage
FROM delivery; 

# [코드 8-3] SUM, COUNT 문제 1 중간 코드
SELECT
    COUNT(CASE
			WHEN order_date = customer_pref_delivery_date THEN 1
		END) AS count_case
FROM delivery; 

# [코드 8-4] SUM, COUNT 문제 1 최종 코드
SELECT
    ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date 
            THEN 1 END) / COUNT(*) * 100), 2) AS immediate_percentage
FROM delivery; 

# [코드 8-5] SUM, COUNT 문제 1 최종 코드
SELECT
	ROUND((SELECT COUNT(*) FROM delivery WHERE order_date = customer_pref_delivery_date)
    / (SELECT COUNT(*) FROM delivery) * 100, 2) AS immediate_percentage;
    
# [코드 8-6] SUM, COUNT 문제 1 오답 코드
SELECT
    ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date
            THEN 1 ELSE 0 END) / COUNT(*) * 100), 2) AS immediate_percentage
FROM delivery;