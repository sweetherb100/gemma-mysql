/*
[질문]
각 플레이어(player_id)의 첫 번째 로그인 날짜(first_login_date)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE activity;
CREATE TABLE activity
(
    player_id    INT,
    event_date   DATE,
    device_id    INT,
    games_played INT,
    PRIMARY KEY(player_id, event_date)
);
INSERT INTO activity
    (player_id, event_date, device_id, games_played)
VALUES (1, '2024-05-02', 2, 6),
	(1, '2024-03-01', 2, 5),
    (2, '2025-06-25', 3, 1),
    (3, '2025-07-03', 4, 5),
    (3, '2024-03-02', 1, 0);
SELECT *
FROM activity; 

# [코드 7-1] MIN, MAX 문제 1최종 코드
SELECT
    player_id,
    MIN(event_date) AS first_login_date
FROM activity
GROUP BY player_id;