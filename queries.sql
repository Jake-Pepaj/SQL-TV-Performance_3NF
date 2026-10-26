ALTER TABLE Performance
ADD CONSTRAINT chk_market_rating CHECK (market_rating >= 0 AND market_rating <= 10);
ALTER TABLE Seasons
ADD CONSTRAINT chk_episode_count CHECK (episode_count >= 1);
ALTER TABLE Performance
ADD CONSTRAINT chk_minutes_watched CHECK (minutes_watched >= 0);

-- #1 Basic Filter/Order Query
Select show_id, platform_id, est_cost_millions
from Licensing
where est_cost_millions < 5
order by est_cost_millions asc;
"show_id" "platform_id" "est_cost_millions"
103 4 0.50
102 1 2.00
108 1 3.00
113 3 4.00
-- #2 Join Query pt 1
Select l.show_id, l.expiration_date, p.market_rating
from licensing l
inner join performance p on l.show_id = p.show_id
order by l.expiration_date asc
"show_id" "expiration_date" "market_rating"
109 "2024-12-31" 9.0
103 "2025-10-15" 7.0
108 "2025-12-31" 8.7
102 "2026-06-30" 9.1
114 "2026-11-20" 9.5
113 "2027-08-30" 8.2
101 "2027-12-31" 9.2
111 "2028-06-15" 8.8
106 "2029-05-20" 8.9
105 "2030-01-01" 8.7
115 "2030-07-01" 8.7
107 "2032-01-01" 8.7
-- #2pt2 Join
Select s.title, s.original_platform_id, p.completion_rate
from shows s
inner join performance p on s.show_id = p.show_id
where s.status = 'Ongoing'
order by p.completion_rate desc;
"title" "original_platform_id" "completion_rate"
"Severance" 7 "96%"
"The Last of Us" 4 "95%"
"The Bear" 3 "94%"
"House of the Dragon" 4 "92%"
"Demon Slayer" 2 "89%"
"The Boys" 6 "87%"
"One Piece" 2 "85%"
"Abbott Elementary" 3 "81%"
"Black Mirror" 1 "72%"
-- #3 Aggregation Query w Group By
Select p.platform_id, p.name, p.monthly_price, Count(*) as num_shows
from platforms p
inner join shows s on p.platform_id = s.original_platform_id
group by p.platform_id, p.name, p.monthly_price
order by num_shows desc;
"platform_id" "name""monthly_price" "num_shows"
4 "Max" "$15.99" 4
2 "Crunchyroll" "$7.99"3
1 "Netflix" "$15.49" 3
6 "Amazon Prime" "$14.99" 2
3 "Hulu" "$14.99" 2
7 "Apple TV+" "$9.99"1
-- #4 Subquery
Select s.title
from Shows s
Where s.show_id in (select l.show_id
from licensing l
where l.expiration_date < '2026-01-01'
)
"title"
"Sinister"
"Demon Slayer"
"The Office"
-- Step 1: Fix Performance.market_rating (clean values, safe to cast directly)
ALTER TABLE Performance
ALTER COLUMN market_rating TYPE NUMERIC
USING REPLACE(market_rating, '%', '')::NUMERIC;
-- Step 2: Rename the column first
ALTER TABLE Licensing
RENAME COLUMN est_cost TO est_cost_millions;
-- Step 3: Cast to numeric, stripping the symbols during conversion
ALTER TABLE Licensing
ALTER COLUMN est_cost_millions TYPE NUMERIC(8,2)
USING (
CASE
WHEN est_cost_millions LIKE '%M' THEN REPLACE(REPLACE(est_cost_millions, '$', ''),
'M', '')::NUMERIC
WHEN est_cost_millions LIKE '%K' THEN REPLACE(REPLACE(est_cost_millions, '$', ''), 'K',
'')::NUMERIC / 1000
END
);
– #5
SELECT
p.show_id,
p.market_rating,
l.est_cost_millions,
l.expiration_date
FROM performance p
INNER JOIN licensing l ON p.show_id = l.show_id
WHERE p.market_rating > (SELECT AVG(p2.market_rating) FROM performance p2)
AND l.est_cost_millions < (SELECT AVG(l2.est_cost_millions) FROM licensing l2)
ORDER BY l.expiration_date ASC;
"show_id" "market_rating" "est_cost_millions" "expiration_date"
108 8.7 3.00 "2025-12-31"
108 8.7 1.50 "2026-03-14"
102 9.1 2.00 "2026-06-30"
101 9.2 5.00 "2027-12-31"
101 9.2 1.00 "2028-01-01"
107 8.7 9.00 "2032-01-01"
