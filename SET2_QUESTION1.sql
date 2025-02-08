/*
[질문]
각 팔로워(follower)의 팔로워 수(follower_count)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE sns_follow_log;
CREATE TABLE sns_follow_log (
	followee VARCHAR(255),
	follower VARCHAR(255),
    PRIMARY KEY (followee, follower)
);
INSERT INTO
  sns_follow_log (followee, follower)
VALUES ('Adam', 'Bob'),
  ('Bob', 'Charles'),
  ('Bob', 'Dale'),
  ('Dale', 'Elena');
SELECT *
FROM sns_follow_log;

# [코드 SET 2-1] 중간 코드
SELECT *
FROM sns_follow_log AS f1
LEFT OUTER JOIN sns_follow_log AS f2
ON f1.follower = f2.followee;
    
# [코드 SET 2-2] 최종 코드
SELECT
  f1.follower,
  COUNT(f2.follower) AS follower_count
FROM sns_follow_log AS f1
LEFT OUTER JOIN sns_follow_log AS f2
ON f1.follower = f2.followee
GROUP BY f1.follower
ORDER BY follower_count DESC;