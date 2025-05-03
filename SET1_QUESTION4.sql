/*
[질문]
유저가 처음으로 로그인한 날짜(login_date)가 오늘부터 90일 이내인 사용자 수(user_count)를 조회하는 SQL 쿼리를 작성합니다.
오늘은 2025-06-30이라고 가정합니다.
*/

# [SETTING]
USE practice;
DROP TABLE traffic;
CREATE TABLE traffic (
  user_id INT,
  activity ENUM ('login', 'homepage', 'jobs', 'groups', 'logout'),
  activity_date DATE,
  PRIMARY KEY (user_id, activity, activity_date)
);
INSERT INTO
  traffic (user_id, activity, activity_date)
VALUES (1, 'login', '2025-05-01'),
  (1, 'homepage', '2025-05-01'),
  (1, 'logout', '2025-05-01'),
  (2, 'login', '2025-06-21'),
  (2, 'logout', '2025-06-21'),
  (3, 'login', '2025-01-01'),
  (3, 'jobs', '2025-01-01'),
  (3, 'logout', '2025-01-01'),
  (4, 'login', '2025-06-21'),
  (4, 'groups', '2025-06-21'),
  (4, 'logout', '2025-06-21'),
  (5, 'login', '2025-03-01'),
  (5, 'logout', '2025-03-01'),
  (5, 'login', '2025-06-21'),
  (5, 'logout', '2025-06-21');
SELECT *
FROM traffic;

# [코드 SET 1-8] 중간 코드
SELECT DATE_SUB('2025-06-30', INTERVAL 90 DAY) AS 90_days_before;

# [코드 SET 1-9] 중간 코드
SELECT
  user_id,
  MIN(activity_date)
FROM traffic
WHERE activity = 'login'
GROUP BY user_id
HAVING MIN(activity_date) >= DATE_SUB('2025-06-30', INTERVAL 90 DAY);

# [코드 SET 1-10] 최종 코드
SELECT
  login_date,
  COUNT(user_id) AS user_count
FROM (
    SELECT
      user_id,
      MIN(activity_date) AS login_date
    FROM traffic
    WHERE activity = 'login'
    GROUP BY user_id
    HAVING MIN(activity_date) >= DATE_SUB('2025-06-30', INTERVAL 90 DAY)
) AS t
GROUP BY login_date;