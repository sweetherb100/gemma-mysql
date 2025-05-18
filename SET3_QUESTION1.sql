/*
[질문]
직급(employee_title), 성별(gender)별 평균 총보상(avg_compensation)을 조회하는 SQL 쿼리를 작성합니다.
총보상은 각 직원의 급여와 보너스를 더하여 계산합니다.
모든 직원이 보너스를 받는 것은 아니므로 보너스가 없는 직원은 결과에서 제외합니다.
직원은 두 개 이상의 보너스를 받을 수 있습니다.
*/

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee (
  employee_id INT,
  name VARCHAR(255),
  gender ENUM ('M', 'F'),
  employee_title VARCHAR(255),
  salary INT,
  PRIMARY KEY (employee_id)
);
INSERT INTO
  employee (employee_id, name, gender, employee_title, salary)
VALUES (1, 'Allen', 'F', 'Manager', 200000),
	(2, 'Joe', 'M', 'Sales', 1000),
	(3, 'Henry', 'M', 'Senior Sales', 2000),
	(4, 'Sam', 'M', 'Sales', 1000),
	(5, 'Max', 'M', 'Sales', 1300),
	(6, 'Molly', 'F', 'Sales', 1400),
	(7, 'Nicky', 'F', 'Sales', 1400),
	(8, 'John', 'M', 'Senior Sales', 1500),
	(9, 'Monika', 'F', 'Sales', 1000),
	(10, 'Jennifer', 'F', 'Sales', 1000),
	(11, 'Richard', 'M', 'Manager', 250000),
	(12, 'Shandler', 'M', 'Auditor', 1100),
	(13, 'Katty', 'F', 'Manager', 150000),
	(14, 'Jason', 'M', 'Auditor', 1000),
	(15, 'Michael', 'F', 'Auditor', 700),
	(16, 'Celine', 'F', 'Auditor', 1000),
	(17, 'Mike', 'M', 'Senior Sales', 2200);
SELECT *
FROM employee;

# [SETTING]
USE practice;
DROP TABLE bonus;
CREATE TABLE bonus (
  employee_id INT,
  bonus INT
);
INSERT INTO
  bonus (employee_id, bonus)
VALUES (1, 5000),
	(1, 4500),
    (2, 3000),
	(2, 3500),
    (3, 4000),
	(14, 1200),
	(17, 2500);
SELECT *
FROM bonus;

# [코드 SET 3-1] 중간 코드
SELECT *
FROM employee AS t1
INNER JOIN (
    SELECT
      employee_id,
      SUM(bonus) AS bonus
    FROM bonus
    GROUP BY employee_id
) AS t2
ON t1.employee_id = t2.employee_id;
    
# [코드 SET 3-2] 최종 코드
SELECT
  employee_title,
  gender,
  AVG(salary) + AVG(bonus) AS avg_compensation
FROM employee AS t1
INNER JOIN (
    SELECT
      employee_id,
      SUM(bonus) AS bonus
    FROM bonus
    GROUP BY employee_id
) AS t2
ON t1.employee_id = t2.employee_id
GROUP BY employee_title, gender;