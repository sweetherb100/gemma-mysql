/*
[질문]
각 직원(employee_id)의 보너스(bonus)를 조회하는 SQL 쿼리를 작성합니다.
employee_id를 기준으로 오름차순으로 정렬합니다. 보너스는 다음 규칙에 따라 계산됩니다.
- 직원 ID가 홀수이고 직원 이름(name)이 'M' 문자로 시작하지 않는 경우, 보너스는 소득(salary)의 100%입니다.
- 그 외에 나머지 모든 직원의 보너스는 0입니다.
*/

# [SETTING]
USE practice;
DROP TABLE employees;
CREATE TABLE employees
(
    employee_id INT,
    name        VARCHAR(30),
    salary      INT,
    PRIMARY KEY(employee_id)
);
INSERT INTO employees
    (employee_id, name, salary)
VALUES (2, 'Meir', 3000),
    (3, 'Michael', 3800),
    (7, 'Addilyn', 7400),
    (8, 'Juan', 6100),
    (9, 'Kannon', 7700);
SELECT *
FROM employees; 

# [코드 9-7] MOD 코드
SELECT
	MOD(10, 3) AS remainder;
    
# [코드 9-8] MOD로 짝수, 홀수 판별 코드
SELECT 
    employee_id,
    CASE 
        WHEN MOD(employee_id, 2) = 1 THEN 'Odd'
        ELSE 'Even'
    END AS odd_even_flag
FROM employees;

# [코드 9-9] SUBSTR 코드
SELECT
	SUBSTR('Hello, World!', 8, 5) AS substring;

# [코드 9-10] SUBSTR로 첫 글자 추출 코드
SELECT
	name,
    SUBSTR(name, 1, 1) AS first_letter
FROM employees;

# [코드 9-11] CASE WHEN 문제 2 최종 코드
SELECT
    employee_id,
    CASE
		WHEN MOD(employee_id, 2) = 1 AND SUBSTR(name, 1, 1) != 'M' THEN salary
        ELSE 0
	END AS bonus
FROM employees
ORDER BY employee_id; 