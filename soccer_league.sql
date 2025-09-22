CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    team_id INT REFERENCES teams(team_id)
);

CREATE TABLE referees (
    referee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE seasons (
    season_id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    home_team_id INT REFERENCES teams(team_id),
    away_team_id INT REFERENCES teams(team_id),
    season_id INT REFERENCES seasons(season_id),
    match_date DATE NOT NULL
);

CREATE TABLE match_referees (
    match_id INT REFERENCES matches(match_id),
    referee_id INT REFERENCES referees(referee_id),
    PRIMARY KEY (match_id, referee_id)
);

CREATE TABLE goals (
    goal_id SERIAL PRIMARY KEY,
    match_id INT REFERENCES matches(match_id),
    player_id INT REFERENCES players(player_id),
    minute_scored INT
);

-- Sample Inserts
INSERT INTO teams (name) VALUES
('Red Dragons'),
('Blue Sharks');

INSERT INTO players (name, team_id) VALUES
('Alice Striker', 1),
('Bob Defender', 1),
('Charlie Midfield', 2);

INSERT INTO referees (name) VALUES
('Ref A'),
('Ref B');

INSERT INTO seasons (start_date, end_date) VALUES
('2025-03-01', '2025-09-30');

INSERT INTO matches (home_team_id, away_team_id, season_id, match_date) VALUES
(1, 2, 1, '2025-04-15');

INSERT INTO match_referees (match_id, referee_id) VALUES
(1, 1);

INSERT INTO goals (match_id, player_id, minute_scored) VALUES
(1, 1, 15),  -- Alice scores in 15th minute
(1, 3, 60);  -- Charlie scores in 60th minute

-- Sample Queries
-- List all goals in a match
SELECT m.match_id, p.name AS player, g.minute_scored
FROM goals g
JOIN players p ON g.player_id = p.player_id
JOIN matches m ON g.match_id = m.match_id
WHERE m.match_id = 1;

-- Show standings (team and goals scored)
SELECT t.name AS team, COUNT(g.goal_id) AS total_goals
FROM teams t
LEFT JOIN players p ON t.team_id = p.team_id
LEFT JOIN goals g ON p.player_id = g.player_id
GROUP BY t.name
ORDER BY total_goals DESC;