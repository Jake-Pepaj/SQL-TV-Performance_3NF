# SQL-TV-Performace_3NF

Overview

Streaming services are in constant competition to acquire, renew, and retain top-performing media assets. This project features a 3NF relational database designed to track streaming platform performance, licensing costs, and viewership metrics. The database allows analysts to monitor the performance of shows across different services, evaluate completion rates for renewal decisions, and identify high-value acquisition targets based on expiring licenses and market ratings.

Database Schema (3NF)

The relational design ensures accurate tracking of viewership and licensing agreements through a central show_id relationship:

- Platforms: platform_id (PK), name, monthly_price

- Shows: show_id (PK), title, genre, original_platform_id (FK), status

- Seasons: season_id (PK), show_id (FK), season_number, episode_count, release_date

- Performance: perf_id (PK), show_id (FK), minutes_watched, completion_rate, market_rating

- Licensing: deal_id (PK), show_id (FK), platform_id (FK), expiration_date, est_cost_millions

Entity Relationships

- Shows to Platforms (M:1): Each show links to its source platform.

- Seasons to Shows (M:1): Each season entry links to its parent series.

- Performance to Shows (M:1): Viewership metrics and ratings are assigned to specific titles.

- Licensing to Shows (1:1): Every licensing agreement is tied to a specific title.

- Licensing to Platforms (M:1): Every licensing agreement is tied to a distribution service.

Business Analytics & Key SQL Queries

The database was queried to simulate real-world streaming industry decisions. The queries.sql file contains the logic for the following business use cases:

1. Budget Acquisition Targeting: Filters for shows with an estimated licensing value under $5 million to identify budget-friendly acquisition opportunities.

2. Expiring License Monitoring: Joins the Performance and Licensing tables to identify highly-rated shows with licenses that are expired or close to expiring.

3. Renewal Viability Analysis: Evaluates the completion_rate of ongoing shows by joining Performance on Shows to determine how many viewers are fully caught up, driving season renewal decisions.

4. Platform Content Volume: Aggregates and counts the total number of shows per platform (joining Shows and Platforms) to identify which services are overcharging relative to their content library size.

5. High-Value Asset Discovery: Utilizes nested subqueries and the AVG() aggregate function to project shows that perform strictly above the market average in rating, while costing below the market average in licensing fees.

Data Normalization & Schema Migration

During development, initial flat-file imports resulted in numerical data (market ratings, estimated costs) being stored as VARCHAR strings containing symbols (e.g., '%', '$', 'M'). To enable complex mathematical querying, the database required a structural migration.

Authored ALTER TABLE statements to strip non-numeric characters and successfully cast the columns to NUMERIC(8,2) types, ensuring data integrity and enabling advanced aggregate analytics.
