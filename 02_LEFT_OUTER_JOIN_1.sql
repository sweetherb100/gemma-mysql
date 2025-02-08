/*
[질문]
person 테이블에 있는 사람의 이름(first_name), 성(last_name), 도시(city) 및 주(state)를 조회하는 SQL 쿼리를 작성합니다.
address 테이블에 person_id의 주소가 없으면, 해당 주소는 NULL로 표시합니다.
*/

# [SETTING]
USE practice;
DROP TABLE person;
CREATE TABLE person
(
    person_id  INT,
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    PRIMARY KEY(person_id)
);
INSERT INTO person
    (person_id, first_name, last_name)
VALUES (1, 'Allen', 'Wang'),
	(2, 'Bob', 'Smith');
SELECT *
FROM person;

# [SETTING]
USE practice;
DROP TABLE address;
CREATE TABLE address
(
    address_id INT,
    person_id INT,
    city      VARCHAR(255),
    state     VARCHAR(255),
    PRIMARY KEY(address_id)
);
INSERT INTO address
    (address_id, person_id, city, state)
VALUES (1, 2, 'New York City', 'New York'),
	(2, 3, 'Los Angeles', 'California');
SELECT *
FROM address;

# [코드 2-1] LEFT OUTER JOIN 문제 1 중간 코드
SELECT
	p.first_name,
	p.last_name,
	p.person_id,
	a.person_id,
	a.address_id,
	a.city,
	a.state
FROM person AS p
LEFT OUTER JOIN address AS a
ON p.person_id = a.person_id;

# [코드 2-2] LEFT OUTER JOIN 문제 1 최종 코드
SELECT
    p.first_name,
    p.last_name,
    a.city,
    a.state
FROM person AS p
LEFT OUTER JOIN address AS a
ON p.person_id = a.person_id; 