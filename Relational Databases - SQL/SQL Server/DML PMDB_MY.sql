USE PMDP;
GO

-- 1?? ????? ????? (Companies)
INSERT INTO PM.Companies (CRNNO, CompanyNAME)
VALUES 
(1001, 'TechVision'),
(1002, 'SmartSoft'),
(1003, 'InnovaWorks'),
(1004, 'NextGen Solutions'),
(1005, 'CloudWare Systems'),
(1006, 'DataBridge Technologies'),
(1007, 'VisionSoft'),
(1008, 'CyberEdge Ltd');
GO

-- 2?? ????? ?????? (Managers)
INSERT INTO PM.Managers (ID, Email)
VALUES 
(1, 'manager1@techvision.com'),
(2, 'manager2@smartsoft.com'),
(3, 'manager3@innovaworks.com'),
(4, 'manager4@nextgen.com'),
(5, 'manager5@cloudware.com'),
(6, 'manager6@databridge.com'),
(7, 'manager7@visionsoft.com'),
(8, 'manager8@cyberedge.com');
GO

-- 3?? ????? ?????? (Projects)
INSERT INTO PM.Projects (PRJNO, Titel, ManagerID, StartDate, Initialcost, Parked, CRNNO)
VALUES 
(101, 'ERP System Upgrade', 1, '2023-01-10', 150000.00, 0, 1001),
(102, 'Mobile App Development', 2, '2023-06-01', 90000.00, 0, 1002),
(103, 'AI Automation Project', 3, '2023-09-15', 120000.00, 1, 1003),
(104, 'Cloud Migration Project', 5, '2024-02-01', 200000.00, 0, 1005),
(105, 'Data Analytics Dashboard', 6, '2024-03-10', 85000.00, 0, 1006),
(106, 'CyberSecurity Enhancement', 8, '2024-05-22', 110000.00, 1, 1008),
(107, 'AI Chatbot Integration', 7, '2024-07-15', 60000.00, 0, 1007),
(108, 'Cloud Monitoring System', 4, '2024-09-05', 95000.00, 0, 1004);
GO

-- 4?? ????? ?????? (Technology)
INSERT INTO PM.Technology (ID, Name)
VALUES 
(1, 'C# .NET'),
(2, 'React Native'),
(3, 'Python AI'),
(4, 'SQL Server'),
(5, 'Java Spring Boot'),
(6, 'Angular'),
(7, 'Node.js'),
(8, 'AWS Cloud'),
(9, 'Power BI'),
(10, 'Kubernetes');
GO

-- 5?? ??? ???????? ????????? (ProjectTechnology)
INSERT INTO PM.Projecttechnology (PRJNO, TechnologyId)
VALUES 
(101, 1),  -- ERP System Upgrade uses C# .NET
(101, 4),  -- and SQL Server
(102, 2),  -- Mobile App uses React Native
(102, 4),  -- and SQL Server
(103, 3),  -- AI Project uses Python AI
(103, 4),  -- and SQL Server
-- Project 104 - Cloud Migration Project
(104, 8),  -- AWS Cloud
(104, 10), -- Kubernetes

-- Project 105 - Data Analytics Dashboard
(105, 9),  -- Power BI
(105, 4),  -- SQL Server

-- Project 106 - CyberSecurity Enhancement
(106, 3),  -- Python AI
(106, 8),  -- AWS Cloud

-- Project 107 - AI Chatbot Integration
(107, 3),  -- Python AI
(107, 7),  -- Node.js
(107, 2),  -- React Native

-- Project 108 - Cloud Monitoring System
(108, 5),  -- Java Spring Boot
(108, 8),  -- AWS Cloud
(108, 4);  -- SQL Server
GO
-- select
SELECT * FROM PM.Companies;
SELECT * FROM PM.Managers;
SELECT * FROM PM.Projects;
SELECT * FROM PM.Technology;
SELECT * FROM PM.Projecttechnology;

-- selsct as #####

SELECT COUNT(*) AS TotalCompanies FROM PM.Companies;
SELECT COUNT(*) AS TotalManagers FROM PM.Managers;
SELECT COUNT(*) AS TotalProjects FROM PM.Projects;
SELECT COUNT(*) AS TotalTechnologies FROM PM.Technology;
SELECT COUNT(*) AS TotalProjectTech FROM PM.Projecttechnology;

SELECT 
    P.PRJNO,
    P.Titel,
    M.Email AS ManagerEmail,
    C.CompanyNAME,
    P.StartDate,
    P.Initialcost,
    STRING_AGG(T.Name, ', ') AS Technologies
