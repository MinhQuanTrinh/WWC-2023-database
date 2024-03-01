CREATE DATABASE wwcData_21049644;
USE wwcData_21049644;

--Create Tables
DROP TABLE IF EXISTS Person;
CREATE TABLE Person(
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20),
    nationality VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    PRIMARY KEY (firstName, lastName, nationality)
);

DROP TABLE IF EXISTS Team;
CREATE TABLE Team(
    teamName VARCHAR(15) NOT NULL,
    teamID CHAR(6) NOT NULL,
    ranking INT,
    PRIMARY KEY (teamID)
);

DROP TABLE IF EXISTS Stadium;
CREATE TABLE Stadium(
    stadName VARCHAR(40) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state CHAR(10) NOT NULL,
    capacity INT,
    PRIMARY KEY (stadName)
);

DROP TABLE IF EXISTS Player;
CREATE TABLE Player(
    playerID VARCHAR(10) NOT NULL,
    pnumber INT NOT NULL,
    age INT NOT NULL,
    position VARCHAR(2) NOT NULL,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    nationality VARCHAR(20),
    teamID CHAR(3) NOT NULL,
    PRIMARY KEY (playerID),
    FOREIGN KEY (firstName, lastName, nationality) REFERENCES Person(firstName, lastName, nationality),
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
);
DROP TABLE IF EXISTS Coach;
CREATE TABLE Coach(
    coachID VARCHAR(15) NOT NULL,
    coachRole VARCHAR(20), 
    age INT NOT NULL,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    nationality VARCHAR(20),
    teamID CHAR(3) NOT NULL,
    PRIMARY KEY (coachID),
    FOREIGN KEY (firstName, lastName, nationality) REFERENCES Person(firstName, lastName, nationality),
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
);
DROP TABLE IF EXISTS Referee;
CREATE TABLE Referee(
    refNo VARCHAR(10) NOT NULL,
    refRole CHAR(2) NOT NULL,
    age INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    nationality VARCHAR(20),
    FOREIGN KEY (firstName, lastName, nationality) REFERENCES Person(firstName, lastName, nationality),
    PRIMARY KEY (refNo)
);

DROP TABLE IF EXISTS MatchPlay;
CREATE TABLE MatchPlay(
    matchID VARCHAR(6) NOT NULL,
    A_teamID CHAR(6) NOT NULL,
    B_teamID CHAR(6) NOT NULL,
    stadName VARCHAR(60) NOT NULL,
    FOREIGN KEY (stadName) REFERENCES Stadium(stadName),
    round VARCHAR(3) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (A_teamID) REFERENCES Team(teamID),
    FOREIGN KEY (B_teamID) REFERENCES Team(teamID),
    attendance INT NOT NULL,
    A_goal INT,
    B_goal INT,
    PRIMARY KEY(matchID)
);

DROP TABLE IF EXISTS Card;
CREATE TABLE Card(
    refNo VARCHAR(10) NOT NULL,
    cardType CHAR(1) NOT NULL,
    minute INT NOT NULL,
    matchID VARCHAR(6),
    FOREIGN KEY (refNo) REFERENCES Referee(refNo),
    FOREIGN KEY (matchID) REFERENCES MatchPlay(matchID)
);

DROP TABLE IF EXISTS playfor;
CREATE TABLE playfor(
    playerID VARCHAR(10) NOT NULL,
    teamID CHAR(3) NOT NULL,
    goals INT,
    appearances INT,
    FOREIGN KEY (playerID) REFERENCES Player(playerID),
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
);

DROP TABLE IF EXISTS Refereed;
CREATE TABLE Refereed(
    refNo VARCHAR(10) NOT NULL,
    matchID VARCHAR(6) NOT NULL,
    FOREIGN KEY (matchID) REFERENCES MatchPlay(matchID),
    FOREIGN KEY (refNo) REFERENCES Referee(refNo)
);


