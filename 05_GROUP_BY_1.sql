/*
[질문]
각 직원(emp_id)이 매일(day) 사무실에서 보낸 총 시간(total_time)을 분 단위로 조회하는 SQL 쿼리를 작성합니다.
직원(emp_id)은 하루 동안 두 번 이상 출입할 수 있습니다.
각 행의 사무실에서 보낸 시간은 out_time - in_time입니다.
*/

# [SETTING]
USE practice;
DROP TABLE employees;
CREATE TABLE employees
(
    emp_id    INT,
    event_day DATE,
    in_time   INT,
    out_time  INT
);
INSERT INTO employees
    (emp_id, event_day, in_time, out_time)
VALUES (1, '2024-11-28', 4, 32),
    (1, '2024-11-28', 55, 200),
    (2, '2024-11-28', 3, 33),
    (1, '2024-12-03', 1, 42),
    (2, '2024-12-09', 47, 74);
SELECT *
FROM employees; 

# [코드 5-1] GROUP BY 문제 1 최종 코드
SELECT
    emp_id,
    event_day AS day,
    SUM(out_time) - SUM(in_time) AS total_time
FROM employees
GROUP BY emp_id, event_day;