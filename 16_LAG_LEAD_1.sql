/*
좌석(seat_id) 중에서 연속으로 이용 가능한 모든 좌석을 조회하는 SQL 쿼리를 작성합니다.
연속으로 이용할 수 있는 좌석은 2석 이상 연속으로 빈 좌석을 의미합니다.
seat_id 기준으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE seats;
CREATE TABLE seats
(
    seat_id INT,
    free    INT,
    PRIMARY KEY(seat_id)
);
INSERT INTO seats
    (seat_id, free)
VALUES (1, 1),
    (2, 0),
    (3, 1),
    (4, 1),
    (5, 1);
SELECT *
FROM seats; 

# [코드 16-1] LAG, LEAD 문제 1 중간 코드
SELECT
    seat_id,
    LAG(free) OVER (ORDER BY seat_id) AS prev_free,
    free,
    LEAD(free) OVER (ORDER BY seat_id) AS post_free
FROM seats
ORDER BY seat_id; 

# [코드 16-2] LAG, LEAD 문제 1 최종 코드
SELECT
    seat_id
FROM
(
	SELECT
		seat_id,
		LAG(free) OVER (ORDER BY seat_id) AS prev_free,
		free,
		LEAD(free) OVER (ORDER BY seat_id) AS post_free
	FROM seats
) AS s
WHERE (free = 1 AND post_free = 1) OR (prev_free = 1 AND free = 1)
ORDER BY seat_id; 

# [코드 16-3] LAG, LEAD 기본값 코드
SELECT
    LAG(seat_id) OVER (ORDER BY seat_id) AS prev_seat_id,
    seat_id,
    LEAD(seat_id) OVER (ORDER BY seat_id) AS post_seat_id
FROM seats
ORDER BY seat_id; 

# [코드 16-4] LAG, LEAD offset, default_value 변경 코드
SELECT
    LAG(seat_id, 2, 'nothing') OVER (ORDER BY seat_id) AS prev_seat_id,
    seat_id,
    LEAD(seat_id, 2, 'nothing') OVER (ORDER BY seat_id) AS post_seat_id
FROM seats
ORDER BY seat_id; 
