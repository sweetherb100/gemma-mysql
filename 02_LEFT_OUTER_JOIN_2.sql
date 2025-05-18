/*
[질문]
보너스가 1000보다 작은 직원의 이름(name)과 보너스 금액(bonus)을 조회하는 SQL 쿼리를 작성합니다.
보너스가 없으면 NULL로 표시합니다.
*/

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee
(
    emp_id     INT,
    name       VARCHAR(255),
    salary     INT,
    supervisor INT,
    PRIMARY KEY (emp_id)
);
INSERT INTO employee
    (emp_id, name, salary, supervisor)
VALUES (1, 'John', 1000, 3),
    (2, 'Dan', 2000, 3),
    (3, 'Brad', 4000, NULL),
    (4, 'Thomas', 4000, 3);
SELECT *
FROM employee;

# [SETTING]
USE practice;
DROP TABLE bonus;
CREATE TABLE bonus
(
    emp_id INT,
    bonus  INT,
    PRIMARY KEY (emp_id)
);
INSERT INTO bonus
    (emp_id, bonus)
VALUES (2, 500),
    (4, 2000);
SELECT *
FROM bonus;

# [코드 2-3] LEFT OUTER JOIN 문제 2 중간 코드
SELECT
	e.name,
	e.supervisor,
	e.salary,
	e.emp_id,
	b.emp_id,
	b.bonus
FROM employee AS e
LEFT OUTER JOIN bonus AS b
ON e.emp_id = b.emp_id;

# [코드 2-4] LEFT OUTER JOIN 문제 2 최종 코드
SELECT
	e.name,
	b.bonus
FROM employee AS e
LEFT OUTER JOIN bonus AS b
ON e.emp_id = b.emp_id
WHERE (b.bonus < 1000 OR b.bonus IS NULL); /* IFNULL(b.bonus, 0) < 1000와 동일 */

# [코드 2-5] LEFT OUTER JOIN 문제 2 오답 코드
SELECT
	e.name,
	e.supervisor,
	e.salary,
	e.emp_id,
	b.emp_id,
	b.bonus
FROM employee AS e
LEFT OUTER JOIN bonus AS b
ON e.emp_id = b.emp_id
WHERE b.bonus < 1000;

# [코드 2-6] LEFT OUTER JOIN 문제 2 오답 코드
SELECT
	e.name,
	e.supervisor,
	e.salary,
	e.emp_id,
	b.emp_id,
	b.bonus
FROM employee AS e
LEFT OUTER JOIN bonus AS b
ON e.emp_id = b.emp_id
	AND b.bonus < 1000;

# [코드 2-7] LEFT OUTER JOIN 문제 2 중간 코드
SELECT *
FROM employee
WHERE emp_id NOT IN (
	SELECT
		emp_id
	FROM bonus
	WHERE bonus >= 1000
);

# [코드 2-8] LEFT OUTER JOIN 문제 2 오답 코드
SELECT *
FROM employee
WHERE emp_id IN (
	SELECT
		emp_id
	FROM bonus
	WHERE bonus < 1000
);

# [코드 2-9] LEFT OUTER JOIN 문제 2 최종 코드
SELECT
    e.name,
    b.bonus
FROM (
	SELECT
		emp_id,
		name
	FROM employee
	WHERE emp_id NOT IN (
		SELECT
			emp_id
		FROM bonus
		WHERE bonus >= 1000
	)
) AS e
LEFT OUTER JOIN bonus AS b
ON e.emp_id = b.emp_id;

# [코드 2-10] LEFT OUTER JOIN의 INNER JOIN화 코드
SELECT *
FROM A
LEFT OUTER JOIN B
ON A.id = B.id
WHERE B.some_column < 100;
