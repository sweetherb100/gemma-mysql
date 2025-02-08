/*
각 프로젝트(project_id)에서 경력이 가장 긴 직원(longest_employee_id)을 조회하는 SQL 쿼리를 작성합니다.
동일한 경력이 여러 명 있는 경우 최대 경력을 가진 직원을 모두 조회합니다.
*/

# [SETTING]
USE practice;
DROP TABLE project;
CREATE TABLE project
(
    project_id  INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id)
);
INSERT INTO project
    (project_id, employee_id)
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);
SELECT *
FROM project; 

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    employee_id      INT,
    name             VARCHAR(255),
    experience_years INT,
    PRIMARY KEY (employee_id)
);
INSERT INTO employee
    (employee_id, name, experience_years)
VALUES (1, 'Lizzie', 3),
    (2, 'Bingley', 2),
    (3, 'Jane', 3),
    (4, 'Darcy', 2);
SELECT *
FROM employee; 

# [코드 13-4] RANK 문제 2 중간 코드
SELECT
    p.project_id,
    p.employee_id,
    e.experience_years,
    RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS rk
FROM project AS p
INNER JOIN employee AS e
ON p.employee_id = e.employee_id
ORDER BY project_id, experience_years DESC;

# [코드 13-5] RANK 문제 2 최종 코드
SELECT
    project_id,
    employee_id AS longest_employee_id
FROM (
	SELECT
		p.project_id,
		p.employee_id,
		e.experience_years,
		RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS rk
	FROM project AS p
	INNER JOIN employee AS e
	ON p.employee_id = e.employee_id
) AS a
WHERE rk = 1;  