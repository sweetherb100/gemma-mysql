/*
[질문]
직원의 이름(name), 부서(department), 급여(salary)와 함께 해당 부서의 평균 급여(avg_salary)를 조회하는 SQL 쿼리를 작성합니다.
평균 급여(avg_salary)는 소수점 이하 2자리로 반올림합니다.
*/

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    name VARCHAR(50),
    department VARCHAR(50),
    salary	   INT,
    PRIMARY KEY(name)
);
INSERT INTO employee
    (name, department, salary)
VALUES ('Sarah', 'Audit', 2000),
    ('Suzan', 'Audit', 1300),
    ('Richard', 'Management', 250000),
    ('George', 'Management', 100000),
    ('Katty', 'Management', 150000),
    ('Max', 'Sales', 1300),
	('Jennifer', 'Sales', 1000),
    ('Laila', 'Sales', 1000),
    ('Mandy', 'Sales', 1300);
SELECT *
FROM employee;

# [코드 5-3] GROUP BY 문제 3 최종 코드
SELECT
    name,
    department,
    salary,
    ROUND(AVG(salary) OVER (PARTITION BY department), 2) AS avg_salary
FROM employee; 

# [코드 5-4] GROUP BY 코드
SELECT
	department,
	AVG(salary) AS avg_salary
FROM employee
GROUP BY department;

# [코드 5-5] PARTITION BY 코드
SELECT
	name,
	department,
	name,
	AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employee;