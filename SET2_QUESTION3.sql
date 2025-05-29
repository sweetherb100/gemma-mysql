/*
[질문]
가장 많은 영화를 평가한 사용자 이름(results)을 조회하는 SQL 쿼리를 작성합니다. 동점일 때 알파벳 순서로 더 앞에 있는 사용자 이름을 반환합니다.
더불어 2025년 2월 평균 평점이 가장 높은 영화 제목(results)을 조회하는 SQL 쿼리를 작성합니다.
동점일 때 알파벳 순서로 더 앞에 있는 영화 제목을 반환합니다.
*/

# [SETTING]
USE practice;
DROP TABLE movies;
CREATE TABLE movies (
	movie_id INT,
	title VARCHAR(30),
    PRIMARY KEY (movie_id)
);
INSERT INTO
  movies (movie_id, title)
VALUES (1, 'Avengers'),
  (2, 'Frozen'),
  (3, 'Joker');
SELECT *
FROM movies;

# [SETTING]
USE practice;
DROP TABLE users;
CREATE TABLE users (
	user_id INT,
	name VARCHAR(30),
    PRIMARY KEY (user_id)
);
INSERT INTO
  users (user_id, name)
VALUES (1, 'Daniel'),
  (2, 'Monica'),
  (3, 'Maria'),
  (4, 'James');
SELECT *
FROM users;

# [SETTING]
USE practice;
DROP TABLE movie_score;
CREATE TABLE movie_score (
  movie_id INT,
  user_id INT,
  score INT,
  created_at DATE,
  PRIMARY KEY (movie_id, user_id)
);
INSERT INTO
  movie_score (movie_id, user_id, score, created_at)
VALUES (1, 1, 30, '2025-01-12'),
  (1, 2, 40, '2025-02-11'),
  (1, 3, 20, '2025-02-12'),
  (1, 4, 10, '2025-01-01'),
  (2, 1, 50, '2025-02-17'),
  (2, 2, 20, '2025-02-01'),
  (2, 3, 20, '2025-03-01'),
  (3, 1, 30, '2025-02-22'),
  (3, 2, 40, '2025-02-25');
SELECT *
FROM movie_score;

# [코드 세트 2-5] 중간 코드
SELECT
	name,
	COUNT(score)
FROM movie_score AS m
INNER JOIN users AS u
ON m.user_id = u.user_id
GROUP BY name
ORDER BY COUNT(score) DESC, name;

# [코드 세트 2-6] 중간 코드
SELECT
	title,
    AVG(score)
FROM movie_score AS m
INNER JOIN movies AS mm
ON m.movie_id = mm.movie_id
WHERE DATE_FORMAT(created_at, '%Y-%m') = '2025-02'
GROUP BY title
ORDER BY AVG(score) DESC, title;

# [코드 세트 2-7] 최종 코드
SELECT results
FROM (
    SELECT name AS results
    FROM movie_score AS m
	INNER JOIN users AS u
    ON m.user_id = u.user_id
    GROUP BY name
    ORDER BY COUNT(score) DESC, name
    LIMIT 1
) AS a

UNION ALL

SELECT results
FROM (
    SELECT title AS results
    FROM movie_score AS m
	INNER JOIN movies AS mm
    ON m.movie_id = mm.movie_id
    WHERE DATE_FORMAT(created_at, '%Y-%m') = '2025-02'
    GROUP BY title
    ORDER BY AVG(score) DESC, title
    LIMIT 1
) AS b;

# [코드 세트 2-8] 오답 코드
SELECT name AS results
FROM movie_score AS m
INNER JOIN users AS u
ON m.user_id = u.user_id
GROUP BY name
ORDER BY COUNT(score) DESC, name  
LIMIT 1

UNION ALL 

SELECT title AS results
FROM movie_score AS m
INNER JOIN movies AS mm
ON m.movie_id = mm.movie_id
WHERE DATE_FORMAT(created_at, '%Y-%m') = '2025-02'
GROUP BY title
ORDER BY AVG(score) DESC, title 
LIMIT 1;