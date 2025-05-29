/*
[질문]
관리자(manager_id)보다 높은 급여(salary)를 받는 직원 이름(name)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING 1]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    emp_id     INT,
    name       VARCHAR(255),
    salary     INT,
    manager_id INT,
    PRIMARY KEY(emp_id)
);
INSERT INTO employee (emp_id, name, salary, manager_id)
VALUES (1, 'Joe', 70000, 3),
    (2, 'Henry', 80000, 4),
    (3, 'Sam', 60000, NULL),
    (4, 'Max', 90000, NULL);
SELECT *
FROM employee;

# [SETTING 2]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    emp_id         INT,
    name           VARCHAR(255),
    salary         INT,
    manager_id     INT,
    PRIMARY KEY(emp_id)
);
INSERT INTO employee (emp_id, name, salary, manager_id)
VALUES (1, 'Mark', 40000, 3),
    (2, 'Alan', 20000, NULL),
    (3, 'Jack', 30000, 2);
SELECT *
FROM employee;

# [코드 1-7] INNER JOIN 문제 3 중간 코드
SELECT *
FROM employee AS e
INNER JOIN employee AS m /* 셀프 조인 */
ON e.manager_id = m.emp_id;

# [코드 1-8] INNER JOIN 문제 3 최종 코드
SELECT
    e.name
FROM employee AS e
INNER JOIN employee AS m
ON e.manager_id = m.emp_id /* 셀프 조인 */
WHERE e.salary > m.salary;

# [코드 1-9] INNER JOIN 문제 3 오답 코드
SELECT *
FROM employee AS e
INNER JOIN (
	SELECT
		emp_id,
		name,
		salary,
		manager_id
	FROM employee
	WHERE manager_id IS NULL /* 모든 관리자를 포함하지 않는다. */
) AS m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;

# [코드 1-10] 일반 서브 쿼리 코드
SELECT e.name 
FROM (
	SELECT *
	FROM employee
	WHERE salary > 30000
) AS e;

# [코드 1-11] C++ for loop 코드
for (num2 = 0; num2 <= 3; num2++) {
   for (num1 = 0; num1 <= 2; num1++) {
      cout << num2 << " " << num1 << endl;
   }
};

# [SAMPLE]
USE practice;
DROP TABLE employee_department;
CREATE TABLE employee_department
(
    employee     VARCHAR(255),
    salary            INT,
    department   VARCHAR(255)
);
INSERT INTO employee_department (employee, salary, department)
VALUES ('Henry', 80000, 'HR'),
	('Sam', 60000, 'IT'),
    ('Joe', 70000, 'HR'),
    ('Max', 90000, 'IT');
SELECT *
FROM employee_department;

# [코드 1-12] 자신이 소속된 부서의 평균 급여보다 많은 급여를 받는 직원 코드
SELECT
	employee,
	salary,
	department
FROM employee_department AS outer_query
WHERE salary >
(
	SELECT AVG(salary)
	FROM employee_department
	WHERE department = outer_query.department
);

# [코드 1-13] INNER JOIN 문제 3최종 코드
SELECT
    e.name
FROM employee AS e
WHERE e.name IN (
	SELECT
		e.name /* 바깥 테이블 e를 사용 */
	FROM employee AS m
	WHERE e.manager_id = m.emp_id /* 바깥 테이블 e를 사용 */
	AND e.salary > m.salary /* 바깥 테이블 e를 사용 */
);