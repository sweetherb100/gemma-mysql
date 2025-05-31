/*
판매 가격(price)을 기준으로 가장 많이 판매한 판매자(seller_id)를 조회하는 SQL 쿼리를 작성합니다.
가격이 동일한 경우 모든 판매자를 반환합니다.
*/

# [SETTING]
USE practice;
DROP TABLE sales;
CREATE TABLE sales
(
    seller_id  INT,
    sale_date  DATE,
    price	   INT,
    PRIMARY KEY(seller_id, sale_date)
);
INSERT INTO sales
    (seller_id, sale_date, price)
VALUES (1, '2024-01-21', 2000),
    (1, '2024-01-17', 800),
    (2, '2024-01-02', 800),
    (3, '2024-01-13', 2800);
SELECT *
FROM sales; 	    

# [코드 15-1] ROW_NUMBER 문제 1 중간 코드
SELECT
	seller_id,
	SUM(price)
FROM sales
GROUP BY seller_id;

# [코드 15-2] ROW_NUMBER 문제 1 중간 코드
SELECT
	seller_id,
	SUM(price) AS tot_price,
	RANK() OVER (ORDER BY SUM(price) DESC) AS rk,
	DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS drk,
	ROW_NUMBER() OVER (ORDER BY SUM(price) DESC) AS rn
FROM sales
GROUP BY seller_id
ORDER BY tot_price DESC;
    
# [코드 15-3] ROW_NUMBER 문제 1 최종 코드
SELECT
    seller_id
FROM (
	SELECT
		seller_id,
		SUM(price) AS tot_price,
		RANK() OVER (ORDER BY SUM(price) DESC) AS rk,
		DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS drk
		FROM sales
		GROUP BY seller_id
) AS a
WHERE rk = 1; /* rk = 1 또는 drk = 1 정답 */

# [코드 15-4] ROW_NUMBER 문제 1 오답 코드
SELECT
    seller_id,
    tot_price
FROM (
	SELECT
		seller_id,
		SUM(price) AS tot_price,
		ROW_NUMBER() OVER (ORDER BY SUM(price) DESC) AS rn
		FROM sales
		GROUP BY seller_id
) AS a
WHERE rn = 1; /* ROW_NUMBER 오답 */