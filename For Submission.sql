--PROJECT ONE 
--Asumption made:
-- Each Car is assigned to staff and in the Lesson, the staff can never use the cars that are not theirs
-- During Inspection, a member of Staff can assist in inpection even if it is not the owner of the car

--(a)  The names and the telephone numbers of the Managers of each office. 
	   SELECT fName, lName, Telphone
	   FROM Staff
	   WHERE Position = 'Manager';


-- (b)  The full address of all offices in Glasgow. 
		 SELECT address 
		 FROM BRANCH
		 WHERE city = 'Glasgow'

-- (c)  The names of all female Instructors based in the Glasgow, Bearsden office. 
    SELECT fName, lName, Position
	FROM Staff
	WHERE Gender = 'Female' AND Position IN ('Manager', 'Instructor', 'Senior Instructor')

-- (d)  The total number of staff at each office. 
	SELECT BranchNo, COUNT(*) AS NoOfStaff
	FROM Staff
	GROUP BY BranchNo

--(e)  The total number of clients (past and present) in each city. 
	SELECT  
		(SELECT city
		FROM Branch 
		WHERE BranchNo = c.BranchNo ) City,
		COUNT(*) NoOfClients_Per_City
	FROM Client c
	GROUP BY BranchNo

	
-- (f)  The timetable of appointments for a given Instructor next week. 
/*	CREATE VIEW TimeTable AS(
	
	SELECT StaffNo, dateOfLesson as DATE, 'Attending a Lesson' AS Task 
	FROM Lesson
	UNION ALL
	SELECT StaffNo, date, 'Having an Interview with a Client' AS Task
	FROM Interview
	UNION ALL
	SELECT StaffNo, InspectionDateTime, 'Inspecting the Car' AS Task
	FROM Inspection
	) */
	--Used the View Above
	-- DROP VIEW TimeTable
	--10TH - 16TH
	SELECT * FROM TimeTable
	WHERE DATE >= '2020-05-17' AND DATE <= '2021-05-23'

-- (g)  The details of interviews conducted by a given Instructor. 
	SELECT *
		FROM Interview
	WHERE date < GETDATE()



  --(h)The total number of female and male clients (past and present) in the Glasgow, 
  -- Bearsden office. 

	  SELECT  COUNT(CASE WHEN UPPER(Gender) = 'MALE' 
	                 THEN  1 END) AS Male_Clients,
		             COUNT(CASE WHEN UPPER(Gender) = 'FEMALE' 
					 THEN 1 END) AS Female_Clients,
		             COUNT(ClientNo) AS 'Total Clients'  
			  FROM Client
			  Where BranchNo IN (Select BranchNo
                    From Branch
                    WHERE City = 'Glasgow' AND address LIKE '%Bearsden%')

				   -- Test 
				   select * from branch
				   select * from client


-- Part 2 :
-- 7)	Write a stored procedure that takes in one argument, the staff number of an instructor.  
--The procedure outputs all details of all the lessons for that instructor.

-- INPUT StaffNo and out puts lessons

CREATE PROCEDURE get_instructor_Lessons
	@theStaffNo smallint 
	 AS
	 SELECT l.*
	   FROM Lesson l
	   WHERE l.StaffNo = @theStaffNo

	   --Test 
	 EXEC get_instructor_Lessons 3



-- 8)Write a stored procedure that takes in two arguments, a staff number and a date.  
-- The procedure shows details of All lessons for that staff instructor, starting at the date of the argument,
--and ending seven days later.
       CREATE PROCEDURE get_lesson_afterDate
	   @StaffNo smallint, @lessonStartDate DATETIME
	   AS 
			SELECT * 
			FROM Lesson l 
			WHERE l.StaffNo = @StaffNo AND l.dateOfLesson >= @lessonStartDate

			--Test 
			EXEC get_lesson_afterDate 3, '2012-03-03'

--  8.5)    a)  Do the same as questions 7 and 8 above, but for a client number instead of a 
  --  staff number.
		CREATE PROCEDURE get_client_Lessons
			@theClientNo smallint 
			 AS
			 SELECT l.*
			   FROM Lesson l
			   WHERE l.ClientNo = @theClientNo

			   --Test 
			 EXEC get_client_Lessons 3            
  
 
 -- Client and lesson from the start date 
		 CREATE PROCEDURE get_lesson_afterDate_for_Client
			   @ClientNo smallint, @lessonStartDate DATETIME
			   AS 
					SELECT * 
					FROM Lesson l 
					WHERE l.ClientNo = @ClientNo AND l.dateOfLesson >= @lessonStartDate

					--Test 
					EXEC get_lesson_afterDate_for_Client 3, '2012-03-03'

