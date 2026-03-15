--total_entries

SELECT 
    COUNT(*) as total_entries
FROM 
    spootify

--============ TOTAL ARTISTS ==============

SELECT 
    COUNT (distinct artist) as total_artist 
FROM 
    spootify

--============= category of album type =================



SELECT
     distinct album_type 
FROM 
    spootify



-- ============= total count of each category ===========


SELECT 
    album_type,
    COUNT (*) as album_count
FROM    
    spootify
GROUP BY 
    album_type
ORDER BY 
    album_count 
    DESC




--===== longest content ===========


SELECT
    title,
    duration_min
FROM 
    spootify
WHERE
    duration_min=
    (
        SELECT 
            MAX(duration_min)
        FROM spootify
    )



--========== SHORTEST DURATION =======




SELECT
    title,
    duration_min
FROM 
    spootify
WHERE
    duration_min=
    (
        SELECT 
            MIN(duration_min)
        FROM spootify
    )
        --Two contents are found to be of duration 0 min
        -- that doesnt make any sense so i delete it

    ---- ========== DELETION =============
    DELETE FROM
            spootify
    WHERE           
            duration_min=0
     