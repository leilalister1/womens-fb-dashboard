DROP TABLE IF EXISTS GameGoals;
DROP TABLE IF EXISTS PlayerStatistics;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS StaffStatistics;
DROP TABLE IF EXISTS TeamStatistics;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Conference;

CREATE TABLE Conference (
    ConferenceID INT PRIMARY KEY,
    Sport VARCHAR(20) NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Season VARCHAR(10) NOT NULL
);

CREATE TABLE Team (
    TeamName VARCHAR(20) PRIMARY KEY,
    NickName VARCHAR(20),
    Field VARCHAR(30) NOT NULL,
    ConferenceID INT NOT NULL,
    FOREIGN KEY (ConferenceID) REFERENCES Conference(ConferenceID)
);

CREATE TABLE Game (
    GameID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Team1Score INT NOT NULL,
    Team2Score INT NOT NULL,
    TeamName1 VARCHAR(20) NOT NULL,
    TeamName2 VARCHAR(20) NOT NULL,
    Fans INT DEFAULT 0,
    Team1Fouls INT NOT NULL,
    Team2Fouls INT NOT NULL,
    FOREIGN KEY (TeamName1) REFERENCES Team(TeamName),
    FOREIGN KEY (TeamName2) REFERENCES Team(TeamName)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    TeamName VARCHAR(20) NOT NULL,
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);

CREATE TABLE TeamStatistics (
    Year INT NOT NULL,
    TeamName VARCHAR(20) NOT NULL,
    Wins INT NOT NULL,
    Losses INT NOT NULL,
    Ties INT NOT NULL,
    PositionInConference INT NOT NULL,
    PRIMARY KEY (Year, TeamName),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);

CREATE TABLE StaffStatistics (
    StaffID INT PRIMARY KEY,
    CareerWins INT NOT NULL,
    CareerLosses INT NOT NULL,
    CareerTies INT NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Jersey INT NOT NULL,
    Position VARCHAR(30) NOT NULL,
    Height VARCHAR(20),
    DOB DATE,
    TeamName VARCHAR(20) NOT NULL,
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);

CREATE TABLE PlayerStatistics (
    PlayerID INT NOT NULL,
    Year INT NOT NULL,
    Goals INT NOT NULL,
    Assists INT NOT NULL,
    MinutesPlayed INT NOT NULL,
    Shots INT NOT NULL,
    ShotsOnGoal INT NOT NULL,
    GamesStarted INT NOT NULL,
    YellowCards INT NOT NULL,
    RedCards INT NOT NULL,
    PRIMARY KEY (PlayerID, Year),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);

CREATE TABLE GameGoals (
    GameGoalID INT PRIMARY KEY,
    GameID INT NOT NULL,
    PlayerID INT NOT NULL,
    MinuteScored INT NOT NULL,
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);
-- inserting values 

-- ************************** inserting teams into leagues *************************

-- inserting teams into the Big East conference: 

