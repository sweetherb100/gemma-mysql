/*
[질문]
정보가 누락된 직원의 ID(employee_id)를 조회하는 SQL 쿼리를 작성합니다.
직원의 이름(name)이 누락되었거나 직원의 급여(salary)가 누락된 경우 직원 정보가 누락되었다고 말할 수 있습니다.
직원의 ID(employee_id)를 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE employees;
CREATE TABLE employees
(
    employee_id INT,
    name        VARCHAR(30),
    PRIMARY KEY(employee_id)
);
INSERT INTO employees
    (employee_id, name)
VALUES (2, 'Crew'),
    (4, 'Haven'),
    (5, 'Kristian');
SELECT *
FROM employees;

# [SETTING]
USE practice;
DROP TABLE salaries;
CREATE TABLE salaries
(
    employee_id INT,
    salary      INT,
    PRIMARY KEY(employee_id)
);
INSERT INTO salaries
    (employee_id, salary)
VALUES (1, 22517),
	(4, 63539),
	(5, 76071);
SELECT *
FROM salaries; 

# [코드 4-1] FULL OUTER JOIN 문제 1 중간 코드
SELECT
	e.name,
	e.employee_id,
	s.employee_id,
	s.salary
FROM employees AS e
LEFT OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id;

# [코드 4-2] FULL OUTER JOIN 문제 1 중간 코드
SELECT
	s.salary,
	s.employee_id,
	e.employee_id,
	e.name
FROM salaries AS s
LEFT OUTER JOIN employees AS e
ON s.employee_id = e.employee_id;

# [코드 4-3] FULL OUTER JOIN 문제 1 최종 코드
SELECT
    e.employee_id
FROM employees AS e
LEFT OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id
WHERE s.employee_id IS NULL

UNION

SELECT
    s.employee_id
FROM salaries AS s
LEFT OUTER JOIN employees AS e
ON s.employee_id = e.employee_id
WHERE e.employee_id IS NULL
ORDER BY employee_id; 

# [코드 4-4] FULL OUTER JOIN 문제 1 중간 코드
SELECT
	e.name,
	e.employee_id,
	s.employee_id,
	s.salary
FROM employees AS e
FULL OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id;

# [코드 4-5] FULL OUTER JOIN 문제 1 중간 코드
SELECT
	e.name,
	e.employee_id,
	s.employee_id,
	s.salary
FROM employees AS e
FULL OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL
	OR s.employee_id IS NULL;

# [코드 4-6] FULL OUTER JOIN 문제 1 최종 코드
SELECT
	CASE
		WHEN e.employee_id IS NULL THEN s.employee_id
		WHEN s.employee_id IS NULL THEN e.employee_id
	END AS employee_id /* COALESCE(e.employee_id, s.employee_id)와 동일 */
FROM employees AS e
FULL OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL
	OR s.employee_id IS NULL
ORDER BY employee_id;

# [코드 4-7] UNION 코드
SELECT city
FROM A

UNION

SELECT city
FROM B;

# [코드 4-8] UNION ALL 코드
SELECT city
FROM A

UNION ALL

SELECT city
FROM B;

# [코드 4-9] LEFT OUTER JOIN 2개로 FULL OUTER JOIN 코드
SELECT
	e.name,
	e.employee_id,
    s.employee_id,
    s.salary
FROM salaries AS s
LEFT OUTER JOIN employees AS e
ON s.employee_id = e.employee_id

UNION

SELECT
	e.name,
	e.employee_id,
    s.employee_id,
    s.salary
FROM employees AS e
LEFT OUTER JOIN salaries AS s
ON e.employee_id = s.employee_id;

# [코드 4-10] FULL OUTER JOIN 코드
SELECT
	e.name,
	e.employee_id,
    s.employee_id,
    s.salary
FROM salaries AS s
FULL OUTER JOIN employees AS e
ON s.employee_id = e.employee_id;