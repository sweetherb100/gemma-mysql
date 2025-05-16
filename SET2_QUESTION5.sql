/*
[질문]
각 사용자(user_id)의 평균 웹사이트 방문 시간(avg_visit_time)을 조회하는 SQL 쿼리를 작성합니다.
평균 웹사이트 방문 시간은 초 단위로 반환합니다.
여기서 웹사이트 방문 시간은 page_load와 page_exit 사이의 시간 차이로 정의됩니다.
같은 날에 여러 page_load 이벤트가 있을 경우 가장 마지막 page_load를 사용합니다.
또한 같은 날에 여러 page_exit 이벤트가 있을 경우 가장 첫 page_exit를 사용합니다.
page_load는 page_exit 이전에 발생하도록 합니다.
*/

# [SETTING]
USE practice;
DROP TABLE web_log;
CREATE TABLE web_log
(
    user_id INT,
    timestamp  TIMESTAMP,
    action  ENUM ('page_load', 'scroll_down', 'scroll_up', 'page_exit')
);
INSERT INTO
	web_log (user_id, timestamp, action)
VALUES (0, '2025-04-25 13:30:15', 'page_load'),
	(0, '2025-04-25 13:30:18', 'page_load'),
	(0, '2025-04-25 13:30:40', 'scroll_down'),
	(0, '2025-04-25 13:30:45', 'scroll_up'),
	(0, '2025-04-25 13:31:40', 'page_exit'),
	(1, '2025-04-25 13:40:00', 'page_load'),
	(1, '2025-04-25 13:40:30', 'scroll_down'),
	(1, '2025-04-25 13:40:35', 'page_exit'),
	(1, '2025-04-26 11:15:00', 'page_load'),
	(1, '2025-04-26 11:15:10', 'scroll_down'),
	(1, '2025-04-26 11:15:25', 'scroll_up'),
	(1, '2025-04-26 11:15:35', 'page_exit'),
	(0, '2025-04-28 14:30:10', 'page_load'),
    (0, '2025-04-28 14:30:15', 'page_load'),
	(0, '2025-04-28 13:30:40', 'scroll_down'),
	(0, '2025-04-28 15:31:40', 'page_exit');
SELECT *
FROM web_log;

# [코드 SET 2-11] 중간 코드
SELECT
  user_id,
  DATE_FORMAT(timestamp, '%Y-%m-%d') AS date,
  MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS latest_load,
  MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS earliest_exit
FROM web_log
GROUP BY user_id, DATE_FORMAT(timestamp, '%Y-%m-%d')
ORDER BY user_id, date;

# [코드 SET 2-12] 중간 코드
SELECT
  user_id,
  date,
  TIMESTAMPDIFF(second, latest_load, earliest_exit) AS time_diff
FROM (
	SELECT
	  user_id,
	  DATE_FORMAT(timestamp, '%Y-%m-%d') AS date,
	  MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS latest_load,
	  MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS earliest_exit
	FROM web_log
	GROUP BY user_id, DATE_FORMAT(timestamp, '%Y-%m-%d')
) AS a
WHERE latest_load < earliest_exit
ORDER BY user_id, date;

# [코드 SET 2-13] 최종 코드
SELECT
  user_id,
  AVG(time_diff) AS avg_visit_time
FROM (
    SELECT
      user_id,
      date,
      TIMESTAMPDIFF(second, latest_load, earliest_exit) AS time_diff
    FROM (
        SELECT
          user_id,
          DATE_FORMAT(timestamp, '%Y-%m-%d') AS date,
          MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS latest_load,
          MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS earliest_exit
        FROM web_log
        GROUP BY user_id, DATE_FORMAT(timestamp, '%Y-%m-%d')
	) AS a
    WHERE latest_load < earliest_exit
) AS b
GROUP BY user_id;