INSERT INTO Conference (ConferenceID, Sport, Name, Season) VALUES
(1,  'Soccer', 'BigEast', 'Fall'),
(2,  'Soccer', 'ACC', 'Fall'),
(3,  'Soccer', 'ASUN', 'Fall'),
(4,  'Soccer', 'AAC', 'Fall'),
(5,  'Soccer', 'BigSky', 'Fall'),
(6,  'Soccer', 'BigSouth', 'Fall'),
(7,  'Soccer', 'BigTen', 'Fall'),
(8,  'Soccer', 'CoastalAthletic', 'Fall'),
(9,  'Soccer', 'Horizon', 'Fall'),
(10, 'Soccer', 'Ivy', 'Fall'),
(11, 'Soccer', 'MetroAtlanticAthletic', 'Fall'),
(12, 'Soccer', 'MissouriValley', 'Fall'),
(13, 'Soccer', 'MountainWest', 'Fall'),
(14, 'Soccer', 'NorthEast', 'Fall'),
(15, 'Soccer', 'OhioValley', 'Fall'),
(16, 'Soccer', 'Patriot', 'Fall'),
(17, 'Soccer', 'SouthEastern', 'Fall'),
(18, 'Soccer', 'Southland', 'Fall'),
(19, 'Soccer', 'Southern', 'Fall'),
(20, 'Soccer', 'SunBelt', 'Fall'),
(21, 'Soccer', 'USA', 'Fall'),
(22, 'Soccer', 'WestCoast', 'Fall'),
(23, 'Soccer', 'WesternAthletic', 'Fall'),
(24, 'Soccer', 'Atlantic10', 'Fall'),
(25, 'Soccer', 'AmericaEast', 'Fall'),
(26, 'Soccer', 'SouthernAthletic', 'Fall'),
(27, 'Soccer', 'Summit', 'Fall'),
(28, 'Soccer', 'BigWest', 'Fall'),
(29, 'Soccer', 'SouthwesternAthletic', 'Fall'),
(30, 'Soccer', 'MidAmerican', 'Fall'),
(31, 'Soccer', 'Big12', 'Fall');


-- Big East Teams (ref 1)
INSERT INTO Team (TeamName, NickName, Field, ConferenceID) VALUES
('Butler',      'Bulldogs',    'Sellick Bowl',            1),
('Georgetown',  'Hoyas',       'Shaw Field',              1),
('Xavier',      'Musketeers',  'Corcoran Field',          1),
('UCONN',       'Huskies',     'Joseph Morrone Stadium',  1),
('Creighton',   'BlueJays',    'Morrison Stadium',        1),
('St.Johns',    'RedStorm',    'Belson Stadium',          1),
('Villanova',   'Nova',        'Higgins Complex',         1),
('Providence',  'Friars',      'Chapey Field',            1),
('SetonHall',   'Pirates',     'Owen T. Carroll field',   1),
('Marquette',   'MU',          'Valley Fields',           1),
('DePaul',      'BlueDemons',  'Wish Field',              1);

-- ACC : 
-- ACC Teams (ref 2)
INSERT INTO Team (TeamName, NickName, Field, ConferenceID) VALUES
('NorthCarolina', 'TarHeels', 'Dorrance Field', 2),
('FloridaState', 'Seminoles', 'Seminole Soccer Complex', 2),
('NotreDame', 'FightingIrish', 'Alumni Stadium', 2),
('Duke', 'BlueDevils', 'Koskinen Stadium', 2),
('Virginia', 'Cavaliers', 'Klockner Stadium', 2),
('Pittsburgh', 'Panthers', 'Ambrose Urbanic Field', 2),
('Stanford', 'Cardinal', 'Cagan Stadium', 2),
('California', 'GoldenBears', 'Edwards Stadium', 2),
('Miami', 'Hurricanes', 'Cobb Stadium', 2),
('Louisville', 'Cardinals', 'Lynn Family Stadium', 2),
('BostonCollege', 'Eagles', 'Newton Soccer Field', 2),
('Syracuse', 'Orange', 'SU Soccer Stadium', 2),
('NCState', 'Wolfpack', 'Dail Soccer Field', 2),
('WakeForest', 'DemonDeacons', 'Dennie Spry Stadium', 2),
('Clemson', 'Tigers', 'Historic Riggs Field', 2),
('SMU', 'Mustangs', 'Washburne Stadium', 2),
('VirginiaTech', 'Hokies', 'Thompson Field', 2);


-- inserting teams into the ACC conference: 

-- insert the TeamStatistics for the past 3 years for Big East 

