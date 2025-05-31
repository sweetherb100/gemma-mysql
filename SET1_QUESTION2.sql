/*
[질문]
부하 직원이 5명 이상인 관리자 이름(name)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE employee;
CREATE TABLE employee (
  id INT,
  name VARCHAR(255),
  manager_id INT,
  PRIMARY KEY (id)
);
INSERT INTO
  employee (id, name, manager_id)
VALUES (101, 'John', NULL),
  (102, 'Dan', 101),
  (103, 'James', 101),
  (104, 'Amy', 101),
  (105, 'Anne', 101),
  (106, 'Ron', 101);
SELECT *
FROM employee;

# [코드 세트 1-3] 중간 코드
SELECT
	manager_id,
	COUNT(*),
	COUNT(manager_id)
FROM employee
GROUP BY manager_id;

# [코드 세트 1-4] 최종 코드
SELECT name
FROM employee
WHERE id IN (
    SELECT manager_id
    FROM employee
    GROUP BY manager_id
    HAVING COUNT(manager_id) >= 5
);