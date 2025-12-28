-- CodeChef Database Schema

CREATE TABLE Contests (
  contest_id INT NOT NULL,
  name VARCHAR(20) NOT NULL,
  participants INT NOT NULL,
  date DATE NOT NULL
);

CREATE TABLE Teams (
  team_id INT NOT NULL,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE Users (
  email VARCHAR(40) NOT NULL,
  user_name VARCHAR(20) NOT NULL,
  age INT NOT NULL,
  college VARCHAR(30),
  rating INT NOT NULL,
  contests INT NOT NULL,
  last_contest INT NOT NULL,
  submissions INT NOT NULL,
  team_id INT,
  pro_plan TINYINT(1) NOT NULL
);
-- Contests Data
INSERT INTO Contests VALUES
(1, 'Starters_97', 24256, '2023-07-05'),
(2, 'Starter_92', 24897, '2023-07-01'),
(3, 'Starters_83', 10004, '2023-06-28'),
(4, 'Starters_86', 29049, '2023-06-14'),
(5, 'Starters_79', 24643, '2023-06-10'),
(6, 'MAY LONG TWO 2022', 10975, '2023-05-01'),
(7, 'Starters_75', 28754, '2023-05-10'),
(8, 'Starters_69', 20502, '2023-04-26'),
(9, 'Starters_68', 20502, '2023-04-22'),
(10, 'Starters_65', 24873, '2023-05-03'),
(11, 'Starters_59', 19863, '2023-04-13'),
(12, 'Starters_53', 18904, '2023-04-01'),
(13, 'Starters_52', 18496, '2023-03-25'),
(14, 'Starters_48', 16823, '2023-03-18'),
(15, 'Starters_43', 19574, '2023-03-04'),
(16, 'Starters_42', 19657, '2023-03-01'),
(17, 'Starters_38', 18648, '2023-03-01'),
(18, 'Starters_32', 18478, '2022-12-03'),
(19, 'Starters_31', 20584, '2023-01-25'),
(20, 'February Cookoff', 18475, '2022-02-05');

-- Teams Data
INSERT INTO Teams VALUES
(1,'The_King_Coders'),(2,'Loop_Troops'),(3,'CodeandEat'),
(4,'PicassoCoders'),(5,'Algo Spiderman'),(6,'TheAlgoMasters'),
(7,'OpenWarriors'),(8,'TheAlgoMasters'),(9,'ErrorTerror'),
(10,'ChallengersLion'),(11,'PistaCoders'),(12,'HimalyanMasters'),
(13,'ErrorTerror'),(14,'TheKingKhanGang'),(15,'KeyboardRiders'),
(16,'SystematicLiners'),(17,'LoopInfinity'),(18,'YoungAlgoCoders'),
(19,'SemanticTerror'),(20,'Contestants');
--constraints
ALTER TABLE Contests ADD PRIMARY KEY (contest_id);
ALTER TABLE Teams ADD PRIMARY KEY (team_id);

ALTER TABLE Users
ADD PRIMARY KEY (email),
ADD KEY team_id (team_id),
ADD KEY last_contest (last_contest);

ALTER TABLE Users
ADD CONSTRAINT fk_users_team
FOREIGN KEY (team_id) REFERENCES Teams(team_id);

ALTER TABLE Users
ADD CONSTRAINT fk_users_contest
FOREIGN KEY (last_contest) REFERENCES Contests(contest_id);

COMMIT;
-- Q1: Average rating of all users
SELECT AVG(rating) AS average_rating
FROM Users;

-- Q2: Count users aged between 18 and 24
SELECT COUNT(*) AS user_count
FROM Users
WHERE age BETWEEN 18 AND 24;

-- Q3: Top 2 users by rating
SELECT user_name, rating
FROM Users
ORDER BY rating DESC
LIMIT 2;

-- Q4: Percentage of users with rating >= 2200
SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Users
WHERE rating >= 2200;

-- Q5: Sum of ratings for pro users
SELECT SUM(rating) AS pro_peoples
FROM Users
WHERE pro_plan = 1;

-- Q6: Team-wise user count (non-zero only)
SELECT T.name AS team_name, COUNT(U.user_name) AS user_count
FROM Teams T
JOIN Users U ON T.team_id = U.team_id
GROUP BY T.name
ORDER BY team_name;

-- Q7: Highest rated users per college
SELECT college, user_name
FROM Users
WHERE (college, rating) IN (
  SELECT college, MAX(rating)
  FROM Users
  GROUP BY college
);

-- Q8: College-wise user count
SELECT college, COUNT(*) AS user_count
FROM Users
WHERE college IS NOT NULL
GROUP BY college
ORDER BY user_count;

-- Q9: Team(s) with highest average rating
SELECT T.name AS team_name,
       COUNT(U.user_name) AS user_count,
       ROUND(AVG(U.rating),2) AS highest_avg_rating
FROM Teams T
JOIN Users U ON T.team_id = U.team_id
GROUP BY T.team_id, T.name
HAVING AVG(U.rating) = (
  SELECT MAX(avg_rating)
  FROM (
    SELECT AVG(rating) AS avg_rating
    FROM Users
    GROUP BY team_id
  ) x
);