INSERT INTO TeamStatistics
(Year, TeamName, Wins, Losses, Ties, PositionInConference)
VALUES
-- 2024
(2024, 'Butler', 5, 2, 3, 3),
(2024, 'Georgetown', 8, 1, 1, 1),
(2024, 'Xavier', 7, 2, 1, 2),
(2024, 'UCONN', 4, 3, 3, 5),
(2024, 'Creighton', 5, 4, 1, 4),
(2024, 'St.Johns', 1, 6, 3, 10),
(2024, 'Villanova', 2, 3, 5, 7),
(2024, 'Providence', 3, 5, 2, 8),
(2024, 'SetonHall', 1, 7, 2, 11),
(2024, 'Marquette', 3, 6, 1, 9),
(2024, 'DePaul', 3, 3, 4, 6),

-- 2023
(2023, 'Butler', 2, 3, 5, 6),
(2023, 'Georgetown', 6, 0, 4, 2),
(2023, 'Xavier', 6, 0, 4, 1),
(2023, 'UCONN', 6, 1, 3, 3),
(2023, 'Creighton', 2, 7, 1, 10),
(2023, 'St.Johns', 5, 4, 1, 5),
(2023, 'Villanova', 1, 7, 2, 11),
(2023, 'Providence', 4, 1, 5, 4),
(2023, 'SetonHall', 2, 4, 4, 7),
(2023, 'Marquette', 2, 6, 2, 9),
(2023, 'DePaul', 2, 5, 3, 8),

-- 2022
(2022, 'Butler', 4, 3, 3, 5),
(2022, 'Georgetown', 8, 0, 2, 1),
(2022, 'Xavier', 6, 0, 4, 2),
(2022, 'UCONN', 4, 4, 2, 6),
(2022, 'Creighton', 4, 3, 3, 4),
(2022, 'St.Johns', 4, 2, 3, 3),
(2022, 'Villanova', 3, 5, 2, 8),
(2022, 'Providence', 2, 4, 4, 9),
(2022, 'SetonHall', 1, 8, 1, 11),
(2022, 'Marquette', 3, 4, 3, 7),
(2022, 'DePaul', 1, 7, 1, 10);


-- insert staff values for the Big east 

INSERT INTO Staff (StaffID, FirstName, LastName, Role, TeamName) VALUES
(101, 'Rob', 'Alman', 'HeadCoach', 'Butler'),
(102, 'Tari', 'St.John', 'HeadCoach', 'Butler'),

(103, 'Margaret', 'Rodriguez', 'HeadCoach', 'UCONN'),

(104, 'Josh', 'Osit', 'HeadCoach', 'SetonHall'),
(105, 'Nick', 'Heinemann', 'AssistantCoach', 'SetonHall'),
(106, 'Noelle', 'Hilliker', 'AssistantCoach', 'SetonHall'),

(107, 'Ian', 'Stone', 'HeadCoach', 'St.Johns'),
(108, 'Amy', 'Marron', 'AssistantCoach', 'St.Johns'),
(109, 'Samie', 'Scaffidi', 'AssistantCoach', 'St.Johns');



-- BUTLER PLAYERS,  ID starts at 110 

