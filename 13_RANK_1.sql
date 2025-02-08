/*
각 학생(student_id)이 받은 최고 성적의 과목(course_id)와 그 성적(best_grade)을 조회하는 SQL 쿼리를 작성합니다.
최고 성적을 받은 과목이 여러 개인 경우 course_id가 가장 작은 과목을 조회합니다.
student_id 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE examinations;
CREATE TABLE examinations
(
    student_id INT,
    course_id  INT,
    grade      INT,
    PRIMARY KEY (student_id, course_id)
);
INSERT INTO examinations
    (student_id, course_id, grade)
VALUES (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);
SELECT *
FROM examinations; 

# [코드 13-1] RANK의 ORDER BY 코드
SELECT
    student_id,
    grade,
    RANK() OVER (ORDER BY grade DESC) AS rk
FROM examinations
ORDER BY grade DESC;

# [코드 13-2] RANK 문제 1 중간 코드
SELECT
    student_id,
    grade,
    course_id,
    RANK() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id) AS rk
FROM examinations
ORDER BY student_id, grade DESC, course_id; 

# [코드 13-3] RANK 문제 1 최종 코드
SELECT
    student_id,
    course_id,
    grade AS best_grade
FROM
(
SELECT
	student_id,
	course_id,
	grade,
	RANK() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id) AS rk
FROM examinations
) AS e
WHERE rk = 1
ORDER BY student_id;
