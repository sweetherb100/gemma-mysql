/*
[질문]
버스를 타기 위해 사람들이 줄을 서고 있습니다.
다만 버스의 무게 제한은 1000kg이므로 탑승하지 못하는 사람도 있을 수 있습니다.
무게 제한을 초과하지 않고 버스에 탑승할 수 있는 마지막 사람(person_name)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE queue;
CREATE TABLE queue
(
    person_id   INT,
    person_name VARCHAR(30),
    weight      INT,
    turn        INT,
    PRIMARY KEY(person_id)
);
INSERT INTO queue
    (person_id, person_name, weight, turn)
VALUES (5, 'Alice', 250, 1),
    (4, 'Bob', 175, 5),
    (3, 'Alex', 350, 2),
    (6, 'John Cena', 400, 3),
    (1, 'Winston', 500, 6),
    (2, 'Marie', 200, 4);
SELECT *
FROM queue; 

# [코드 8-7] SUM, COUNT 문제 2 중간 코드
SELECT
    turn,
    person_name,
    weight,
    SUM(weight) OVER (ORDER BY turn) AS accumulated_weight
FROM queue
ORDER BY turn; 

# [코드 8-8] SUM, COUNT 문제 2 최종 코드
SELECT
    person_name
FROM (
	SELECT
		person_name,
		SUM(weight) OVER (ORDER BY turn) AS accumulated_weight
	FROM queue
) AS a
WHERE accumulated_weight <= 1000
ORDER BY accumulated_weight DESC
LIMIT 1;

# [코드 8-9] SUM() OVER () 코드
SELECT
    person_name,
    weight,
    SUM(weight) OVER () AS total_weight,
    ROUND(weight/SUM(weight) OVER ()*100, 2) AS weight_percent
FROM queue
ORDER BY turn; 

# [코드 8-10] GROUP BY와 SUM() OVER () 코드
SELECT
    MOD(turn, 2) AS even_odd_index,
    SUM(weight) AS grouped_weight,
    SUM(SUM(weight)) OVER () AS total_weight,
    ROUND(SUM(weight)/SUM(SUM(weight)) OVER ()*100, 2) AS weight_percent
FROM queue
GROUP BY MOD(turn, 2);
