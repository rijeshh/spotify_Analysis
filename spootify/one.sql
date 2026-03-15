------------------ track with over 1b views -------------------
SELECT
    track,
    artist,
    album
FROM 
    spootify
WHERE 
    views > 1000000000
ORDER BY 
    views DESC


----------------- ALBUM along with their respective artist ----------

SELECT
    album,
    artist
FROM 
    spootify
WHERE 
    album_type = 'album'

 
--------------------comments where track licensed is true--------------

SELECT
    track,
    album,
    album_type,
FROM
    spootify
WHERE
    licensed is true  



----------- Total tracks by each artist -----------

SELECT 
    artist,
    count(*) as track_count,
FROM 
    spootify
GROUP BY
    artist