/*
[질문]
각 주식(stock_name)에 대해 이득, 손실 금액(capital_gain_loss)을 조회하는 SQL 쿼리를 작성합니다.
여기서 주식의 이득, 손실이란 주식을 매매한 후의 총이익 또는 총손실입니다.
단, 이득, 손실 가격(price)는 하나의 칼럼이며, 매도한 경우 이득 값, 매수한 경우 손실 값을 저장합니다.
*/

# [SETTING]
USE practice;
DROP TABLE stocks;
CREATE TABLE stocks
(
    stock_name    VARCHAR(15),
    operation_day INT,
    operation     ENUM ('Sell', 'Buy'),
    price         INT,
    PRIMARY KEY(stock_name, operation_day)
);
INSERT INTO stocks
    (stock_name, operation_day, operation, price)
VALUES ('Apple', 1, 'Buy', 1000),
    ('Tesla', 2, 'Buy', 10),
    ('Tesla', 3, 'Sell', 1010),
    ('Tesla', 4, 'Buy', 1000),
    ('Apple', 5, 'Sell', 9000),
    ('Tesla', 5, 'Sell', 500),
    ('Tesla', 6, 'Buy', 1000),
    ('Tesla', 10,  'Sell', 10000),
    ('Nvidia', 17, 'Buy', 30000),
    ('Nvidia', 29, 'Sell', 7000);
SELECT *
FROM stocks; 

# [코드 9-12] CASE WHEN 문제 3 중간 코드
SELECT
    stock_name,
    operation_day,
    operation,
    price,
    CASE
		WHEN operation = 'Buy' THEN -price
	END AS minus_price,
    CASE
		WHEN operation = 'Sell' THEN price
	END AS plus_price,
    CASE
		WHEN operation = 'Buy' THEN -price
        WHEN operation = 'Sell' THEN price
	END as final_price
FROM stocks
ORDER BY operation_day;

# [코드 9-13] CASE WHEN 문제 3 중간 코드
SELECT
    stock_name,
    SUM(CASE WHEN operation = 'Buy' THEN -price END) AS buy_loss,
    SUM(CASE WHEN operation = 'Sell' THEN price END) AS sell_gain
FROM stocks
GROUP BY stock_name;

# [코드 9-14] CASE WHEN 문제 3 최종 코드
SELECT
    stock_name,
    SUM(CASE
			WHEN operation = 'Buy' THEN -price
			WHEN operation = 'Sell' THEN price
		END) AS capital_gain_loss
FROM stocks
GROUP BY stock_name; 