INSERT INTO Player
(PlayerID, FirstName, LastName, Jersey, Position, Height, DOB, TeamName)
VALUES
(110, 'Leila', 'Lister', 9, 'Forward', '5ft5', '2004-01-18', 'Butler'),
(111, 'Abigail', 'Isger', 4, 'Forward', '5ft8', '2001-09-01', 'Butler'),
(112, 'Talia', 'Sommer', 18, 'Forward', '5ft7', '2004-02-19', 'Butler'),
(113, 'Amelie', 'Darey', 6, 'Defender', '5ft5', '2004-08-04', 'Butler'),
(114, 'Anna', 'Pierce', 0, 'GoalKeeper', '5ft9', NULL, 'Butler'),
(115, 'Addie', 'Marshall', 0, 'GoalKeeper', '6ft0', NULL, 'Butler'),
(116, 'Emma', 'Martin', 1, 'GoalKeeper', '5ft8', NULL, 'Butler'),
(117, 'Ceilidh', 'Whynott', 2, 'Defender', '5ft7', NULL, 'Butler'),
(118, 'Sydney', 'Longo', 3, 'Midfielder', '5ft4', NULL, 'Butler'),
(119, 'Lucia', 'Englund', 5, 'Defender', '5ft6', NULL, 'Butler'),
(120, 'Emily', 'O Malley', 7, 'Midfielder', '5ft9', NULL, 'Butler'),
(121, 'Norah', 'Jacomen', 8, 'Defender', '5ft9', NULL, 'Butler'),
(122, 'Alana', 'Wood', 10, 'Defender', '5ft3', NULL, 'Butler'),
(123, 'Daphne', 'Murray', 11, 'Forward/Midfielder', '5ft6', NULL, 'Butler'),
(124, 'Anna', 'Schroeder', 13, 'Defender', '5ft5', NULL, 'Butler'),
(125, 'Arianna', 'Jalics', 14, 'Midfielder', '5ft4', NULL, 'Butler'),
(126, 'Alex', 'Pulaski', 15, 'Defender', '5ft10', NULL, 'Butler'),
(127, 'Macie', 'Mietz', 17, 'Defender', '5ft7', NULL, 'Butler'),
(128, 'Caitlin', 'O Malley', 19, 'Defender', '5ft7', NULL, 'Butler'),
(129, 'Dianna', 'Palazzolo', 20, 'Defender', '5ft10', NULL, 'Butler'),
(130, 'Lea', 'Larouche', 21, 'Forward', '5ft7', NULL, 'Butler'),
(131, 'Macy', 'Malecki', 22, 'Midfielder', '5ft9', NULL, 'Butler'),
(132, 'Gemma', 'Gillespie', 26, 'Defender', '5ft8', NULL, 'Butler'),
(133, 'Sara', 'Trandji', 30, 'Midfielder/Forward', '5ft3', NULL, 'Butler'),
(134, 'Piper', 'Wilkinson', 88, 'GoalKeeper', '5ft7', NULL, 'Butler'),
(135, 'Alexie', 'Wittaker', 12, 'Forward', '5ft4', NULL, 'Butler');
-- Butler player Stats 
INSERT INTO PlayerStatistics
(PlayerID, Year, Goals, Assists, MinutesPlayed, Shots, ShotsOnGoal, GamesStarted, YellowCards, RedCards)
VALUES
(110,2024,2,1,528,24,7,7,1,0),
(112,2024,5,4,805,32,20,10,0,0),
(111,2024,2,3,760,24,12,10,0,0),
(113,2024,2,1,862,3,2,10,1,0),
(130,2024,1,0,583,8,4,10,0,0),
(121,2024,0,0,386,5,2,3,0,0),
(133,2024,0,1,243,5,0,0,0,0),
(119,2024,0,2,817,2,1,10,0,0),
(128,2024,0,1,849,1,1,10,0,0),
(120,2024,0,1,829,8,0,10,0,0),
(124,2024,0,1,867,5,2,10,1,0),
(135,2024,0,0,179,0,0,3,0,0),
(127,2024,0,0,10,0,0,0,0,0),
(122,2024,0,0,181,0,0,0,0,0),
(118,2024,0,0,307,0,0,2,0,0),
(132,2024,0,0,115,0,0,0,0,0),
(125,2024,0,0,444,7,3,5,0,0),
(131,2024,0,0,4,0,0,0,0,0),
(123,2024,0,0,121,1,1,0,0,0),
(114,2024,0,0,900,0,0,10,0,0),
(126,2024,0,0,111,2,0,0,0,0),
(117,2024,0,0,3,0,0,0,0,0),
(115,2024,0,0,0,0,0,0,0,0),
(116,2024,0,0,0,0,0,0,0,0),
(129,2024,0,0,0,0,0,0,0,0),
(134,2024,0,0,0,0,0,0,0,0);