--  b)  Create some stored procedures yourself which do something you would like   
              -- to see being done.
			  -- That gives the faults of the car(with car no and date by)
		CREATE PROCEDURE get_car_faults
			  @CarNo smallint , @dateBy DATETIME 
			  AS 
					 SELECT * 
					 FROM Inspection 
					 WHERE CarNo = @CarNo AND inspectionDateTime <= @dateBy

					 --Test 
					 get_car_faults 1, '2019-12-15'


--9)a)  Create a View called Client_Lesson which does an inner join on the Client and    
    -- Lesson tables.  Run it to make sure it works properly!  
	CREATE VIEW Client_Lesson 
		AS
		SELECT c.fName, c.lName, c.Gender, c.SpecialNeedDesc, l.dateOfLesson, l.StaffNo, l.startTime, l.endTime
		FROM Client c INNER JOIN
		     Lesson l 
			 ON c.ClientNo = l.ClientNo

			 --Test 
			 SELECT * FROM Client_Lesson 

   -- b)  Create a View called  Lesson_Info  which calls the View above  
     --Client_Lesson,  and outputs all the information from  Client_Lesson,  along with who    
     --the staff person is for the lesson, i.e. the staff person’s name and staffID.
     --One View can call another view, which makes things very flexible.
	 CREATE VIEW Lesson_Info
	    AS 
		SELECT  st.StaffNo, st.fName, st.lName, cl.dateOfLesson, cl.startTime, cl.endTime
			FROM Client_Lesson  cl JOIN Staff st
		ON cl.StaffNo = st.StaffNo

		--Test
		select * from Lesson_Info	   		 

     --c)  Create two more views that may be useful to you.  Test them!
	 CREATE VIEW Clients_Passed_Written
	 AS 
	 SELECT * 
	 FROM Client
	 WHERE Written_Test_Passed = 'Passed' 

	 --tEST
	 SELECT * FROM Clients_Passed_Written

	--Clients who failed the written test with  no Special needs 
	 	 CREATE VIEW OK_Clients_failed_Written
	     AS 
		 SELECT * 
			FROM Client
			WHERE Written_Test_Passed = 'failed' AND  SpecialNeedDesc = 'Ok'

			--Test
			SELECT * FROM OK_Clients_failed_Written


-- 10) a)  Create a user defined function that returns the total lessons that a client has taken up to today.
      --count lessons of a specific client before today 
	 CREATE OR ALTER FUNCTION getTotalLessons ()
	 RETURNS TABLE
	 AS
	    RETURN 
		   (
	 	     SELECT ClientNo, COUNT(*) AS NoOfLessons
		     FROM Lesson
			 WHERE dateOfLesson <= GETDATE()
			GROUP BY ClientNo
		   )
		GO

		-- Test 
		SELECT * FROM getTotalLessons()

--  b)  Create a user defined function that returns the total lessons that a client
--has taken before a date supplied by the user.
     CREATE FUNCTION getTotalLessonsBeforeDate (@dateVar DATETIME)
	 RETURNS TABLE
	 AS
	    RETURN 
		   (
	 	     SELECT ClientNo, COUNT(*) AS NoOfLessons
		     FROM Lesson
			 WHERE dateOfLesson < @dateVar
			 GROUP BY ClientNo
		   );
		GO

		--Test 
		SELECT * FROM getTotalLessonsBeforeDate ('2020-08-09')


--11) Create a user defined function that returns a table which does an 
--inner join on the Client and Lesson tables, for a particular client which 
--is supplied by the user.  Run it to make sure it works properly!  
       CREATE FUNCTION clientLesson(@clientId smallint)
	   RETURNS TABLE 
	   AS 
	   RETURN (
	      SELECT c.ClientNo, c.fName, c.lName, l.dateOfLesson, l.startTime, l.endTime 
		  FROM Client c INNER JOIN Lesson l 
		  ON c.ClientNo = l.ClientNo
		  WHERE c.ClientNo = @clientId
		  )

		  --Test
		 SELECT * FROM clientLesson(2)
		 SELECT * FROM clientLesson(3)
    

-- 12) Triggers :
-- a)  Read about them in the Help menu.
-- reference