FROM PM.Projects P
JOIN PM.Managers M ON P.ManagerID = M.ID
JOIN PM.Companies C ON P.CRNNO = C.CRNNO
JOIN PM.Projecttechnology PT ON P.PRJNO = PT.PRJNO
JOIN PM.Technology T ON PT.TechnologyId = T.ID
GROUP BY P.PRJNO, P.Titel, M.Email, C.CompanyNAME, P.StartDate, P.Initialcost;

 -- where 
SELECT Titel, Initialcost
FROM PM.Projects
WHERE Initialcost > 100000;

SELECT PRJNO, Titel, Parked
FROM PM.Projects
WHERE Parked = 1;

SELECT Titel, Initialcost, StartDate
FROM PM.Projects
WHERE Initialcost > 80000 AND Parked = 0;

SELECT Titel, StartDate
FROM PM.Projects
WHERE StartDate < '2024-01-01';

SELECT Titel, InitialCost, StartDate
FROM PM.Projects
WHERE InitialCost > 100000
AND StartDate > '2024-01-01';

SELECT Titel, ManagerID, InitialCost
FROM PM.Projects
WHERE ManagerID = 1
OR InitialCost < 50000;

-- like 
SELECT * 
FROM PM.Companies
WHERE CompanyNAME LIKE 'C%';

SELECT * 
FROM PM.Managers
WHERE Email LIKE '%cloud%';

SELECT CompanyNAME
FROM PM.Companies
WHERE CompanyNAME LIKE 'A%';

SELECT ID, Email
FROM PM.Managers
WHERE Email LIKE '%system%';

-- where whit between
SELECT Titel, StartDate, Initialcost
FROM PM.Projects
WHERE StartDate BETWEEN '2024-01-01' AND '2024-06-30';

SELECT Titel, InitialCost
FROM PM.Projects
WHERE InitialCost BETWEEN 50000 AND 150000;

-- IN
SELECT Titel, CRNNO
FROM PM.Projects
WHERE CRNNO IN (1, 3, 5);
 -- is null 
 SELECT ID, Email
FROM PM.Managers
WHERE Email IS NULL;

SELECT Titel, InitialCost, StartDate, ManagerID
FROM PM.Projects
WHERE InitialCost < 200000
AND YEAR(StartDate) = 2024
AND ManagerID IN (2, 3);

-- where with join ####
SELECT P.Titel, C.CompanyNAME, M.Email
FROM PM.Projects P
JOIN PM.Companies C ON P.CRNNO = C.CRNNO
JOIN PM.Managers M ON P.ManagerID = M.ID
WHERE C.CompanyNAME = 'CloudWare Systems';

-- inner join ###
SELECT 
    P.Titel AS ProjectTitle,
    C.CompanyNAME AS CompanyName,
    P.InitialCost
FROM PM.Projects AS P
INNER JOIN PM.Companies AS C
    ON P.CRNNO = C.CRNNO;

    SELECT 
    P.Titel,
    M.Email AS ManagerEmail,
    P.StartDate,
    P.InitialCost
FROM PM.Projects AS P
INNER JOIN PM.Managers AS M
    ON P.ManagerID = M.ID;

    SELECT 
    P.Titel,
    C.CompanyNAME,
    M.Email AS ManagerEmail,
    P.InitialCost
FROM PM.Projects AS P
INNER JOIN PM.Companies AS C ON P.CRNNO = C.CRNNO
INNER JOIN PM.Managers AS M ON P.ManagerID = M.ID
WHERE P.Parked = 1;

SELECT 
    P.Titel AS ProjectTitle,
    T.Name AS TechnologyName
FROM PM.Projects AS P
INNER JOIN PM.ProjectTechnology AS PT ON P.PRJNO = PT.PRJNO
INNER JOIN PM.Technology AS T ON PT.TechnologyId = T.ID;

SELECT 
    P.Titel,
    M.Email,
    T.Name AS TechnologyName,
    P.InitialCost
FROM PM.Projects AS P
INNER JOIN PM.Managers AS M ON P.ManagerID = M.ID
INNER JOIN PM.ProjectTechnology AS PT ON P.PRJNO = PT.PRJNO
INNER JOIN PM.Technology AS T ON PT.TechnologyId = T.ID
WHERE M.Email LIKE '%sys%'
AND P.InitialCost BETWEEN 50000 AND 200000
AND T.Name LIKE '%SQL%';

-- top 
SELECT TOP (5) *
FROM PM.Projects;

-- order by 
SELECT TOP (3) Titel, InitialCost
FROM PM.Projects
ORDER BY InitialCost DESC;

SELECT TOP (10) CompanyNAME
FROM PM.Companies
ORDER BY CompanyNAME ASC;

