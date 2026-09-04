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

-- 1. Organiser table
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

