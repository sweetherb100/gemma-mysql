/*
[질문]
각 입력값에 대해 quality와 poor rating percentage를 조회하는 SQL 쿼리를 작성합니다.
quality는 rating/position의 평균입니다.
poor rating percentage는 3 미만 rating의 백분율입니다.
결과는 소수점 두 자리까지 반올림합니다.
*/

# [SETTING]
USE practice;
DROP TABLE model;
CREATE TABLE model
(
    input VARCHAR(30),
    output     VARCHAR(50),
    position   INT,
    rating     INT,
    PRIMARY KEY(input, output)
);
INSERT INTO model
    (input, output, position, rating)
VALUES ('Dog', 'Golden Retriever', 1, 5),
    ('Dog', 'German Shepherd', 2, 5),
    ('Dog', 'Donkey', 200, 1),
    ('Cat', 'Persian', 5, 2),
    ('Cat', 'Siamese', 3, 3),
    ('Cat', 'Sphynx', 7, 4);
SELECT *
FROM model; 

# [코드 5-2] GROUP BY 문제 2 최종 코드
SELECT
    input,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS poor_rating_percentage
FROM model
GROUP BY input; 
