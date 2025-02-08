/*
[질문]
각 플레이어(player_id)와 날짜(event_date) 별로 해당 날짜까지 플레이어가 플레이한 총 게임 수(games_played_so_far)를 조회하는 SQL 쿼리를 작성합니다.
즉, 해당 날짜까지 플레이어가 플레이한 게임의 총합을 계산합니다.

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

# [코드 8-11] SUM, COUNT 문제 3 최종 코드
SELECT
    player_id,
    event_date,
    SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
FROM activity; 