--  We will now Update the guestName attribute in the Guest table.  A trigger will fire
--  showing us the old value And the new value of guestName.
--  The code checks to see IF the guestName column was the column that was updated.  It does
--  this with the Update function which returns true if the argument column
--  is the one that was updated.


-- b)  In the Staff table, add an attribute to keep track of the total 
--  number of clients that an instructor has.  Whenever a new client is added to 
----the Client table, we add one to the above new attribute, to the staff person who 
-- is working with this new client.  A similar thing is done if a client is removed 
 -- from our Client table.

 --DROP TRIGGER track_clients_perstaff

  CREATE OR ALTER TRIGGER track_clients_perstaff ON Client
  AFTER INSERT, DELETE
  AS
     --DECLARE @action CHAR(8)  
         -- IF COLUMNS_UPDATED() <> 0 -- delete or update?
             BEGIN     
                IF EXISTS (SELECT * FROM Deleted) -- updated cols + old rows means action=update       
				    BEGIN
					UPDATE s
					SET s.trackClients = s.trackClients - 1
                         FROM Staff s inner join Deleted d --(Deleted from Client)
                    ON s.StaffNo = d.StaffNo
					END

			   ELSE IF EXISTS (SELECT * FROM Inserted)-- insert    
			   BEGIN
                  UPDATE s
				  SET s.trackClients = s.trackClients + 1
				 
				   FROM Staff s inner join Inserted i
                   ON s.StaffNo = i.StaffNo
               END
	    END 
	   

	-- ***********************************************	
-- Test for Insert	
	INSERT INTO Client(ClientNo, fName, lName, Gender, ProvLicenceNo, Written_Test_Passed, SpecialNeedDesc, BranchNo, StaffNo, DoB)
	            VALUES(7, 'Jia', 'Jed', 'Male', '109D', 'Passed', 'Ok',2, 4, '1988-06-06')

	INSERT INTO Client(ClientNo, fName, lName, Gender, ProvLicenceNo, Written_Test_Passed, SpecialNeedDesc, BranchNo, StaffNo, DoB)
	            VALUES(8, 'Jir', 'Jet', 'Female', '109E', 'Passed', 'Ok',2, 4, '1988-04-04')
	INSERT INTO Client(ClientNo, fName, lName, Gender, ProvLicenceNo, Written_Test_Passed, SpecialNeedDesc, BranchNo, StaffNo, DoB)
	            VALUES(6, 'MN', 'MT', 'Female', '112D', 'Passed', 'Ok',2, 3, '1974-06-06')
--Test for Delete    
     DELETE FROM  Client
	 	 WHERE ClientNo = 9
	

select * from Staff

SELECT * FROM Client


--13)	 Write, execute and test (make sure the output is correct!!) the last seven queries  on page  B-5.
--**********************************************************************

--(i) The numbers and name of staff who are Instructors and over 55 years old. 
		 SELECT StaffNo, fName, lName 
		 FROM Staff
		 WHERE (YEAR(GETDATE())- YEAR(DOB)) >= 55


 -- (j) The registration number of cars that have had no faults found.
 
		 SELECT CarNo
		   From Car 
		      WHERE CarNO NOT IN(SELECT CarNo 
		 From Inspection Where NumberFaults <> 0 )

 --select * from Inspection

 -- (k) The registration number of the cars used by Instructors at the Glasgow, Bearsden office.
         SELECT C.CarNo
         FROM Car c JOIN Staff s ON c.CarNo=s.CarNo JOIN Branch b ON s.BranchNo=b.BranchNo
			WHERE city='Glasgow' AND Address Like'%Bearsden%' and Position
			IN('Instructor' , 'Senior Instructor' , 'Manager' )


 --(l) The names of clients who passed the driving test in January 2013. 
			SELECT fName, lName
				FROM Client c INNER JOIN DrivingTest d 
				ON c.ClientNo=d.ClientNo
						WHERE d.date < '2013-01-30' AND d.date >= '2013-01 -01'
						
						--SELECT * FROM DrivingTest
 
 --(m) The names of clients who have sat the driving test more than three times and have still not passed. 
		 SELECT fName, lName
			 FROM Client c INNER JOIN DrivingTest d 
			 ON c.ClientNo=d.ClientNo
				WHERE attempsTracker > 3 AND drivingTestResult <> 'Pass'
		
	--	Select * From Lesson
 --(n) The average number of miles driven during a one-hour lesson, 
		 SELECT AVG(EndMileage - StartMilleage) AS AvMileage
			FROM Lesson
 


 --(o) The number of administrative staff located at each office.
		 SELECT BranchNo, COUNT(*) AS NoOfAdminStaff
		 FROM Staff
		 Where Position = 'Administrator' 
		 GROUP BY BranchNo


