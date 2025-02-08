/*
[질문]
친구 요청을 한 날짜(sent_date)에 대한 친구 수락률(accepted_rate)을 조회하는 SQL 쿼리를 작성합니다.
빠른 날짜부터 늦은 날짜 순으로 내림차순 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE friend_requests;
CREATE TABLE friend_requests (
  sender_user VARCHAR(255),
  receiver_user VARCHAR(255),
  action ENUM ('sent', 'accepted'),
  date DATE,
  PRIMARY KEY (sender_user, receiver_user, action)
);
INSERT INTO
  friend_requests (sender_user, receiver_user, action, date)
VALUES ('Alex', 'Amber', 'sent', '2025-01-04'),
	('Alex', 'Amber', 'accepted', '2025-01-06'),
	('Charles', 'Caroline', 'sent', '2025-01-06'),
    ('Sarah', 'Simon', 'sent', '2025-01-04'),
	('Sarah', 'Simon', 'accepted', '2025-01-15'),
	('Elena', 'Emily', 'sent', '2025-01-04'),
	('Elena', 'Emily', 'accepted', '2025-01-10'),	
	('George', 'Gloria', 'sent', '2025-01-04'),
	('Lucy', 'Logan', 'sent', '2025-01-06'),
	('Lucy', 'Logan', 'accepted', '2025-01-11'),
    ('Valentina', 'Victor', 'sent', '2025-01-06'),
	('Valentina', 'Victor', 'accepted', '2025-01-10');
SELECT *
FROM friend_requests;

# [코드 SET 3-4] 중간 코드
SELECT
  sender_user,
  receiver_user,
  MIN(CASE WHEN action = 'sent' THEN date END) AS sent_date,
  SUM(CASE WHEN action = 'accepted' THEN 1 ELSE 0 END) AS accepted
FROM friend_requests
GROUP BY sender_user, receiver_user
ORDER BY sent_date;
    
# [코드 SET 3-5] 최종 코드
SELECT
  sent_date,
  SUM(accepted) / COUNT(*) AS accepted_rate
FROM (
    SELECT
      sender_user,
      receiver_user,
      MIN(CASE WHEN action = 'sent' THEN date END) AS sent_date,
      SUM(CASE WHEN action = 'accepted' THEN 1 ELSE 0 END) AS accepted
    FROM friend_requests
    GROUP BY sender_user, receiver_user
) AS a
GROUP BY sent_date
ORDER BY sent_date;