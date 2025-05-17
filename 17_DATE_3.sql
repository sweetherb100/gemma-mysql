/*
월(month)별, 국가(country)별로 거래 건수(trans_count), 거래량(trans_amount), 승인된 거래 건수(approved_count), 승인된 거래량(approved_amount)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE transactions;
CREATE TABLE transactions
(
    trans_id   INT,
    country    VARCHAR(255),
    state      ENUM ('approved', 'declined'),
    amount     INT,
    trans_date DATE,
    PRIMARY KEY(trans_id)
);
INSERT INTO transactions
    (trans_id, country, state, amount, trans_date)
VALUES (121, 'US', 'approved', 1000, '2024-12-18'),
    (122, 'US', 'declined', 2000, '2024-12-19'),
    (123, 'US', 'approved', 2000, '2025-01-01'),
    (124, 'DE', 'approved', 2000, '2025-01-07');
SELECT *
FROM transactions; 

# [코드 17-9] DATE 연도-월 포맷 코드
SELECT DATE_FORMAT('2024-12-31', '%Y-%m') AS Y_m_date;

# [코드 17-10] DATE 연도-월-일 포맷 코드
SELECT DATE_FORMAT('2024-12-31 14:30:00','%Y-%m-%d') AS Y_m_d_date;

# [코드 17-11] DATE 연도-월-일 시:분 포맷 코드
SELECT DATE_FORMAT('2024-12-31 14:30:17', '%Y-%m-%d %H:%i') AS Y_m_d_H_i_date;

# [코드 17-12] DATE 문제 3 중간 코드
SELECT
    trans_date,
    DATE_FORMAT(trans_date, '%Y-%m') AS trans_month
FROM transactions; 

# [코드 17-13] DATE 문제 3 최종 코드
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
	SUM(amount) AS trans_amount,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount
FROM transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;