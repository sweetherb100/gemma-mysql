/*
우승자 이름(name)을 조회하는 SQL 쿼리를 작성합니다. 동률이 없다고 가정합니다.
즉 우승자는 최대 한 명입니다.
*/

# [SETTING]
USE practice;
DROP TABLE candidate;
CREATE TABLE candidate
(
    candidate_id   INT,
    name VARCHAR(255),
    PRIMARY KEY (candidate_id)
);
INSERT INTO candidate
    (candidate_id, name)
VALUES (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'Dale'),
    (5, 'Elena');
SELECT *
FROM candidate; 

# [SETTING]
USE practice;
DROP TABLE vote;
CREATE TABLE vote
(
    vote_id      INT,
    candidate_id INT,
    PRIMARY KEY (vote_id)
);
INSERT INTO vote
    (vote_id, candidate_id)
VALUES (1, 2),
    (2, 4),
    (3, 3),
    (4, 2),
    (5, 5);
SELECT *
FROM vote; 

# [코드 11-7] LIMIT 문제 3 중간 코드
SELECT
    candidate_id,
    COUNT(*) AS vote_cnt
FROM vote
GROUP BY candidate_id
ORDER BY vote_cnt DESC
LIMIT 1; 

# [코드 11-8] LIMIT 문제 3 최종 코드
SELECT
    c.name
FROM candidate AS c
INNER JOIN
(
	SELECT
		candidate_id,
		COUNT(*) AS vote_cnt
	FROM vote
	GROUP BY candidate_id
	ORDER BY vote_cnt DESC
	LIMIT 1
) AS v
ON c.candidate_id = v.candidate_id; 

# [코드 11-9] LIMIT 문제 3 중간 코드
SELECT *
FROM candidate AS c
INNER JOIN vote AS v
ON c.candidate_id = v.candidate_id;

# [코드 11-10] LIMIT 문제 3 최종 코드
SELECT
    c.name
FROM candidate AS c
INNER JOIN vote AS v
ON c.candidate_id = v.candidate_id
GROUP BY c.candidate_id, c.name
ORDER BY COUNT(*) DESC
LIMIT 1;

# [코드 11-11] LIMIT 문제 3 중간 코드
SELECT
    candidate_id,
    COUNT(*) AS vote_cnt,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rk
FROM vote
GROUP BY candidate_id; 

# [코드 11-12] LIMIT 문제 3 최종 코드
SELECT
    c.name
FROM candidate AS c
INNER JOIN
(
	SELECT
		candidate_id
	FROM
    (
		SELECT
			candidate_id,
			COUNT(*),
			RANK() OVER (ORDER BY COUNT(*) DESC) AS rk
		FROM vote
		GROUP BY candidate_id
	) AS a
	WHERE rk = 1
) AS v
ON c.candidate_id = v.candidate_id; 

# [코드 11-13] LIMIT 문제 3 오답 코드
# Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'practice.vote.candidate_id';
# this is incompatible with sql_mode=only_full_group_by
# -> GROUP BY 필요
SELECT
    candidate_id,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rk
FROM vote;
