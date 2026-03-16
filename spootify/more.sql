-- Find total streams for each album.

SELECT
    album,
    SUM(stream) as total_stream
FROM
    spootify
GROUP BY    
    album
ORDER BY
    total_stream
    DESC
LIMIT 100;

-- Find artists whose average energy > 0.7.
SELECT
    artist,
    AVG(energy) as avg_energy
FROM
    spootify
GROUP BY
    artist
HAVING
    AVG(energy) >0.7
ORDER BY 
    avg_energy DESC
LIMIT 10

-- Rank tracks by views.
SELECT
    artist,
    album,
    track,
    views,
    RANK () OVER (ORDER BY views DESC)
FROM
    spootify
LIMIT 10


--Find top 3 most viewed tracks per artist.
SELECT *
FROM(
    SELECT
        artist,
        track,
        views,
        RANK() OVER (
                PARTITION BY artist
                ORDER BY views DESC) as rank
    FROM
        spootify
    )
WHERE
    rank <=3
LIMIT 30


--Rank tracks inside each album by streams.
SELECT
    album,
    tracks,
    streams,
    RANK() OVER (PARTITION BY album
                 ORDER BY stream DESC   
                ) as rankings
FROM 
    spootify;


    --Find the second most viewed track per artist.
SELECT 
    track,
    artist,
    views
FROM (
    SELECT
        track,
        artist,
        views,
        RANK() OVER (PARTITION BY artist
                    ORDER BY views DESC    
                    ) as views_rank
    FROM    
        spootify
    )
WHERE 
    views_rank = 2
LIMIT 10;

    
--tracks where likes are greater than the average likes of that artist.
SElECT
    artist,
    track,
    likes
FROM
    spootify s1
WHERE
    likes > (
        SELECT 
           ROUND (AVG(likes),2) as likes_avg
        FROM
            spootify 
        WHERE 
            artist=s1.artist
    ) 
    LIMIT 10;
-- or--

SELECT *
FROM (
    SELECT
        artist,
        track,
        likes,
        ROUND(AVG(likes) OVER (PARTITION BY artist),2) as like_avg
    FROM
        spootify
    )
WHERE 
    likes>like_avgs

limit 10

--albums whose total streams are above the global average album streams.
/*WITH albums as (
            SELECT 
                artist,
                album,
                SUM(stream) as album_total
            FROM
                spootify
            GROUP BY
                album,artist
                ),
WITH global as 
            (
                SELECT
                AVG(stream) as global_avg
            FROM
                spootify
            )
SELECT
    artist,
    album
FROM
    spootify
WHERE
    album_total>global_avg
LIMIT 10*/

SELECT
    artist,
    album,
    SUM(stream) as total
FROM
    spootify 
GROUP BY
    artist,album
HAVING
    SUM(stream)>
        (
            SELECT
                AVG(stream)
            FROM
                spootify
        )

--cumulative stream per artist order by views

SELECT
    artist,
    track,
    views,
    SUM(stream) OVER (PARTITION BY artist
                      ORDER  BY views) as cum_stream
FROm
    spootify
    LIMIT 100;

--Show running average of views for each artist.

SELECT
    artist,
    track,
    views,
    AVG(views) OVER (PARTITION BY artist
                     ORDER BY views
                     ROWS BETWEEN UNBOUNDED PrECEDING AND CURRENT Row) as running_avg
FROM
    spootify
ORDER BY artist, views;


--Show difference in views from previous track.

SELECT
    artist,
    track,
    views,
    LAG(views,1,0) OVER (PARTITION BY artist
                     ORDER BY views) as prev_views, 
    views-LAG(views,1,0) OVER (PARTITION BY artist
                            ORDER BY views) as views_diff
FROM
    spootify;
 

--  tracks where views increased compared to the previous track of that artist.

SELECT * 
FROM(
    SELECT 
        artist,
        track,
        views,
        LAG(views) OVER (PARTITION BY artist) as prev_views
    FROM
        spootify
        limit 20
    )
WHERE
    views > prev_views
LIMIT 50;