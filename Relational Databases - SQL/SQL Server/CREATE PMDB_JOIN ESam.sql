USE [master]
GO
/****** Object:  Database [PMDB]    Script Date: 2021-09-12 3:20:43 AM ******/
CREATE DATABASE [PMDP_JOIN]
GO

USE [PMDB_JOIN]
GO

CREATE SCHEMA [PM_1]
GO

CREATE TABLE [PM_1].[Companies](
	[CRNNO] [int] NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
    PRIMARY KEY ([CRNNO]))
GO

CREATE TABLE [PM_1].[Managers](
	[Id] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	PRIMARY KEY ([Id]))
GO
 
CREATE TABLE [PM_1].[Projects](
	[PRJNO] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[ManagerId] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[InitialCost] [decimal](18, 2) NOT NULL,
	[Parked] [bit] NOT NULL,
	[CRNNO] [int] NOT NULL,
	FOREIGN KEY([CRNNO]) REFERENCES [PM_1].[Companies] ([CRNNO]),
	FOREIGN KEY([ManagerId])REFERENCES [PM_1].[Managers] ([Id]),
	PRIMARY KEY ([PRJNO]));
GO

CREATE TABLE [PM_1].[Technologies](
	[Id] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
    PRIMARY KEY ([Id]))
GO

CREATE TABLE [PM_1].[ProjectTechnologies](
	[PRJNO] [int] NOT NULL,
	[TechnologyId] [int] NOT NULL,
	FOREIGN KEY([PRJNO])REFERENCES [PM_1].[Projects] ([PRJNO]),
	FOREIGN KEY([TechnologyId]) REFERENCES [PM_1].[Technologies] ([Id]),
    PRIMARY KEY ([PRJNO], [TechnologyId]))
GO