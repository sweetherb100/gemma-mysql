/*
가장 수익이 높은 회사(company_name) 3개와 그 수익을 조회하는 SQL 쿼리를 작성합니다.
profit을 기준으로 내림차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE forbes_global;
CREATE TABLE forbes_global (
    company_name VARCHAR(255),
    profit FLOAT,
    PRIMARY KEY (company_name)
);
INSERT INTO forbes_global
	(company_name, profit)
VALUES ('Agricultural Bank of China', 27.0),
	('Bank of China', 25.5),
	('Berkshire Hathaway', 19.5),
	('China Construction Bank', 34.2),
	('Exxon Mobil', 32.6),
    ('General Electric', 14.8),
    ('ICBC', 42.7),
	('JPMorgan Chase', 17.3),
	('Wells Fargo', 21.9);
SELECT *
FROM forbes_global;

# [코드 11-1] LIMIT 문제 1 중간 코드
SELECT
    company_name,
    profit
FROM forbes_global
ORDER BY profit DESC;

# [코드 11-2] LIMIT 문제 1 최종 코드
SELECT
    company_name,
    profit
FROM forbes_global
ORDER BY profit DESC
LIMIT 3; 