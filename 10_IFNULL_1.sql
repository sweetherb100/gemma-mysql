/*
[질문]
각 사용자(name)가 이동한 거리(traveled_distance)를 조회하는 SQL 쿼리를 작성합니다.
traveled_distance 기준으로 내림차순으로 정렬하고, 두 명 이상의 사용자가 동일한 거리를 이동한 경우 이름을 기준으로 오름차순으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE users;
CREATE TABLE users
(
    id   INT,
    name VARCHAR(30),
    PRIMARY KEY (id)
);
INSERT INTO users
    (id, name)
VALUES (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');
SELECT *
FROM users; 

# [SETTING]
USE practice;
DROP TABLE rides;
CREATE TABLE rides
(
    ride_id  INT,
    user_id  INT,
    distance INT,
    PRIMARY KEY(ride_id)
);
INSERT INTO rides
    (ride_id, user_id, distance)
VALUES ('1', '1', '120'),
    ('2', '2', '317'),
    ('3', '3', '222'),
    ('4', '7', '100'),
    ('5', '13', '312'),
    ('6', '19', '50'),
    ('7', '7', '120'),
    ('8', '19', '400'),
    ('9', '7', '230');
SELECT *
FROM rides; 

# [코드 10-1] IFNULL 문제 1 중간 코드
SELECT
	u.name,
	u.id,
	r.user_id,
	r.distance
FROM users AS u
LEFT OUTER JOIN rides AS r
ON u.id = r.user_id; 

# [코드 10-2] IFNULL 문제 1 중간 코드
SELECT
    u.id,
    COUNT(r.distance) AS count_dist, /* 결과: [Donald] COUNT=0 */
    SUM(r.distance) AS sum_dist, /* 결과: [Donald] SUM=NULL */
    COUNT(u.id) AS count_id       /* 결과: [Donald] COUNT=1 */
FROM users AS u
LEFT OUTER JOIN rides AS r
ON u.id = r.user_id
GROUP BY u.id; 

# [코드 10-3] IFNULL 문제 1 최종 코드
SELECT
    u.name,
    IFNULL(SUM(r.distance), 0) AS traveled_distance
FROM users AS u
LEFT OUTER JOIN rides AS r
ON u.id = r.user_id
GROUP BY u.id, u.name /* u.name만 쓰는 것은 비추천. 동명이인이 나올 수 있기 때문에 */
ORDER BY traveled_distance DESC, name;

# [코드 10-4] IFNULL 문제 1 오답 코드
SELECT
    u.id,
    SUM(r.distance) AS traveled_distance /* 결과: NULL -> 틀림 */
FROM users AS u
LEFT OUTER JOIN rides AS r
ON u.id = r.user_id
GROUP BY u.id
ORDER BY id;

# [코드 10-5] NULL 비교 코드
SELECT
	NULL < 2 AS null_compare,
    0 < 2 AS zero_compare;

# [코드 10-6] NULL 산술 연산 코드
SELECT
	NULL + 2 AS null_arithmetic,
    0 + 2 AS zero_arithmetic;

# [코드 10-7] NULL 논리 연산 코드
SELECT
	NOT NULL AS null_logical,
    NOT 0 AS zero_logical;