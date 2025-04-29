/*
[질문]
활성 비즈니스는 해당 이벤트 유형(event_type)의 평균 발생 횟수(occurrences)보다 더 많이 발생하는 이벤트 유형(event_type)이 두 개 이상 있는 비즈니스입니다.
활성 비즈니스(business_id)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE events;
CREATE TABLE events
(
    business_id INT,
    event_type  VARCHAR(255),
    occurrences  INT,
    PRIMARY KEY(business_id, event_type)
);
INSERT INTO events
    (business_id, event_type, occurrences)
VALUES (1, 'reviews', 7),
    (3, 'reviews', 3),
    (1, 'ads', 11),
    (2, 'ads', 7),
    (3, 'ads', 6),
    (1, 'page_views', 3),
    (2, 'page_views', 12);
SELECT *
FROM events; 

# [코드 6-7] HAVING 문제 3 중간 코드
SELECT
    event_type,
    AVG(occurrences) AS avg_occ
FROM events
GROUP BY event_type; 

# [코드 6-8] HAVING 문제 3 중간 코드
SELECT 
	e.business_id,
	e.occurrences,
	e.event_type,
	avge.event_type,
	avge.avg_occ
FROM events AS e
INNER JOIN (
	SELECT
		event_type,
		AVG(occurrences) AS avg_occ
	FROM events
	GROUP BY event_type
) AS avge
ON e.event_type = avge.event_type
WHERE e.occurrences > avge.avg_occ; /* 해당 이벤트 유형의 평균 발생 횟수보다 큰 경우 */

# [코드 6-9] HAVING 문제 3 최종 코드
SELECT
    e.business_id
FROM events AS e
INNER JOIN (
	SELECT
		event_type,
		AVG(occurrences) AS avg_occ
	FROM events
	GROUP BY event_type
) AS avge
ON e.event_type = avge.event_type
WHERE e.occurrences > avge.avg_occ /* 해당 이벤트 유형의 평균 발생보다 큰 경우 */
GROUP BY e.business_id
HAVING COUNT(e.business_id) >= 2; /* 이벤트 유형이 두 개 이상 */