/*
[질문]
각 기계(machine_id)가 프로세스를 완료하는데 걸리는 평균 시간(processing_time)을 조회하는 SQL 쿼리를 작성합니다. 
*/

# [SETTING]
USE practice;
DROP TABLE activity;
CREATE TABLE activity
(
    machine_id    INT,
    process_id    INT,
    activity_type ENUM ('start', 'end'),
    timestamp     FLOAT(10, 3),
    PRIMARY KEY(machine_id, process_id, activity_type)
);
INSERT INTO activity
    (machine_id, process_id, activity_type, timestamp)
VALUES (0, 0, 'start', 0.712),
    (0, 0, 'end', 1.52),
    (0, 1, 'start', 3.14),
    (0, 1, 'end', 4.12),
    (1, 0, 'start', 0.55),
    (1, 0, 'end', 1.55),
    (1, 1, 'start', 0.43),
    (1, 1, 'end', 1.42),
    (2, 0, 'start', 4.1),
    (2, 0, 'end', 4.512),
    (2, 1, 'start', 2.5),
    (2, 1, 'end', 5);
SELECT *
FROM activity; 

# [코드 9-1] CASE WHEN 문제 1 중간 코드
SELECT
    machine_id,
    SUM(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_sum,
    SUM(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_sum
FROM activity
GROUP BY machine_id; 

# [코드 9-2] CASE WHEN 문제 1 최종 코드
SELECT
    machine_id,
    ROUND((SUM(CASE WHEN activity_type = 'end' THEN timestamp END) - SUM(CASE WHEN activity_type = 'start' THEN timestamp END))
    / COUNT(DISTINCT process_id), 3) AS processing_time
FROM activity
GROUP BY machine_id; 

# [코드 9-3] CASE WHEN 문제 1 최종 코드
SELECT
	machine_id,
    ROUND(SUM(CASE WHEN activity_type = 'end' THEN timestamp ELSE -timestamp END)
             /COUNT(CASE WHEN activity_type = 'end' THEN 1 END), 3) AS processing_time
FROM activity
GROUP BY machine_id;

# [코드 9-4] CASE WHEN 문제 1 최종 코드
SELECT
    machine_id,
    ROUND((SUM(IF(activity_type = 'end', timestamp, 0)) - SUM(IF(activity_type = 'start', timestamp, 0)))
    / COUNT(DISTINCT process_id), 3) AS processing_time
FROM activity
GROUP BY machine_id;

# [코드 9-5] IF 코드
SELECT
    machine_id,
    timestamp,
    IF(timestamp > 1, 'High', 'Low') AS timestamp_level
FROM activity
WHERE machine_id = 1
ORDER BY timestamp DESC;

# [코드 9-6] CASE WHEN 코드
SELECT
    machine_id,
    timestamp,
        CASE
        WHEN timestamp > 1.5 THEN 'Very High'
        WHEN timestamp > 1.4 THEN 'High'
        WHEN timestamp > 0.5 THEN 'Medium'
        ELSE 'Low'
    END AS timestamp_level
FROM activity
WHERE machine_id = 1
ORDER BY timestamp DESC;