/*
[질문]
각 학생(student_id, student_name)이 각 시험(subject_name)에 응시한 횟수(attended_exams)를 조회하는 SQL 쿼리를 작성합니다.
student_id와 subject_name을 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE students;
CREATE TABLE students
(
    student_id   INT,
    student_name VARCHAR(20),
    PRIMARY KEY(student_id)
);
INSERT INTO students
    (student_id, student_name)
VALUES (1, 'Alice'),
    (2, 'Bob'),
    (6, 'Alex'),
    (13, 'John');
SELECT *
FROM students;

# [SETTING]
USE practice;
DROP TABLE subjects;
CREATE TABLE subjects
(
    subject_name VARCHAR(20),
    PRIMARY KEY(subject_name)
);
INSERT INTO subjects
    (subject_name)
VALUES ('Math'),
    ('Physics'),
    ('Programming');
SELECT *
FROM subjects;

# [SETTING]
USE practice;
DROP TABLE examinations;
CREATE TABLE examinations
(
    student_id   INT,
    subject_name VARCHAR(20)
);
INSERT INTO examinations
    (student_id, subject_name)
VALUES (1, 'Math'),
    (1, 'Math'),
    (1, 'Math'),
    (1, 'Physics'),
    (1, 'Physics'),
    (1, 'Programming'),
    (2, 'Math'),
    (2, 'Programming'),
    (13, 'Math'),
    (13, 'Physics'),
    (13, 'Programming');
SELECT *
FROM examinations
ORDER BY student_id, subject_name; 

# [코드 3-5] CROSS JOIN 문제 2 중간 코드
SELECT *
FROM students,
subjects /* CROSS JOIN */
ORDER BY student_id, subject_name;

# [코드 3-6] CROSS JOIN 문제 2 최종 코드
SELECT
    a.student_id,
    a.student_name,
    b.subject_name,
    (
		SELECT
			COUNT(*)
		FROM examinations AS c
		WHERE a.student_id = c.student_id
			AND b.subject_name = c.subject_name
    ) AS attended_exams
FROM students AS a, /* CROSS JOIN */
subjects AS b
ORDER BY a.student_id, b.subject_name; 

# [코드 3-7] CROSS JOIN 문제 2 최종 코드
SELECT
    a.student_id,
    a.student_name,
    a.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM (
	SELECT
		student_id,      
		student_name,
		subject_name
	FROM students, /* CROSS JOIN */
    subjects
) AS a
LEFT OUTER JOIN examinations AS e
ON a.student_id = e.student_id
    AND a.subject_name = e.subject_name
GROUP BY a.student_id, a.student_name, a.subject_name
ORDER BY a.student_id, a.subject_name; 