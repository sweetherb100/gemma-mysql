/*
거래 없이 방문한 사용자의 ID(customer_id)와 이러한 유형의 방문 횟수(no_trans_count)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE visits;
CREATE TABLE visits
(
    visit_id    INT,
    customer_id INT,
    PRIMARY KEY (visit_id)
);
INSERT INTO visits
    (visit_id, customer_id)
VALUES (1, 23),
    (2, 9),
    (4, 30),
    (5, 54),
    (6, 96),
    (7, 54),
    (8, 54);
SELECT *
FROM visits; 

# [SETTING]
USE practice;
DROP TABLE transactions;
CREATE TABLE transactions
(
    transaction_id INT,
    visit_id       INT,
    amount         INT,
    PRIMARY KEY (transaction_id)
);
INSERT INTO transactions
    (transaction_id, visit_id, amount)
VALUES (2, 5, 310),
    (3, 5, 300),
    (9, 5, 200),
    (12, 1, 910),
    (13, 2, 970);
SELECT *
FROM transactions; 

# [코드 12-11] NOT IN 문제 3 중간 코드
SELECT
	visit_id
FROM transactions;

# [코드 12-12] NOT IN 문제 3 중간 코드
SELECT *
FROM visits
WHERE visit_id NOT IN
(
	SELECT
		visit_id
	FROM transactions
);

# [코드 12-13] NOT IN 문제 3 최종 코드
SELECT
    customer_id,
    COUNT(*) AS no_trans_count
FROM visits
WHERE visit_id NOT IN
(
	SELECT
		visit_id
	FROM transactions
)
GROUP BY customer_id;

# [코드 12-14] NOT IN 문제 3 중간 코드
SELECT
	v.customer_id,
	v.visit_id,
    t.visit_id,
    t.transaction_id
FROM visits AS v
LEFT OUTER JOIN transactions AS t
ON v.visit_id = t.visit_id;

# [코드 12-15] NOT IN 문제 3 최종 코드
SELECT
    v.customer_id,
    COUNT(*) AS no_trans_count
FROM visits AS v
LEFT OUTER JOIN transactions AS t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;