/*
가장 많은 선수가 출전한 올림픽(game)과 선수 수(athletes_count)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE olympics_athletes;
CREATE TABLE olympics_athletes (
    athlete_id INT,
    athlete_name VARCHAR(255),
    game VARCHAR(255),
    PRIMARY KEY (athlete_id)
);
INSERT INTO olympics_athletes
	(athlete_id, athlete_name, game)
VALUES (3520, 'Amparan', '1924 Summer'),
	(35394, 'Finchett', '1924 Summer'),
	(25934, 'Clausen', '1908 Summer'),
	(35191, 'Sigmond', '1908 Summer'),
	(4073, 'Jeitz', '1900 Summer'),
	(120786, 'Cory', '1924 Summer'),
	(33723, 'Nederpeld', '1924 Summer'),
	(82480, 'Andreac', '1900 Summer'),
	(18257, 'Tolar', '1924 Summer');
SELECT *
FROM olympics_athletes;

# [코드 11-3] LIMIT 문제 2 중간 코드
SELECT
    game,
    COUNT(athlete_id) AS athletes_count
FROM olympics_athletes
GROUP BY game
ORDER BY athletes_count DESC;

# [코드 11-4] LIMIT 문제 2 최종 코드
SELECT
    game,
    COUNT(athlete_id) AS athletes_count
FROM olympics_athletes
GROUP BY game
ORDER BY athletes_count DESC
LIMIT 1; 

# [코드 11-5] LIMIT 문제 2 중간 코드
SELECT
	game,
	COUNT(athlete_id) athletes_count,
	RANK() OVER (ORDER BY COUNT(athlete_id) DESC) AS rk
FROM olympics_athletes
GROUP BY game;

# [코드 11-6] LIMIT 문제 2 최종 코드
SELECT
	game,
	athletes_count
FROM (
    SELECT
		game,
		COUNT(athlete_id) athletes_count,
		RANK() OVER (ORDER BY COUNT(athlete_id) DESC) AS rk
    FROM olympics_athletes
    GROUP BY game
) AS a
WHERE rk=1;
