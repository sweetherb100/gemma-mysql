/*
[질문]
배우(actor_id)와 감독(director_id)이 최소 3번 이상 협력한 쌍을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE actor_director;
CREATE TABLE actor_director
(
    work_id   INT,
    actor_id    INT,
    director_id INT,
    PRIMARY KEY(work_id)
);
INSERT INTO actor_director
    (work_id, actor_id, director_id)
VALUES (1, 1, 1),
    (2, 1, 1),
    (3, 1, 1),
    (4, 1, 2),
    (5, 1, 2),
    (6, 2, 1),
    (7, 2, 1);
SELECT *
FROM actor_director; 

# [코드 6-1] HAVING 문제 1 최종 코드
SELECT
    actor_id,
    director_id
FROM actor_director
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3; 

# [코드 6-2] GROUP BY와 DISTINCT 코드
SELECT
    actor_id,
    director_id,
    COUNT(*),
    COUNT(actor_id),
    COUNT(director_id),
    COUNT(work_id),
    COUNT(DISTINCT actor_id),
    COUNT(DISTINCT director_id),
    COUNT(DISTINCT work_id)
FROM actor_director
GROUP BY actor_id, director_id;
