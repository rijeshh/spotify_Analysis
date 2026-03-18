-- Find the most popular track per album based on views.
SELECT *
FROM(
    SELECT
        artist,
        track,
        album,
        views,
        -- RANK() OVER (PARTITION BY album
        --             ORDER BY views DESC) as most_viewed  ///// gives 2 ranks same if numbers are same
        ROW_NUMBER() OVER (PARTITION BY album
                    ORDER BY views DESC) as most_viewed    -- solves the rank limitation by giving 2 separate
                                                           -- ranks even if no.s are same
    FROM
        spootify
    ) window
WHERE 
    most_viewed = 1
LIMIT 20;


--tracks where danceability is above the album average.
SELECT
    *
FROM(
    SELECT
        artist,
        track,
        album,
        danceability,
        AVG(danceability) OVER (PARTITION BY album) as avg_dance
    FROM
        spootify
    )
WHERE
    danceability > avg_dance
LIMIT 20;

--albums where the difference between highest and lowest views is largest.

WITH diff as (
        SELECT 
            artist,
            album,
            MAX(views) as highest,
            MIN(views) as lowest
        FROM
            spootify
        GROUP BY 
            artist,album

    )

SELECT 
    artist,
    album,
    highest,
    lowest,
    highest-lowest as view_diff
FROM
    diff
ORDER BY 
    view_diff
    DESC
-- LIMIT 100;

select
    artist,
    album,
    album_type,
    count(*) OVER (PARTITION BY album) as count
From 
    spootify
order by count