/*
2024년 7월 27일까지 30일 동안의 일일(day) 활성 사용자 수(active_user_count)를 조회하는 SQL 쿼리를 작성합니다.
사용자가 해당 날짜에 하나 이상의 활동을 수행했으면 활성 사용자라고 할 수 있습니다.
*/

# [SETTING]
USE practice;
DROP TABLE activity;
CREATE TABLE activity
(
    user_id       INT,
    activity_date DATE,
    activity_type ENUM ('open_session', 'end_session', 'scroll_down', 'send_message')
);
INSERT INTO activity
    (user_id, activity_date, activity_type)
VALUES (1, '2024-07-20', 'open_session'),
    (1, '2024-07-20', 'scroll_down'),
    (1, '2024-07-20', 'end_session'),
    (2, '2024-07-20', 'open_session'),
    (2, '2024-07-21', 'send_message'),
    (2, '2024-07-21', 'end_session'),
    (3, '2024-07-21', 'open_session'),
    (3, '2024-07-21', 'send_message'),
    (3, '2024-07-21', 'end_session'),
    (4, '2024-06-27', 'open_session'),
    (4, '2024-06-27', 'end_session');
SELECT *
FROM activity; 

# [코드 17-5] DATE 문제 2 중간 코드
SELECT
    '2024-07-27' AS dt,
    DATE_SUB('2024-07-27', INTERVAL 30 DAY) AS dt_sub,
    DATE_ADD('2024-07-27', INTERVAL 30 DAY) AS dt_add;

# [코드 17-6] DATE 문제 2 중간 코드
SELECT activity_date
FROM activity
WHERE DATE_SUB('2024-07-27', INTERVAL 30 DAY) < activity_date
	AND activity_date <= '2024-07-27'
ORDER BY activity_date;

# [코드 17-7] DATE 문제 2 최종 코드
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_user_count
FROM activity
WHERE DATE_SUB('2024-07-27', INTERVAL 30 DAY) < activity_date
	AND activity_date <= '2024-07-27'
GROUP BY activity_date;

# [코드 17-8] DATE 문제 2 오답 코드
SELECT
    '2024-07-27' AS dt,
    '2024-07-27' - 30 AS dt_sub,
    '2024-07-27' + 30 AS dt_add;