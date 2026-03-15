# spotify_Data_Analysis


## Project Overview
This project involves a comprehensive analysis of a Spotify-like dataset (sourced from Kaggle) containing approximately 20,500 entries. The analysis spans across three SQL files, progressing from initial table schema creation and data cleaning to complex analytical queries using Common Table Expressions (CTEs) and Window Functions.

## Dataset Features
The spootify table includes various metrics for music tracks, such as:

Track Metadata: Artist, Track Name, Album, Album Type.

Audio Features: Danceability, Energy, Loudness, Liveness, Acousticness, etc.

Engagement Metrics: Views, Likes, Comments, and Streams.

Technical Details: Duration, Licensed status, and Platform (Most played on).

## File Structure
### 1. table_create.sql
Contains the Data Definition Language (DDL) to set up the environment. It defines the spootify table with appropriate data types (FLOAT for audio features, BIGINT for high-volume engagement metrics like views and likes).

### 2. simple_ana.sql & one.sql (Core Analysis)
This section covers Exploratory Data Analysis (EDA) and fundamental data management:

High-Level Stats: Identifying total tracks, unique artists, and counting tracks per artist.

Popularity Filtering: Retrieving all tracks with over 1 billion views.

Categorization & Licensing: Grouping tracks by album_type and filtering for content based on licensed status.

Data Cleaning: Identification and deletion of records where duration_min is 0 to maintain dataset integrity.

### 3. two.sql (Advanced Analytics)
Features advanced analytical queries to extract deeper insights:

Window Functions: Utilizing RANK() to find the top 3 most viewed tracks for every artist and SUM() OVER() for cumulative like counts.

Comparative Analysis: Comparing track liveness against the artist's average using three different methods: Correlated Subqueries, Window Functions, and CTEs.

Performance Metrics: Calculating energy-to-liveness ratios and finding the energy variance (high vs. low) within specific albums.

PostgreSQL Optimization: Demonstrating the use of ::NUMERIC type casting for precise rounding of floating-point calculations.

## Key SQL Techniques Demonstrated
Aggregations: SUM(), AVG(), COUNT(), MIN(), MAX().

Window Functions: RANK(), SUM() OVER(ORDER BY...), and AVG() OVER(PARTITION BY...).

CTEs & Subqueries: Using Common Table Expressions to simplify complex logic and improve readability.

Data Cleaning: Using DELETE and WHERE clauses to filter out illogical or "noisy" data.

## How to Use
Environment: Designed for PostgreSQL.

Setup: Run table_create.sql to initialize the schema.

Data Load: Import your Kaggle CSV data into the spootify table.

Analysis: Execute the analysis files in sequence to explore and analyze the data.
