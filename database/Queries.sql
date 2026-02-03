-- views 
-- SELECT 'GOT HERE' AS ";
SELECT * 
FROM Player 
; 

SELECT * 
FROM Team
; 

SELECT * 
FROM Staff
; 

SELECT * 
FROM PlayerStatistics
; 

-- 1) Who has scored 2 or more goals this season (2024) from Butler? 
-- The coach could use this to see who has contributed a lot to the team. 
SELECT CONCAT(Player.FirstName, ' ' , Player.LastName) AS PlayersWithMoreThan4Goals
FROM PlayerStatistics INNER JOIN Player ON PlayerStatistics.PlayerID = Player.PlayerID 
WHERE PlayerStatistics.Goals > 1 AND PlayerStatistics.Year = 2024 
; 

-- 2) In the Big East Womens soccer conference in 2022, what did the final table look like?  
-- This is useful if a player would like to see what teams have done well historically. 
SELECT TeamStatistics.positionInConference AS posInConference2022, Team.TeamName AS TeamName 
FROM TeamStatistics INNER JOIN Team ON TeamStatistics.TeamName = Team.TeamName
WHERE TeamStatistics.Year = 2022
ORDER BY TeamStatistics.positionInConference
; 
	
-- 3) Who were the top 10 goal scorers from Butler and UCONN combined in the 2024 season? 
-- A coach of UCONN or Butler may want to compare their players. 
SELECT CONCAT(Player.FirstName, ' ' , Player.LastName) AS  TopGoalScorers ,  Player.TeamName 
FROM Player INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
			INNER JOIN Team ON Player.TeamName = Team.TeamName 
WHERE Team.TeamName IN ('Butler', 'UCONN') AND PlayerStatistics.Year = 2024 
ORDER BY PlayerStatistics.Goals DESC 
LIMIT 10
;

-- 4) List all the players that got yellow cards and how many from Butler and UCONN this season(2024).
-- A coach may want to see who has the most penalisations throughout the season 
SELECT CONCAT(Player.FirstName, ' ' , Player.LastName) AS PlayerName ,  PlayerStatistics.YellowCards 
FROM Player INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
			INNER JOIN Team ON Player.TeamName = Team.TeamName 
WHERE Team.TeamName IN ('Butler', 'UCONN') AND PlayerStatistics.YellowCards > 0 AND PlayerStatistics.Year = 2024 
ORDER BY PlayerStatistics.YellowCards DESC 
; 

-- 5) The total number of yellow and red cards per team in the 2024 season
-- A coach may want to see which team is the most aggressive in the league, and which team gave away the most fouls. 

SELECT  Team.TeamName, SUM(PlayerStatistics.YellowCards) AS TotalYellowCards
FROM Player 
	INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
	INNER JOIN Team ON Player.TeamName = Team.TeamName 
WHERE Team.TeamName IN ('Butler', 'UCONN') AND PlayerStatistics.YellowCards > 0 AND PlayerStatistics.Year = 2024 
GROUP BY  Team.TeamName
ORDER BY  TotalYellowCards DESC
;

-- 6) The most shots on goal by players from Butler and UCONN, including their percentage shot on goal in 2024. 
-- The coach may want to see which of his players created the most chances for his team, to see who should get more opportunity. 
-- The coach may want to see whose shots are the most accurate (shotOnGoalPercentage)

SELECT Player.FirstName , Player.LastName AS Player , PlayerStatistics.Shots AS Total_Shots , PlayerStatistics.ShotsOnGoal ,
 (PlayerStatistics.ShotsOnGoal / PlayerStatistics.Shots) * 100 AS ShotOnGoalPercentage  
FROM Player INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
			INNER JOIN Team ON Player.TeamName = Team.TeamName 
WHERE Team.TeamName IN ('Butler', 'UCONN') AND PlayerStatistics.Shots > 0 AND PlayerStatistics.Year = 2024 
ORDER BY PlayerStatistics.Shots DESC 
;

-- 7) Find all the players from Butler and UCONN whose first name with 'A'. 
-- This could be a valuable tool when it comes to organising players alphabetically 
SELECT Player.FirstName , Team.TeamName 
FROM Player INNER JOIN Team ON Player.TeamName = Team.TeamName 
WHERE Player.FirstName LIKE 'A%' 
ORDER BY Player.FirstName 
; 

-- 8) List of all the possible player postions
-- Useful for when Freshman join a team and they need to be assigned a player postion in the database, it must be one from this list. 
SELECT DISTINCT Player.Position 
FROM Player 
ORDER BY Player.Position
;

-- 9) Output the teams with over 30 shots on goal in the 2024 season. 
-- This is useful to see how many chances a team is getting in comparison with others in their conference
SELECT Team.TeamName, SUM(PlayerStatistics.Shots) AS TotalShotsByTeam , SUM(PlayerStatistics.ShotsOnGoal) AS TotalShotsOnGoalByTeam
FROM Team INNER JOIN Player ON Team.TeamName = Player.TeamName
			INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
WHERE PlayerStatistics.Year = 2024 
GROUP BY Team.TeamName
HAVING SUM(PlayerStatistics.ShotsOnGoal) > 30
ORDER BY TotalShotsByTeam DESC
;

-- 10) Find Players with More Goals Than the Team Average: (SUBQUERY) in the 2024 season. 
-- This is useful to find those who have performed above the average level in the team. It is useful for a coach to see who needs to be doing better
-- and to see who is doing a good job 
SELECT Player.FirstName, Player.LastName, PlayerStatistics.goals, Team.TeamName  
FROM Player INNER JOIN PlayerStatistics ON Player.PlayerID = PlayerStatistics.PlayerID
			INNER JOIN Team ON Player.TeamName = Team.TeamName
WHERE PlayerStatistics.goals > 
	(
		SELECT AVG(PlayerStatistics.goals) 
		FROM PlayerStatistics INNER JOIN Player ON PlayerStatistics.PlayerID = Player.PlayerID
		WHERE Player.TeamName = Team.TeamName AND PlayerStatistics.Year = 2024 
	)  AND PlayerStatistics.Year = 2024 
ORDER BY Team.TeamName, PlayerStatistics.goals DESC
;

-- implement a trigger and a stored procedure  
-- procedure: 
DROP PROCEDURE IF EXISTS addStaffMember ; 
-- changes the default delimited to //
DELIMITER // 

CREATE PROCEDURE addStaffMember(FirstName CHAR(20), LastName CHAR(20), Role CHAR(20), StaffID INT , TeamName CHAR(20))
BEGIN 
	INSERT INTO Staff VALUES(FirstName, LastName, Role, StaffID , TeamName); 
END
// 
-- #changes the delimiter back to ; 
DELIMITER ; 

CALL addStaffMember('Dave', 'Nolan', 'HeadCoach', 1000, 'GeorgeTown');

SELECT * 
FROM Staff 
WHERE Staff.TeamName = 'GeorgeTown' 
; 
DROP TABLE IF EXISTS Log;
CREATE TABLE Log(

	Message VARCHAR(60)
); 
DROP TRIGGER IF EXISTS demo ; 

CREATE TRIGGER demo 
	AFTER INSERT ON Staff
	FOR EACH ROW 
	INSERT INTO Log VALUES("You inserted a new Staff Member ")
;
CALL addStaffMember('Dave', 'Nolan', 'HeadCoach', 1001, 'GeorgeTown');

SELECT * FROM Log ; 
SHOW TRIGGERS; 
