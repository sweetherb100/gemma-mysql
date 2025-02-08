/*
두 번째로 높은 급여(second_highest_salary)를 조회하는 SQL 쿼리를 작성합니다.
두 번째로 높은 급여가 없으면 NULL을 반환합니다.
*/

# [SETTING1]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    employee_id   INT,
    salary        INT,
    PRIMARY KEY (employee_id)
);
INSERT INTO employee
    (employee_id, salary)
VALUES (1, 100),
    (2, 100),
    (3, 200),
    (4, 300),
    (5, 300); 
SELECT *
FROM employee;

# [SETTING2]
# output: null case
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    employee_id   INT,
    salary        INT,
    PRIMARY KEY (employee_id)
);
INSERT INTO employee
    (employee_id, salary)
VALUES
	(1, 100);
SELECT *
FROM employee;

# [코드 14-4] DENSE_RANK 문제 2 중간 코드
SELECT
    employee_id,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rk,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS drk
FROM employee;

# [코드 14-5] DENSE_RANK 문제 2 최종 코드
SELECT
    MAX(salary) AS second_highest_salary /* [결과 예시 2] 해결 (max, min, avg 등 어떠한 집계함수든 상관 없음) */
FROM (
	SELECT
		employee_id,
		salary,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS drk
	FROM employee
) AS a
WHERE drk = 2;

# [코드 14-6] DENSE_RANK 문제 2 오답 코드
SELECT
    salary AS second_highest_salary  /* [결과 예시 2]에서 오답 */
FROM (
	SELECT
		employee_id,
		salary,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS drk
	FROM employee
) AS a
WHERE drk = 2; 

# [코드 14-7] DENSE_RANK 문제 2 최종 코드
SELECT
    MAX(salary) AS second_highest_salary /* [결과 예시 2] 해결 */
FROM employee
WHERE salary NOT IN (
	SELECT
		MAX(salary)
	FROM employee
); 