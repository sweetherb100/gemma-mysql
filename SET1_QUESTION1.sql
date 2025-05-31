/*
[질문]
부서별로 가장 급여가 높은 직원의 이름(name), 부서(department), 급여(salary)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee (
  id INT,
  name VARCHAR(255),
  department VARCHAR(255),
  salary INT,
  PRIMARY KEY (id)
);
INSERT INTO
  employee (id, name, department, salary)
VALUES (101, 'Max', 'Sales', 1300),
	(102, 'Katty', 'Management', 150000),
	(103, 'Richard', 'Management', 250000),
	(104, 'Jennifer', 'Sales', 1000),
	(105, 'George', 'Management', 100000),
	(106, 'Laila', 'Sales', 1000),
	(107, 'Sarah', 'Sales', 2000);
SELECT *
FROM employee;

# [코드 세트 1-1] 중간 코드
SELECT
  name,
  department,
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) rk
FROM employee
ORDER BY department, rk;

# [코드 세트 1-2] 최종 코드
SELECT
  name,
  department,
  salary
FROM (
    SELECT
      name,
      department,
      salary,
      RANK() OVER (PARTITION BY department ORDER BY salary DESC) rk
    FROM employee
) AS a
WHERE rk = 1;