--Part 3
--Level 1/
--1. Display every player whose position is 'Forward'
SELECT * FROM Player
WHERE position ='FW';

--2. Display every Spanish player with their age in descending order
SELECT * FROM Player
WHERE teamID='ESP'
ORDER BY age DESC;

--3. Display every stadium with capacity more than 40000
SELECT stadName FROM Stadium
WHERE capacity > 40000;

--4. Show average age of every referee and store the data in a new column
SELECT AVG(age) AS averageAge
FROM Referee;

--Level 2/
--1. Show player with the same age as Aitana Bonmati of Spain
SELECT age, CONCAT(firstName, '', lastName) AS Name 
FROM Player
WHERE age = (SELECT age FROM Player
WHERE firstName='Aitana' and lastName='Bonmati');

--2. Show every player’s full name, and teams that participate in the Quarter-final
SELECT a.playerID, a.firstName, a.lastName
FROM Player a 
NATURAL JOIN MatchPlay b
WHERE a.teamID = b.A_teamID OR a.teamID = b.B_teamID
AND b.round = 'QF'
GROUP BY a.playerID, a.firstName, a.lastName;

--3. Show every player who played in this tournament with more than 30 international caps.
SELECT a.playerID, CONCAT(a.firstName, ' ', a.lastName) AS Name 
FROM Player a JOIN MatchPlay b ON a.teamID=b.A_teamID OR a.teamID=b.B_teamID WHERE (SELECT c.appearances FROM playfor c 
WHERE c.playerID=a.playerID 
AND c.appearances>30); 

--4. Show ID and full name of every referee taking part in “Eden Park” stadium.
SELECT a.refNo, CONCAT(b.firstName, ' ', b.lastName) AS RefName
FROM Refereed a JOIN Referee b ON a.refNo=b.refNo
WHERE a.matchID = (SELECT c.matchID
FROM MatchPlay c
WHERE a.matchID=c.matchID AND c.stadName='Eden Park');

--Part 4
--1. Create view to show every player with total international caps is more than 0.
CREATE VIEW mostExperiencedPlayer AS
SELECT a.playerID, b.firstName, b.lastName, SUM(a.appearances) AS TotalAppearances
FROM playfor a JOIN Player b ON a.playerID=b.playerID
WHERE a.appearances > 0
GROUP BY a.playerID, b.firstName, b.lastName
ORDER BY TotalAppearances DESC;

--2. Procedure to insert new player

DROP PROCEDURE IF EXISTS InsertNewPlayer;
DELIMITER //
CREATE PROCEDURE InsertNewPlayer(
firstName VARCHAR(20), lastName VARCHAR(20), nationality VARCHAR(20), DOB DATE,
playerID VARCHAR(10), pnumber INT, age INT, position CHAR(2), teamID VARCHAR(10))
COMMENT 'Insert info for new player'
BEGIN 
INSERT INTO Person(firstName, lastName, nationality, DOB)
VALUES(firstName, lastName, nationality, DOB);
INSERT INTO Player(playerID, pnumber, age, position, firstName, lastName, nationality, teamID)
VALUES(playerID, lastName, nationality, DOB);
END;
//
DELIMITER ;

--3. Trigger for Duplication Error Handling 
DROP TRIGGER IF EXISTS InsertNewPlayerExHandling;
DELIMITER //
CREATE TRIGGER InsertNewPlayerExHandling
BEFORE INSERT ON Person
FOR EACH ROW
BEGIN
    IF EXISTS(SELECT 1 FROM Person WHERE firstName = NEW.firstName AND lastName = NEW.lastName AND nationality = NEW.nationality AND DOB = NEW.DOB) THEN
        SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Error detected: Duplication of Person information';
    END IF;
END //
DELIMITER ;
