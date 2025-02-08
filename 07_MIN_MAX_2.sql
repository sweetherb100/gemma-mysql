/*
[질문]
각 플레이어(player_id)가 처음 로그인한 장치(first_login_device)를 조회하는 SQL 쿼리를 작성합니다.
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
    (player_id,event_date, device_id, games_played)
VALUES (1, '2024-05-02', 2, 6),
	(1, '2024-03-01', 2, 5),
    (2, '2025-06-25', 3, 1),
    (3, '2025-07-03', 4, 5),
    (3, '2024-03-02', 1, 0);
SELECT *
FROM activity; 

# [코드 7-2] MIN, MAX 문제 2 중간 코드
SELECT
    player_id,
    MIN(event_date) AS first_login_date
FROM activity
GROUP BY player_id;

# [코드 7-3] MIN, MAX 문제 2 최종 코드
SELECT
    a.player_id,
    a.device_id AS first_login_device
FROM activity AS a
INNER JOIN (
	SELECT
		player_id,
		MIN(event_date) AS first_login_date
	FROM activity
	GROUP BY player_id
) aa
ON a.player_id = aa.player_id
    AND a.event_date = aa.first_login_date;

# [코드 7-4] MIN, MAX 문제 2 중간 코드
SELECT
    player_id,
    event_date,
    device_id,
    RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
FROM activity
ORDER BY player_id, event_date; 

# [코드 7-5] MIN, MAX 문제 2 최종 코드
SELECT
    player_id,
    device_id AS first_login_device
FROM (
	SELECT
	  player_id,
	  device_id,
	  RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
	FROM activity
) AS a
WHERE rk = 1; 
