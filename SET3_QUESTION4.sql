/*
[질문]
처음 로그인하고 다음 날에도 로그인한 플레이어의 비율(login_again_rate)을 조회하는 SQL 쿼리를 작성합니다.
즉, 첫 번째 로그인 날짜부터 최소 2일 연속으로 로그인한 플레이어 수를 계산한 다음 해당 숫자를 전체 플레이어 수로 나눕니다.
소수점 이하 2자리로 반올림합니다.
*/

# [SETTING]
USE practice;
DROP TABLE activity;
CREATE TABLE activity (
  player_id INT,
  event_date DATE,
  games_played INT,
  PRIMARY KEY (player_id, event_date)
);
INSERT INTO
  activity (player_id, event_date, games_played)
VALUES (1, '2024-03-01', 5),
  (1, '2024-03-02', 6),
  (1, '2025-01-01', 5),
  (1, '2025-01-02', 6),
  (2, '2024-06-25', 1),
  (2, '2025-05-01', 5),
  (2, '2025-05-02', 6),
  (3, '2024-03-02', 0),
  (3, '2024-07-03', 5);
SELECT *
FROM activity;

# [코드 SET 3-6] 중간 코드
SELECT
  player_id,
  LAG(player_id) OVER (ORDER BY player_id, event_date) AS prev_id,
  event_date,
  LAG(event_date) OVER (ORDER BY player_id, event_date) AS prev_date,
  RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk_date
FROM activity
ORDER BY player_id, event_date;

# [코드 SET 3-7] 중간 코드
SELECT
  *
FROM (
    SELECT
      player_id,
      LAG(player_id) OVER (ORDER BY player_id, event_date) AS prev_id,
      event_date,
      LAG(event_date) OVER (ORDER BY player_id, event_date) AS prev_date,
      RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk_date
    FROM activity
) AS a
WHERE rnk_date = 2
  AND DATE_SUB(event_date, INTERVAL 1 DAY) = prev_date
  AND player_id = prev_id;

# [코드 SET 3-8] 최종 코드
SELECT
  ROUND(
    COUNT(player_id) / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS login_again_rate
FROM(
    SELECT
      player_id,
      event_date,
      RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk_date,
      LAG(player_id) OVER (ORDER BY player_id, event_date) AS prev_id,
      LAG(event_date) OVER (ORDER BY player_id, event_date) AS prev_date
    FROM activity
) AS a
WHERE rnk_date = 2
  AND DATE_SUB(event_date, INTERVAL 1 DAY) = prev_date
  AND player_id = prev_id;
  
# [코드 SET 3-9] 오답 코드
SELECT
  *
FROM (
	SELECT
	  player_id,
	  LAG(player_id) OVER (ORDER BY player_id, event_date) AS prev_id,
	  event_date,
	  LAG(event_date) OVER (ORDER BY player_id, event_date) AS prev_date,
	  RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk_date
	FROM activity
) AS a
WHERE DATE_SUB(event_date, INTERVAL 1 DAY) = prev_date
  AND player_id = prev_id;