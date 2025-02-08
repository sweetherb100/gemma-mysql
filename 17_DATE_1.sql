/*
사용자(user_id)의 2024년 중 마지막 로그인(last_stamp)을 조회하는 SQL 쿼리를 작성합니다.
2024년에 로그인하지 않은 사용자는 포함하지 않습니다.
*/

# [SETTING]
USE practice;
DROP TABLE logins;
CREATE TABLE logins
(
    user_id    INT,
    time_stamp TIMESTAMP
);
INSERT INTO logins
    (user_id, time_stamp)
VALUES (6, '2024-06-30 15:06:07'),
    (6, '2025-04-21 14:06:06'),
    (6, '2023-03-07 00:18:15'),
    (8, '2024-02-01 05:10:53'),
    (8, '2024-12-31 07:46:50'),
    (2, '2024-01-16 02:49:50'),
    (2, '2023-08-25 07:59:08'),
    (14, '2023-07-14 09:00:00'),
    (14, '2025-01-06 11:59:59');
SELECT *
FROM logins; 

# [코드 17-1] DATE 문제 1 TIMESTAMP 예제 코드
SELECT TIMESTAMP('2024-12-31') AS time_stamp; 

# [코드 17-2] DATE 문제 1 최종 코드
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM logins
WHERE '2024-01-01' <= time_stamp
AND time_stamp < '2025-01-01'
/* WHERE time_stamp BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' 동일 */
GROUP BY user_id; 

# [코드 17-3] DATE 문제 1 최종 코드
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM logins
WHERE YEAR(time_stamp) = 2024
GROUP BY user_id; 

# [코드 17-4] DATE 문제 1 오답 코드
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM logins
WHERE '2024-01-01' <= time_stamp
AND time_stamp <= '2024-12-31'
GROUP BY user_id; 