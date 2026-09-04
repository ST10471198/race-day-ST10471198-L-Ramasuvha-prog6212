-- ============================================================
-- Database: RaceDay System
-- Description: Full database schema for RaceDay event management
-- Author: [Your Name]
-- Date: 2026-09-04
-- ============================================================

USE master;
GO

-- Drop database if it exists (for clean testing)
IF DB_ID('RaceDayDB') IS NOT NULL 
BEGIN
    ALTER DATABASE RaceDayDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDayDB;
END 
GO

-- Create the database
CREATE DATABASE RaceDayDB;
GO

-- Switch to the new database
USE RaceDayDB;
GO

-- CREATE TABLE Statements for all entities

--Organiser table
CREATE TABLE Organiser
(
    organiserID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    passwordHash VARCHAR(255) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

--Participant table
CREATE TABLE Participant
(
    participantID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    dateOfBirth DATE NOT NULL,
    idNumber VARCHAR(50) NOT NULL UNIQUE,
    emergencyContact VARCHAR(100) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

--Event table
CREATE TABLE Event
(
    eventID INT IDENTITY(1,1) PRIMARY KEY,
    organiserID INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(500) NULL,
    date DATE NOT NULL,
    location VARCHAR(200) NOT NULL,
    maxParticipants INT NOT NULL CHECK (maxParticipants > 0),
    status VARCHAR(50) NOT NULL DEFAULT 'Upcoming' 
        CHECK (status IN ('Upcoming', 'Open', 'Closed', 'Completed', 'Cancelled')),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (organiserID)
        REFERENCES Organiser(organiserID)
        ON DELETE CASCADE
);
GO

--Category table
CREATE TABLE Category
(
    categoryID INT IDENTITY(1,1) PRIMARY KEY,
    eventID INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    distanceKM DECIMAL(6,2) NOT NULL CHECK (distanceKM > 0),
    startTime TIME NOT NULL,
    ageMin INT NOT NULL CHECK (ageMin >= 0),
    ageMax INT NOT NULL CHECK (ageMax > ageMin),
    entryFee DECIMAL(10,2) NOT NULL CHECK (entryFee >= 0),

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (eventID)
        REFERENCES Event(eventID)
        ON DELETE CASCADE
);
GO
