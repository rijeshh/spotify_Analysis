--- avg danceability of track in each album---------------
SELECT
    album,
   AVG(danceability) as avg_danceability
FROM
    spootify
GROUP BY album;


-- total views of all associated track for each album
SELECT 
    album ,
    SUM (views) as total_views
FROM
    spootify
GROUP BY 
    album
ORDER BY 
    total_views DESC;



--top 3 viewed track for each artist


SELECT *
FROM (
    SELECT
        artist,
        track,
        RANK() OVER (PARTITION BY artist ORDER BY views) as rankk
    FROM 
        spootify
    )
WHERE 
    rankk <=3;


-- track where liveness is over average -------------------

-- can be done in 3 ways----


--first by using Correlated  Sub query
SELECT
    artist,
    track,
    liveness
FROM
    spootify s1
WHERE
    liveness>(
        SELECT
           AVG(liveness)
        FROM
            spootify s2
        WHERE
            s2.artist=s1.artist
    );


-- 2nd Better way using  window function

SELECT
    *
FROM
    (
        SELECT 
            artist,
            track,
            liveness,
            AVG(liveness) OVER (PARTITION BY artist) AS avg_liveness
        FROM
            spootify
    )
WHERE
    liveness > avg_liveness
    limit 10;


-- Lastly using CTE
 
WITH ranking as (
    SELECT
        track,
        liveness,
        AVG(liveness) OVER (
            PARTITION BY artist
        ) AS avg_liveness
    FROM 
        spootify
)
SELECT *
FROM
    ranking
WHERE liveness>avg_liveness





--===== using CTE Diff between the highest and lowest energy value for track in each album
WITH high_low as
            (
                SELECT 
                    album,
                    MAX(energy) as high,
                    MIN(energy) as low
                FROM 
                    spootify
                GROUP BY
                    album    
            )
SELECT
    album,
    ROUND((high-low)::NUMERIC,2) as live_diff --round () is picky and expects a numeric data type 
                                             -- but energy is double precision i.e float so it must be
                                            --  converted to integer (numeric) by ::numeric           
FROM    
    high_low
WHERE
    (high-low) >0


-- can be done without using CTE too
SELECT
    album,
    MAX(energy) - MiN(energy) as live_diff
FROM
    spootify
GROUP BY 
    album;



-- Q. Track where the energy to liveness ration is > 1.2
SELECT *
FROM(
    SELECT
        track,
        album,
        energy,
        liveness,
        ROUND((energy / liveness) ::numeric,2) as ratio       
    FROM    
        spootify 
    ) t                                -- good practice of giving alias to a subquery in postgres 
WHERE
ratio > 1.2

-- -Without any subquery

SELECT
    artist,
    track,
    energy,
    liveness,
    ROUND((energy / liveness)::numeric, 2) AS ratio
FROM spootify
WHERE (energy / liveness) > 1.2;


-- Q. cumulative sum of likes for track order by no. of views

SELECT
    artist,
    track,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spootify;