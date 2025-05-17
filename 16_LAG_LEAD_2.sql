/*
어제에 비해 기온(temperature)이 더 높은 날의 날짜 ID(weather_id)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE weather;
CREATE TABLE weather
(
    weather_id    INT,
    record_date   DATE,
    temperature   INT,
    PRIMARY KEY(weather_id)
);
INSERT INTO weather
    (weather_id, record_date, temperature)
VALUES (1, '2024-01-01', 10),
    (2, '2024-01-02', 25),
    (3, '2024-01-03', 20),
    (4, '2024-01-04', 30),
    (5, '2024-01-14', 5),
    (6, '2024-01-16', 7);
SELECT *
FROM weather; 

# [코드 16-5] LAG, LEAD 문제 2 중간 코드
SELECT
    weather_id,
    record_date,
    temperature,
    LAG(record_date) OVER (ORDER BY record_date) AS pre_rd, /* 각 날짜의 이전 날짜 */
    LAG(temperature) OVER (ORDER BY record_date) pre_t /* 각 날짜의 이전 기온 */
FROM weather
ORDER BY record_date;
        
# [코드 16-6] LAG, LEAD 문제 2 최종 코드
SELECT
    weather_id
FROM
(
SELECT
		weather_id,
		record_date,
		temperature,
		LAG(record_date) OVER (ORDER BY record_date) AS pre_rd,  /* 각 날짜의 이전 날짜 */
		LAG(temperature) OVER (ORDER BY record_date) AS pre_t /* 각 날짜의 이전 기온 */
	FROM weather
) AS a
WHERE pre_t < temperature
AND pre_rd = DATE_SUB(record_date, INTERVAL 1 DAY);

# [코드 16-7] LAG, LEAD 문제 2 오답 코드
SELECT
    *
FROM
(
SELECT
		weather_id,
		record_date,
		temperature,
		LAG(record_date) OVER (ORDER BY record_date) AS pre_rd,  /* 각 날짜의 이전 날짜 */
		LAG(temperature) OVER (ORDER BY record_date) AS pre_t /* 각 날짜의 이전 기온 */
	FROM weather
) AS a
WHERE pre_t < temperature;

# [코드 16-8] LAG, LEAD 문제 2 중간 코드
SELECT w1.weather_id,
w1.record_date,
w1.temperature,
w2.record_date AS yesterday_rd,
w2.temperature AS yesterday_t
FROM weather AS w1
INNER JOIN weather AS w2
ON DATE_SUB(w1.record_date, INTERVAL 1 DAY) = w2.record_date;

# [코드 16-9] LAG, LEAD 문제 2 최종 코드
SELECT w1.weather_id
FROM weather AS w1
INNER JOIN weather AS w2
ON DATE_SUB(w1.record_date, INTERVAL 1 DAY) = w2.record_date
WHERE w1.temperature > w2.temperature;