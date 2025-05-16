/*
[질문]
한 명 이상의 후보에게 투표하거나 투표하지 않을 수 있습니다.
각 사람은 1 표를 가지므로 여러 후보에게 투표하면 각 후보에게 동등하게 분배됩니다.
예를 들어 한 사람이 두 후보에게 투표하면 후보는 각각 0.5표를 받습니다.
가장 많은 표를 얻어 선거에서 이긴 사람(winner)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE voting_results;
CREATE TABLE voting_results (
  voter VARCHAR(255),
  candidate VARCHAR(255)
);
INSERT INTO
  voting_results (voter, candidate)
VALUES ('Yuna', NULL),
	('Charles', 'Gina'),
	('Charles', 'Mina'),
	('Charles', 'Yuna'),
	('Benjamin', 'Mina'),
	('Anthony', 'Bona'),
	('Anthony', 'Sena'),
	('Edward', 'Gina'),
	('Edward', 'Bona'),
	('Edward', 'Yuna'),
	('Terry', NULL),
	('Nancy', 'Gina'),
	('Nancy', 'Sena'),
	('Nancy', 'Bona'),
	('Nancy', 'Mina'),
	('Nancy', 'Yuna');
SELECT *
FROM voting_results;

# [코드 SET 1-11] 중간 코드
SELECT
  voter,
  candidate,
  COUNT(*) OVER (PARTITION BY voter) AS cnt,
  1 / COUNT(*) OVER (PARTITION BY voter) AS point
FROM voting_results
WHERE candidate IS NOT NULL
ORDER BY voter;
   
# [코드 SET 1-12] 중간 코드
SELECT
  candidate,
  SUM(point) AS tot_point,
  RANK() OVER (ORDER BY SUM(point) DESC) AS rk
FROM (
	SELECT
	  voter,
	  candidate,
	  COUNT(*) OVER (PARTITION BY voter) AS cnt,
	  1 / COUNT(*) OVER (PARTITION BY voter) AS point
	FROM voting_results
	WHERE candidate IS NOT NULL
) AS a
GROUP BY candidate
ORDER BY tot_point DESC;
      
# [코드 SET 1-13] 최종 코드
SELECT
  candidate AS winner
FROM (
	SELECT
	  candidate,
	  SUM(point) AS tot_point,
	  RANK() OVER (ORDER BY SUM(point) DESC) AS rk
	FROM (
		SELECT
		  voter,
		  candidate,
		  COUNT(*) OVER (PARTITION BY voter) AS cnt,
		  1 / COUNT(*) OVER (PARTITION BY voter) AS point
		FROM voting_results
		WHERE candidate IS NOT NULL
	) AS a
	GROUP BY candidate
) AS b
WHERE rk = 1;
