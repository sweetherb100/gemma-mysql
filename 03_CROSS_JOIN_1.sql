/*
[질문]
대회(contest_id)별로 등록한 사용자(user_id)의 백분율(percentage)을 조회하는 SQL 쿼리를 작성합니다.
백분율은 소수점 이하 2자리로 반올림합니다.
백분율을 기준으로 내림차순으로 정렬하고, 동점이면 contest_id를 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE users;
CREATE TABLE users
(
    user_id   INT,
    user_name VARCHAR(20),
    PRIMARY KEY(user_id)
);
INSERT INTO users
    (user_id, user_name)
VALUES (2, 'Bob'),
	(6, 'Alice'),
    (7, 'Alex');
SELECT *
FROM users;

# [SETTING]
USE practice;
DROP TABLE register;
CREATE TABLE register
(
    contest_id INT,
    user_id    INT,
    PRIMARY KEY(contest_id, user_id)
);
INSERT INTO register
    (contest_id, user_id)
VALUES (207, 2),
	(208, 2),
	(208, 6),
    (208, 7),
    (209, 2),
    (209, 6),
    (209, 7),
    (210, 2),
    (210, 6),
    (210, 7),  
    (215, 6),
    (215, 7);
SELECT *
FROM register; 

# [코드 3-1] CROSS JOIN 문제 1 중간 코드
SELECT
	contest_id,
    COUNT(user_id) AS user_cnt
FROM register
GROUP BY contest_id
ORDER BY contest_id;

# [코드 3-2] CROSS JOIN 문제 1 중간 코드
SELECT
	COUNT(user_id) AS tot_cnt
FROM users;

# [코드 3-3] CROSS JOIN 문제 1 중간 코드
SELECT
	a.contest_id,
	a.user_cnt,
	b.tot_cnt
FROM (
	SELECT
		contest_id,
		COUNT(user_id) AS user_cnt
	FROM register
	GROUP BY contest_id
) AS a, /* CROSS JOIN */
(
	SELECT
		COUNT(user_id) AS tot_cnt
	FROM users
) AS b
ORDER BY contest_id;

# [코드 3-4] CROSS JOIN 문제 1 최종 코드
SELECT
    contest_id,
    ROUND(user_cnt / tot_cnt * 100, 2) AS percentage
FROM (
	SELECT
		contest_id,
		COUNT(user_id) AS user_cnt
	FROM register
	GROUP BY contest_id
) AS a, /* CROSS JOIN */
(
	SELECT
		COUNT(user_id) AS tot_cnt
	FROM users
) AS b
ORDER BY percentage DESC, contest_id;