/*Part 3 :
14)  Using Microsoft Access 2000, connect to SQL Server 2008 and do the following :
      a)  Create ‘Linked’ tables to your tables on SQL Server 
	  b)	Create Reports using the Report tab.  They should look very good and professional.
	        c)   Create Forms using the Forms tab.  Allow the user to change some data in the 
             SQL Server table through the form.  Certain attributes, like the primary key 
             should Not be updateable. The Forms should look very good and professional.
             If you have time try different colors.
			 			 			
     15)  Cursors :
	             a)  Read the file I gave you about cursors.  Look at the SQL SERVER help for 
                 cursors.
				 b)  Use a cursor to read the rows of the Lesson table.  
                 If the mileage for the lesson was over 20 miles, increase the fee by $5.
                 If the mileage for the lesson was over 25 miles, increase the fee by $8.
                 If the mileage for the lesson was over 30 miles, increase the fee by $10.
                 You can use an  If  …  ELSE  …  statement.  Check out this statement on 
                 the Microsoft home page.  
				 Then try the same thing with a Case statement.  Check out this statement on 
                 the Microsoft home page.  */
				 				 
				/* Cursors help in retreiving a set of records row by row, useful
				 but extremely slow*/
-- SELECT DATEDIFF(hour, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
  /*  16)  Run some SQL using the While statement.  Check out this statement on 
           the Microsoft home page.  
		   			 Extra Credit :
We are expanding our business to give flying lessons as well as driving lessons.
Add Pilots, Planes, flying lessons, etc. to your project.
Expand your ER diagram, create more tables, more queries, etc.

*/       

         DECLARE @Mileage AS int, 
		         @INCREMENT DECIMAL, 
		         @Cost DECIMAL 

         DECLARE increaseFee_Cur CURSOR
					FOR SELECT  EndMileage - StartMilleage As Mile, fee
					     FROM Lesson 

				-- select * from Lesson

	    OPEN increaseFee_Cur 
		
		FETCH NEXT FROM increaseFee_Cur INTO @Mileage, @Cost

		WHILE @@FETCH_STATUS = 0 --Otherwise would be -1
				BEGIN
					IF (@Mileage > 30) SELECT @INCREMENT = @Cost + 10 
					ELSE IF (@Mileage > 25 AND @Mileage <=30)
					    SELECT @INCREMENT = @Cost + 8
					ELSE IF (@Mileage > 20 AND @Mileage <= 25) --20
					     SELECT @INCREMENT = @Cost + 5
					
					ELSE IF (@Mileage <=20) SELECT @INCREMENT = @Cost 

					ELSE PRINT 'NOT ALLOCATED'
					   
				PRINT CAST(@Mileage AS VARCHAR) + ' The new costs are '+ CAST(@INCREMENT AS VARCHAR) --For testing		
				UPDATE Lesson 
						 SET fee = @INCREMENT WHERE CURRENT OF increaseFee_Cur
				
				FETCH NEXT FROM increaseFee_Cur INTO @Mileage, @Cost
				END 

				CLOSE increaseFee_Cur
				DEALLOCATE increaseFee_Cur
	
	
	SELECT * FROM Lesson
	--Using CASE 
	
DECLARE
      @Miles AS smallint, 
      @Fee AS DECIMAL,
      @increment1 AS FLOAT

		DECLARE Fees_Cursor CURSOR FOR
				SELECT  EndMileage - StartMilleage As Miles, fee from Lesson FOR UPDATE OF fee

			OPEN Fees_Cursor
				
			FETCH NEXT FROM Fees_Cursor
				INTO @Miles, @FEE 

			WHILE @@FETCH_STATUS = 0
				BEGIN
					SELECT @increment1 = CASE WHEN @Miles > 30 THEN @FEE+10
											 WHEN @Miles >25 AND @Miles <= 30  THEN @FEE+8
											 WHEN @Miles >20  AND @Miles <= 25 THEN @FEE+3
											 WHEN @Miles <=20 THEN @FEE 
			                             END
				
					UPDATE Lesson SET fee = @increment1 WHERE CURRENT OF Fees_Cursor 
					FETCH NEXT FROM Fees_Cursor
					INTO @Miles, @Fee
				END

				CLOSE Fees_Cursor

				DEALLOCATE Fees_Cursor
--tEST 
SELECT * FROM Lesson