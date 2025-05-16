/*
[질문]
친구 수가 가장 많은 사람(id)과 그 사람의 친구 수(friend_count)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE request_accepted;
CREATE TABLE request_accepted
(
    requester_id INT,
    accepter_id  INT,
    accept_date  DATE,
  PRIMARY KEY (requester_id, accepter_id)
);
INSERT INTO request_accepted
    (requester_id, accepter_id, accept_date)
VALUES (1, 2, '2025-06-03'),
    (1, 3, '2025-06-08'),
    (2, 3, '2025-06-08'),
    (3, 4, '2025-06-09');
SELECT *
FROM request_accepted; 

# [코드 SET 1-5] 중간 코드
SELECT requester_id AS id
FROM request_accepted

UNION ALL

SELECT accepter_id AS id
FROM request_accepted; 
    
# [코드 SET 1-6] 중간 코드
SELECT
    id,
    COUNT(id) AS friend_count,
    RANK() OVER (ORDER BY COUNT(id) DESC) AS rk
FROM (
    SELECT requester_id AS id
    FROM request_accepted
    UNION ALL
    SELECT accepter_id AS id
    FROM request_accepted
) AS a
GROUP BY id;

# [코드 SET 1-7] 최종 코드
SELECT
    id,
    friend_count
FROM (
	SELECT
		id,
		COUNT(id) AS friend_count,
		RANK() OVER (ORDER BY COUNT(id) DESC) AS rk
	FROM (
		SELECT requester_id AS id
		FROM request_accepted
		UNION ALL
		SELECT accepter_id AS id
		FROM request_accepted
	) AS a
	GROUP BY id
) AS b
WHERE rk = 1;