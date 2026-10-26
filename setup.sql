CREATE TABLE Platforms (
platform_id INT PRIMARY KEY,
name VARCHAR(20),
monthly_price VARCHAR(10)
);
CREATE TABLE Shows (
show_id INT PRIMARY KEY,
title VARCHAR(30),
genre VARCHAR(20),
original_platform_id INT,
status VARCHAR(50),
FOREIGN KEY (original_platform_id) REFERENCES Platforms(platform_id)
);
CREATE TABLE Seasons (
season_id INT PRIMARY KEY,
show_id INT,
season_number INT,
episode_count INT,
release_date VARCHAR(15),
FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);
CREATE TABLE Performance (
perf_id INT PRIMARY KEY,
show_id INT,
minutes_watched INT,
completion_rate VARCHAR(5),
market_rating VARCHAR(5),
FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);
CREATE TABLE Licensing (
deal_id INT PRIMARY KEY,
show_id INT,
platform_id INT,
expiration_date VARCHAR(15),
est_cost VARCHAR(10),
FOREIGN KEY (show_id) REFERENCES Shows(show_id),
FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id)
);

INSERT INTO Platforms (platform_id, name, monthly_price) VALUES
(1, 'Netflix', '$15.49'),
(2, 'Crunchyroll', '$7.99'),
(3, 'Hulu', '$14.99'),
(4, 'Max', '$15.99'),
(5, 'Disney+', '$13.99'),
(6, 'Amazon Prime', '$14.99'),
(7, 'Apple TV+', '$9.99');
INSERT INTO Shows (show_id, title, genre, original_platform_id, status) VALUES
(101, 'One Piece', 'Anime', 2, 'Ongoing'),
(102, 'Hunter x Hunter', 'Anime', 2, 'Hiatus'),
(103, 'Sinister', 'Horror', 4, 'Released'),
(104, 'The Bear', 'Drama', 3, 'Ongoing'),
(105, 'Stranger Things', 'Sci-Fi', 1, 'Final Season'),
(106, 'Succession', 'Drama', 4, 'Ended'),
(107, 'Severance', 'Thriller', 7, 'Ongoing'),
(108, 'Demon Slayer', 'Anime', 2, 'Ongoing'),
(109, 'The Office', 'Comedy', 6, 'Ended'),
(110, 'House of the Dragon', 'Fantasy', 4, 'Ongoing'),
(111, 'The Last of Us', 'Drama', 4, 'Ongoing'),
(112, 'Black Mirror', 'Sci-Fi', 1, 'Ongoing'),
(113, 'Abbott Elementary', 'Comedy', 3, 'Ongoing'),
(114, 'Breaking Bad', 'Drama', 1, 'Ended'),
(115, 'The Boys', 'Action', 6, 'Ongoing');
INSERT INTO Seasons (season_id, show_id, season_number, episode_count, release_date)
VALUES
(1, 101, 1, 61, '1999-10-20'),
(2, 101, 20, 14, '2024-01-07'),
(3, 102, 1, 148, '2011-10-02'),
(4, 104, 1, 8, '2022-06-23'),
(5, 104, 2, 10, '2023-06-22'),
(6, 105, 1, 8, '2016-07-15'),
(7, 105, 4, 9, '2022-05-27'),
(8, 106, 1, 10, '2018-06-03'),
(9, 106, 4, 10, '2023-03-26'),
(10, 107, 1, 9, '2022-02-18'),
(11, 108, 1, 26, '2019-04-06'),
(12, 109, 1, 6, '2005-03-24'),
(13, 109, 2, 22, '2005-09-20'),
(14, 110, 1, 10, '2022-08-21'),
(15, 111, 1, 9, '2023-01-15'),
(16, 114, 1, 7, '2008-01-20'),
(17, 115, 1, 8, '2019-07-26');
INSERT INTO Performance (perf_id, show_id, minutes_watched, completion_rate,
market_rating) VALUES
(501, 101, 950000, '85%', '9.2'),
(502, 102, 720000, '91%', '9.1'),
(503, 103, 45000, '78%', '7.0'),
(504, 104, 320000, '94%', '8.6'),
(505, 105, 890000, '88%', '8.7'),
(506, 106, 540000, '82%', '8.9'),
(507, 107, 210000, '96%', '8.7'),
(508, 108, 630000, '89%', '8.7'),
(509, 109, 1200000, '65%', '9.0'),
(510, 110, 780000, '92%', '8.5'),
(511, 111, 620000, '95%', '8.8'),
(512, 112, 410000, '72%', '8.0'),
(513, 113, 280000, '81%', '8.2'),
(514, 114, 1100000, '98%', '9.5'),
(515, 115, 590000, '87%', '8.7');
INSERT INTO Licensing (deal_id, show_id, platform_id, expiration_date, est_cost) VALUES
(901, 101, 1, '2027-12-31', '$5M'),
(903, 102, 1, '2026-06-30', '$2M'),
(904, 103, 4, '2025-10-15', '$500K'),
(905, 105, 1, '2030-01-01', '$20M'),
(906, 106, 4, '2029-05-20', '$15M'),
(907, 109, 2, '2024-12-31', '$10M'),
(909, 111, 4, '2028-06-15', '$18M'),
(910, 114, 1, '2026-11-20', '$25M'),
(911, 115, 6, '2030-07-01', '$14M'),
(912, 108, 1, '2025-12-31', '$3M'),
(914, 113, 3, '2027-08-30', '$4M'),
(915, 107, 7, '2032-01-01', '$9M');
– Index
Create Index idx_show_expiration
On licensing(show_id, expiration_date);