SELECT TOP (1) Titel, InitialCost
FROM PM.Projects
ORDER BY InitialCost DESC;

SELECT TOP (3) Titel, ManagerID, StartDate
FROM PM.Projects
WHERE ManagerID = 2
ORDER BY StartDate ASC;

 -- group by 
SELECT ManagerID, COUNT(*) AS ProjectCount
FROM PM.Projects
GROUP BY ManagerID;


SELECT CRNNO, SUM(InitialCost) AS TotalCost
FROM PM.Projects
GROUP BY CRNNO;

SELECT ManagerID, AVG(InitialCost) AS AverageCost
FROM PM.Projects
GROUP BY ManagerID;

SELECT CRNNO,
       MAX(InitialCost) AS MaxCost,
       MIN(InitialCost) AS MinCost
FROM PM.Projects
GROUP BY CRNNO;

SELECT Parked, COUNT(*) AS TotalProjects
FROM PM.Projects
GROUP BY Parked;

SELECT ManagerID, Titel, COUNT(*)
FROM PM.Projects
GROUP BY ManagerID;  -- ? ??? Titel ?? ???? ???? ?????

SELECT CRNNO, COUNT(*) AS ProjectCount
FROM PM.Projects
GROUP BY CRNNO
HAVING COUNT(*) > 2;


SELECT ManagerID, SUM(InitialCost) AS TotalCost
FROM PM.Projects
GROUP BY ManagerID
HAVING SUM(InitialCost) > 200000;

SELECT CRNNO, AVG(InitialCost) AS AvgCost
FROM PM.Projects
GROUP BY CRNNO
HAVING AVG(InitialCost) > 80000;

SELECT CRNNO, SUM(InitialCost) AS TotalCost
FROM PM.Projects
WHERE CRNNO > 1
GROUP BY CRNNO
HAVING SUM(InitialCost) > 150000;

-- distinct
SELECT DISTINCT CompanyNAME
FROM PM.Companies;

SELECT DISTINCT ManagerID
FROM PM.Projects;

SELECT DISTINCT ManagerID, CRNNO
FROM PM.Projects;

SELECT COUNT(DISTINCT ManagerID) AS UniqueManagers
FROM PM.Projects;

-- join 
-- inner join 
SELECT 
    P.Titel,
    M.Email AS ManagerEmail
FROM PM.Projects AS P
INNER JOIN PM.Managers AS M
    ON P.ManagerID = M.ID;

    -- left join
    SELECT 
    P.Titel,
    M.Email AS ManagerEmail
FROM PM.Projects AS P
LEFT JOIN PM.Managers AS M
    ON P.ManagerID = M.ID;

    -- right join
    SELECT 
    M.ID,
    M.Email,
    P.Titel
FROM PM.Managers AS M
RIGHT JOIN PM.Projects AS P
    ON P.ManagerID = M.ID;
   
   --full join 
   SELECT 
    M.ID AS ManagerID,
    M.Email,
    P.Titel AS ProjectTitle
FROM PM.Managers AS M
FULL JOIN PM.Projects AS P
    ON P.ManagerID = M.ID;


    -- cross join 
    SELECT 
    M.Email,
    P.Titel
FROM PM.Managers AS M
CROSS JOIN PM.Projects AS P;

-- join between three tables 
SELECT 
    P.Titel AS ProjectTitle,
    C.CompanyNAME AS CompanyName,
    M.Email AS ManagerEmail
FROM PM.Projects AS P
INNER JOIN PM.Companies AS C ON P.CRNNO = C.CRNNO
INNER JOIN PM.Managers AS M ON P.ManagerID = M.ID;

-- update
UPDATE PM.Companies
SET CompanyNAME = 'TechVision Ltd'
WHERE CRNNO = 1001;

UPDATE PM.Projects
SET Initialcost = Initialcost * 1.1
WHERE PRJNO = 2001;

UPDATE PM.Projects
SET Parked = 1
WHERE PRJNO = 2003;

UPDATE PM.Managers
SET Email = 'sara@newmail.com',
    ID = 22
WHERE ID = 2;

UPDATE P
SET P.ManagerID = M.ID
FROM PM.Projects P
INNER JOIN PM.Managers M
ON M.Email = 'ali@company.com'
WHERE P.Titel = 'Web System';

-- delete
DELETE FROM PM.Managers
WHERE ID = 3;

DELETE FROM PM.Projects
WHERE Parked = 1;

DELETE FROM PM.Companies
WHERE CRNNO = 1004;

DELETE P
FROM PM.Projects P
INNER JOIN PM.Managers M
ON P.ManagerID = M.ID
WHERE M.Email = 'ali@company.com';

DELETE FROM PM.Technology;

