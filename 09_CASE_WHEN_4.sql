/*
[질문]
각 소득 카테고리(category)의 은행 계좌 수(accounts_count)를 조회하는 SQL 쿼리를 작성합니다.
결과에 세 가지 카테고리가 모두 포함되어야 합니다.
카테고리에 계좌(account_id)가 없으면 0을 보고합니다. 소득 카테고리는 다음과 같습니다.
- 'Low Salary': 소득(income)가 $20000 미만입니다.
- 'Average Salary': 소득(income)가 $[20000, 50000] 사이입니다.
- 'High Salary': 소득(income)이 $50000보다 큽니다.
*/

# [SETTING]
USE practice;
DROP TABLE accounts;
CREATE TABLE accounts
(
    account_id INT,
    income     INT,
    PRIMARY KEY(account_id)
);
INSERT INTO accounts
    (account_id, income)
VALUES (2, 12747),
	(3, 108939),
    (8, 87709),
    (6, 91796);
SELECT *
FROM accounts; 

# [코드 9-15] CASE WHEN 문제 4 중간 코드
SELECT
    'Low Salary' AS category,
    COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM accounts;

# [코드 9-16] CASE WHEN 문제 4 최종 코드
SELECT
    'Low Salary' AS category,
    COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM accounts

UNION

SELECT
    'Average Salary' AS category,
    COUNT(CASE WHEN 20000 <= income AND income <= 50000 THEN 1 END) AS accounts_count
FROM accounts

UNION

SELECT
    'High Salary' AS category,
    COUNT(CASE WHEN income > 50000 THEN 1 END) AS accounts_count
FROM accounts; 

