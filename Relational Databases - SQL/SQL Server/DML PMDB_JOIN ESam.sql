USE PMDP_JOIN;
GO

INSERT INTO PM_1.Companies (CRNNO, CompanyName) VALUES (101, N'Company A');

INSERT INTO PM_1.Companies (CompanyName, CRNNO) VALUES (N'Company B', 102);

INSERT INTO PM_1.Companies  VALUES (103, N'Company C');

INSERT INTO PM_1.Companies  VALUES 
           (104, N'Company D'),
           (105, N'Company E'),
           (106, N'Company F'),
           (107, N'Company G');
GO


INSERT INTO PM_1.Managers (Id ,Email) VALUES (201, 'peter@fake.com');
INSERT INTO PM_1.Managers (Id ,Email) VALUES (202, 'mike@fake.com');
INSERT INTO PM_1.Managers (Id ,Email) VALUES (203, 'reem@fake.com');
INSERT INTO PM_1.Managers (Id ,Email) VALUES (204, 'salah@fake.com'); 

GO
INSERT INTO PM_1.Technologies(Id , Name) VALUES (301, 'SQL SERVER');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (302, 'ASP NET CORE');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (303, 'ANGULAR');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (304, 'REACT');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (305, 'WPF');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (306, 'ANDROID');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (307, 'ORACLE');
INSERT INTO PM_1.Technologies(Id , Name) VALUES (308, 'PHP'); 

GO

INSERT INTO PM_1.Projects ( PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO)
     VALUES ( 401, 'CMS', 201, '2022-01-01', 15000000, 0, 101),
            ( 402, 'ERP', 202, '2022-02-01', 20000000, 0, 102),
            ( 403, 'CMS', 203, '2022-03-01', 15000000, 0, 105),
            ( 404, 'Authenticator', 204, '2022-04-01', 150000, 0, 101),
            ( 405, 'CRM-DESKTOP', 203, '2022-05-01', 20000000, 0, 104),
            ( 406, 'ERP', 204, '2022-06-01', 20000000, 0, 105),
            ( 407, 'HUB', 204, '2022-06-01', 20000000, 1, 104);

GO

INSERT INTO PM_1.ProjectTechnologies (PRJNO, TechnologyId) VALUES 
        ( 401, 301), 
        ( 401, 302),
		( 401, 303),
		( 402, 301), 
        ( 402, 302),
		( 402, 304),
		( 403, 301), 
        ( 403, 302),
		( 403, 308),
		( 404, 306),
		( 405, 307),
		( 405, 305),
		( 406, 307),
		( 406, 308);
GO

-- SELECT

SELECT PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO
FROM PM_1.Projects;

SELECT *
FROM PM_1.Projects;

SELECT PRJNO, Title
FROM PM_1.Projects;

-- WHERE 
SELECT * FROM PM_1.Projects WHERE InitialCost >= 1000000;
SELECT * FROM PM_1.Projects WHERE NOT InitialCost >= 1000000;
SELECT * FROM PM_1.Projects WHERE InitialCost >= 1000000 AND StartDate >= '2022-03-01';
SELECT * FROM PM_1.Projects WHERE InitialCost >= 1000000 OR StartDate >= '2022-03-01';

-- LIKE (%, _)
 -- LIKE xx% starts with
 SELECT * FROM PM_1.Projects WHERE Title like 'C%'
  -- LIKE %xx ends with
 SELECT * FROM PM_1.Projects WHERE Title like '%P'
   -- LIKE %xx% contains 
 SELECT * FROM PM_1.Projects WHERE Title like '%DESK%'
   -- LIKE _R%
    SELECT * FROM PM_1.Projects WHERE Title like '_R_';
    SELECT * FROM PM_1.Projects WHERE InitialCost like '_5%';

-- TOP
   SELECT TOP 3 * From PM_1.Projects
   SELECT TOP 2 PERCENT *  From PM_1.Projects

-- ORDER BY
SELECT * FROM PM_1.Projects ORDER BY StartDate;
SELECT * FROM PM_1.Projects ORDER BY StartDate DESC;
SELECT * FROM PM_1.Projects ORDER BY InitialCost, StartDate DESC;

-- GROUP BY

SELECT Title, COUNT(*)  FROM PM_1.Projects GROUP BY Title;

SELECT ManagerId, COUNT(*) 
     FROM PM_1.Projects
	  WHERE Parked = 0 
	 GROUP BY ManagerId 
	  HAVING COUNT(*) >= 2;
 
 -- DISTINT 
 SELECT DISTINCT Title  FROM PM_1.Projects
  SELECT DISTINCT InitialCost  FROM PM_1.Projects

-- Tables JOIN

SELECT * FROM PM_1.Projects;
SELECT * FROM PM_1.Managers;

-- PRJNO,  TITLE, Manager_Email
SELECT * FROM PM_1.Projects, PM_1.Managers;
SELECT PRJNO, Title, Email FROM PM_1.Projects, PM_1.Managers; -- Cartisian Product
SELECT PRJNO, Title, Email, PM_1.Managers.Id, PM_1.Projects.ManagerId FROM PM_1.Projects, PM_1.Managers 
WHERE PM_1.Projects.ManagerId = PM_1.Managers.Id;

-- INNET JOIN Match in two tables


SELECT 
  (P.PRJNO) AS N'Project number'
, (P.Title) AS N'project addrees'
, (M.Email) AS N'Email for project manager' FROM 
PM_1.Projects AS P INNER JOIN PM_1.Managers AS M 
ON P.ManagerId = M.Id;
SELECT * FROM PM_1.Projects;
SELECT * FROM PM_1.Managers;
-- LEFT JOIN ( ALL ROWS FROM LEFT TABLE EVEN NO MATCH)

SELECT * FROM PM_1.COMPANIES;
SELECT * FROM PM_1.Projects;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM_1.Projects AS P LEFT JOIN PM_1.Companies AS C 
ON P.CRNNO = C.CRNNO;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CRNNO)
, (C.CompanyName) FROM 
 PM_1.Companies AS C LEFT JOIN  PM_1.Projects AS P
ON P.CRNNO = C.CRNNO;

-- RIGHTJOIN ( ALL ROWS FROM RIGHT TABLE EVEN NO MATCH)
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM_1.Projects AS P RIGHT JOIN PM_1.Companies AS C 
ON P.CRNNO = C.CRNNO;

-- FULL JOIN ( ALL ROWS FROM RIGHT  and left TABLE EVEN NO MATCH)
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
PM_1.Projects AS P FULL JOIN PM_1.Companies AS C 
ON P.CRNNO = C.CRNNO;


-- UPDATE
UPDATE PM_1.Projects 
SET StartDate = '2022-07-10'
WHERE PRJNO = 407;

-- DELETE 

DELETE FROM PM_1.Projects WHERE PRJNO = 406;

DROP TABLE PM_1.PROJECTS;
TRUNCATE TABLE PM_1.PROJECTS;

-- SUBQUERY
SELECT * FROM PM_1.Projects;
SELECT * FROM PM_1.ProjectTechnologies;
SELECT * FROM PM_1.Technologies;


UPDATE PM_1.Projects SET InitialCost = InitialCost * 1.05 
WHERE 
PRJNO IN ( SELECT PRJNO FROM PM_1.ProjectTechnologies 
WHERE TechnologyId = (SELECT Id FROM PM_1.Technologies WHERE Name = 'ORACLE'));