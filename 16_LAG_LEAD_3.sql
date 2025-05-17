/*
연속된 두 학생(student)마다 좌석(seat_id)을 바꾸는 SQL 쿼리를 작성합니다.
전체 학생 수가 홀수인 경우 마지막 학생은 자리를 바꾸지 않습니다.
seat_id를 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE seat;
CREATE TABLE seat
(
    seat_id   INT,
    student   VARCHAR(255),
    PRIMARY KEY(seat_id)
);
INSERT INTO seat
    (seat_id, student)
VALUES (1, 'Amy'),
    (2, 'Rosa'),
    (3, 'Charles'),
    (4, 'Gina'),
    (5, 'Jake');
SELECT *
FROM seat;

# [코드 16-10] LAG, LEAD 문제 3 중간 코드
SELECT
    seat_id,
    MOD(seat_id, 2) AS even_odd_flag,
    LAG(student) OVER (ORDER BY seat_id) AS pre_student,
    student,
    LEAD(student) OVER (ORDER BY seat_id) AS post_student
FROM seat
ORDER BY seat_id;

# [코드 16-11] LAG, LEAD 문제 3 최종 코드
SELECT
    seat_id,
    IF(even_odd_flag = 0, pre_student, IFNULL(post_student, student)) AS student
    /* IF 짝수 row이면 이전 student를 가져오고, ELSE 홀수 row이면 다음 student를 가져온다. (IFNULL: 마지막 홀수 row이면 그대로 유지한다.) */
FROM (
	SELECT
		seat_id,
		MOD(seat_id, 2) AS even_odd_flag,
		LAG(student) OVER (ORDER BY seat_id) AS pre_student,
		student,
		LEAD(student) OVER (ORDER BY seat_id) AS post_student
	FROM seat
) AS a
ORDER BY seat_id;

# [코드 16-12] LAG, LEAD 문제 3 중간 코드
SELECT
    (CASE
		WHEN MOD(seat_id, 2) = 0 /* 짝수 row이면 */
			THEN seat_id - 1 /* 앞자리와 바꾼다 */
		WHEN MOD(seat_id, 2) = 1 AND seat_id != (SELECT COUNT(seat_id) FROM seat) /* 마지막이 아닌 홀수 row이면 */
			THEN seat_id + 1 /* 뒷자리와 바꾼다 */
		WHEN MOD(seat_id, 2) = 1 AND seat_id = (SELECT COUNT(seat_id) FROM seat) /* 마지막인 홀수 row */
			THEN seat_id /* 마지막 자리를 그대로 유지한다 */
	END) AS seat_id,
    student
FROM seat;

# [코드 16-13] LAG, LEAD 문제 3 최종 코드
SELECT
    (CASE
		WHEN MOD(seat_id, 2) = 0 /* 짝수 row이면 */
			THEN seat_id - 1 /* 앞자리와 바꾼다 */
		WHEN MOD(seat_id, 2) = 1 AND seat_id != (SELECT COUNT(seat_id) FROM seat) /* 마지막이 아닌 홀수 row이면 */
			THEN seat_id + 1 /* 뒷자리와 바꾼다 */
		WHEN MOD(seat_id, 2) = 1 AND seat_id = (SELECT COUNT(seat_id) FROM seat) /* 마지막인 홀수 row */
			THEN seat_id /* 마지막 자리를 그대로 유지한다 */
	END) AS seat_id,
    student
FROM seat
ORDER BY seat_id;