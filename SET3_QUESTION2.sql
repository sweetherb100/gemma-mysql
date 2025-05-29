/*
[질문]
언어(language)별로 Apple 제품 구매 사용자 수(apple_user_count), 기기 구매 사용자 수(total_user_count)를 조회하는 SQL 쿼리를 작성합니다.
Apple 제품은 macbook pro, iphone 5s, ipad air 이렇게 3가지입니다.
기기를 구매한 사용자 수를 기준으로 내림차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE purchase_events;
CREATE TABLE purchase_events (
  user_id INT,
  occurred_at TIMESTAMP,
  device VARCHAR(255)
);
INSERT INTO
  purchase_events (user_id, occurred_at, device)
VALUES (108, '2025-07-04 21:48:01', 'lenovo thinkpad'),
	(108, '2025-07-08 07:43:11', 'hp pavilion desktop'),
	(108, '2025-07-21 17:34:43', 'hp pavilion desktop'),
	(167, '2025-07-30 19:39:13', 'lenovo thinkpad'),
	(175, '2025-07-23 09:32:20', 'lg gram'),
	(238, '2025-07-16 14:28:28', 'samsung galaxy note'),
	(251, '2025-07-29 14:32:29', 'ipad air'),
	(251, '2025-08-06 15:24:42', 'z flip 5'),
	(251, '2025-08-02 10:47:41', 'macbook pro'),
	(264, '2025-05-30 19:36:44', 'samsung galaxy s4'),
	(264, '2025-06-05 09:23:02', 'dell inspiron desktop'),
	(264, '2025-05-20 17:46:07', 'dell inspiron desktop'),
	(1002, '2025-05-16 09:33:41', 'iphone 5s'),
	(1078, '2025-06-09 17:46:15', 'galaxy tab s10'),
	(2171, '2025-08-26 07:29:39', 'asus chromebook'),
	(2242, '2025-08-03 18:49:13', 'samsung galaxy book4'),
	(2267, '2025-07-18 09:57:10', 'macbook pro');
SELECT *
FROM purchase_events;

# [SETTING]
USE practice;
DROP TABLE purchase_users;
CREATE TABLE purchase_users (
  user_id INT,
  language VARCHAR(255),
  PRIMARY KEY (user_id)
);
INSERT INTO
  purchase_users (user_id, language)
VALUES (108, 'spanish'),
	(167, 'arabic'),
	(175, 'russian'),
	(238, 'spanish'),
	(251, 'spanish'),
	(264, 'spanish'),
	(1002, 'english'),
	(1078, 'german'),
	(2171, 'english'),
	(2242, 'english'),
	(2267, 'spanish');
SELECT *
FROM purchase_users;

# [코드 세트 3-3] 최종 코드
SELECT
  language,
  COUNT(DISTINCT CASE
					WHEN device IN ('macbook pro', 'iphone 5s', 'ipad air')
                    THEN t1.user_id
				END) AS apple_user_count,
  COUNT(DISTINCT t1.user_id) AS total_user_count
FROM (
    SELECT DISTINCT
      user_id,
      device
    FROM purchase_events
) AS t1
INNER JOIN purchase_users AS t2
ON t1.user_id = t2.user_id
GROUP BY language
ORDER BY total_user_count DESC;