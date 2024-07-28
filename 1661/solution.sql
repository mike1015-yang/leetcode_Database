WITH new_timestamp AS (SELECT machine_id,
                              process_id,
                              activity_type,
                              CASE activity_type WHEN 'start' THEN timestamp*-1
                                                 ELSE timestamp END AS timestamp
                         FROM activity
                        ORDER BY machine_id,
                                 process_id,
                                 activity_type),
     lag_timestamp AS (SELECT machine_id,
                              process_id,
                              timestamp,
                              LAG(timestamp) OVER (PARTITION BY machine_id,process_id) AS lag_timestamp
                         FROM new_timestamp)
SELECT machine_id,
       ROUND(SUM(timestamp+lag_timestamp),3)/COUNT(machine_id) AS processing_time
  FROM lag_timestamp
 WHERE lag_timestamp IS NOT NULL
 GROUP BY machine_id;