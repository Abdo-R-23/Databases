-- comment 
CREATE DATABASE PMDP;
GO

USE PMDP
GO

-- SHCAMAE some tapel inter the schame 
CREATE SCHEMA PM; -- DEFULTE SCHEMA DBoo
GO
CREATE TABLE PM.Companies (
CRNNO int primary key, -- name of colmne -type of colmne -constrain 
CompanyNAME varchar(50) not null  --varchar () ,nvarchar() , char ()
);
GO
CREATE TABLE PM.Managers (
ID int  not null , -- name of colmne -type of colmne -constrain 
Email varchar(100) not null ,--varchar () ,nvarchar() , char ()
primary key (ID)
);
GO
CREATE TABLE PM.Projects  (
PRJNO int primary key , -- name of colmne -type of colmne -constrain 
Titel varchar(100) not null ,--varchar () ,nvarchar() , char ()
ManagerID int foreign key references PM.Managers(ID) not null,
StartDate datetime2 not null, 
Initialcost decimal (18,2) not null ,
Parked bit not null ,
CRNNO int not null ,
foreign key(CRNNO) references PM.Companies(CRNNO)
);
GO
CREATE TABLE PM.Technology  (
ID int not null,
Name varchar(100) not null ,
Primary key (ID)

);
CREATE TABLE PM.Projecttechnology (
PRJNO int foreign key references PM.Projects(PRJNO) not null ,
TechnologyId int foreign key references PM.Technology(ID) not null,
Primary key (PRJNO , TechnologyId)


);



CREATE DATABASE TestDB;
GO

USE TestDB
GO
Create Table SomeTable(
Name varchar (25) not null 
);

GO
-- modefing the  colwmn using (Alter)
Alter Table SomeTable 
Alter Column Name varchar(50);
Alter Table SomeTable 
Add col2 varchar (50) not null ;
Alter Table SomeTable 
Drop Column col2;
--Drop  Table SomeTable ;
--Use master ;
--Go
--Drop Database TestDB;


-- add uniqued constraint 
Alter Table PM.Managers
add constraint UN_Email UNIQUE(Email) ;
