/*
[질문]
비디오 승인을 가장 많이 받은 사용자 전체 이름(username)를 조회하는 SQL 쿼리를 작성합니다.
사용자의 전체 이름은 이름(uploader_firstname)과 성(uploader_lastname) 사이에 공백을 포함합니다.
*/

# [SETTING]
USE practice;
DROP TABLE user_videos;
CREATE TABLE user_videos
(
    video_id  INT,
    review_id  VARCHAR(255),
    uploader_firstname VARCHAR(255),
    uploader_lastname VARCHAR(255),
    PRIMARY KEY (video_id, review_id)
);
INSERT INTO user_videos
    (video_id, review_id, uploader_firstname, uploader_lastname)
VALUES (1, 'r001', 'Mark', 'May'),
	(1, 'r002', 'Mark', 'May'),
    (2, 'r003', 'Gina', 'Korman'),
	(2, 'r004', 'Gina', 'Korman'),
	(2, 'r005', 'Richard', 'Hasson'),
    (3, 'r006', 'Mark', 'May'),
	(3, 'r007', 'Pauline', 'Wilks'),
    (4, 'r008', 'Mark', 'May'),
	(4, 'r009', 'Daniel', 'Bell'),
	(5, 'r010', 'Richard', 'Hasson');
SELECT *
FROM user_videos; 

# [SETTING]
USE practice;
DROP TABLE reviews;
CREATE TABLE reviews
(
    review_id VARCHAR(255),
    reviewed_outcome  ENUM ('declined', 'approved'),
    PRIMARY KEY (review_id)
);
INSERT INTO reviews
    (review_id, reviewed_outcome)
VALUES ('r001', 'declined'),
	('r002', 'declined'),
    ('r003', 'declined'),
	('r004', 'declined'),
	('r005', 'approved'),
    ('r006', 'approved'),
	('r007', 'approved'),
	('r008', 'approved'),
	('r009', 'declined'),
	('r010', 'approved');
SELECT *
FROM reviews; 

# [코드 SET 2-9] 중간 코드
SELECT
  CONCAT(uploader_firstname, ' ', uploader_lastname) AS username,
  COUNT(video_id) AS video_count,
  RANK() OVER (ORDER BY COUNT(video_id) DESC) AS rk
FROM user_videos AS t1
INNER JOIN reviews AS t2
ON t1.review_id = t2.review_id
WHERE reviewed_outcome = 'approved'
GROUP BY CONCAT(uploader_firstname, ' ', uploader_lastname);

# [코드 SET 2-10] 최종 코드
SELECT
  username
FROM (
    SELECT
      CONCAT(uploader_firstname, ' ', uploader_lastname) AS username,
      COUNT(video_id) AS video_count,
      RANK() OVER (ORDER BY COUNT(video_id) DESC) AS rk
    FROM user_videos AS t1
	INNER JOIN reviews AS t2
    ON t1.review_id = t2.review_id
    WHERE reviewed_outcome = 'approved'
    GROUP BY CONCAT(uploader_firstname, ' ', uploader_lastname)
) AS a
WHERE rk = 1;