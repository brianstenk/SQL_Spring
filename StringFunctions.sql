
  -- STRING FUNCTIONS 


 --********Check why it is not working 
  CREATE OR ALTER FUNCTION endAndBegining(@str varchar(250))
    RETURNS TABLE
        AS
        --BEGIN
	       IF CHARINDEX('.', @str )	= 0 
		   RETURN SELECT @str

		   ELSE

		  RETURN(
	
	      SELECT LEFT( @str, 
              (SELECT CHARINDEX('.', @str))-1) As Part1, 
			  
			  (SELECT SUBSTRING(@str, 
		          (SELECT LEN(@str) - (SELECT CHARINDEX('.', 
		                        (REVERSE(@str)))-1)+1), 
								(SELECT LEN(@str))))  AS Part2 )
		
		

		/*	the delimeter position - reverse and count 
			diff - length of string - the count 
			substring from diff to the last*/
       
	    /*SELECT CHARINDEX('.', (REVERSE('Server1.officeBranches.USA')))-1
		
		SELECT LEN('Server1.officeBranches.USA') - (SELECT CHARINDEX('.', 
		                        (REVERSE('Server1.officeBranches.USA')))-1)+1
       
	    SELECT SUBSTRING('Server1.officeBranches.USA', 
		          (SELECT LEN('Server1.officeBranches.USA') - (SELECT CHARINDEX('.', 
		                        (REVERSE('Server1.officeBranches.USA')))-1)+1), 
								(SELECT LEN('Server1.officeBranches.USA')))*/

-- Another Approach 
 CREATE OR ALTER FUNCTION endAndBegining(
        @str varchar(200)
		)
    RETURNS TABLE
        AS
   		  RETURN(
	 
	      SELECT LEFT( 'Server1.officeBranches.USA', 
              (SELECT CHARINDEX('.', 'Server1.officeBranches.USA'))-1) As Part1, 
			  
			  (SELECT SUBSTRING('Server1.officeBranches.USA', 
		          (SELECT LEN('Server1.officeBranches.USA') - (SELECT CHARINDEX('.', 
		                        (REVERSE('Server1.officeBranches.USA')))-1)+1), 
								(SELECT LEN('Server1.officeBranches.USA'))))  AS Part2 )

		--Test 
		SELECT * FROM endAndBegining()

		----- Another Approach 
 --@str = 'Server1.officeBranches.USA'
 --'Server3.officeBranches.UK'
 CREATE OR ALTER FUNCTION endAndBegining3(
        @str varchar(450)
		)
    RETURNS TABLE
        AS
		BEGIN
		  CASE WHEN ((SELECT CHARINDEX('.', @str)) < 1) 
		            THEN PRINT @str

		  WHEN ((SELECT CHARINDEX('.', @str)) >= 1) 
		   
   		  THEN RETURN(
	 
	      SELECT LEFT( @str, 
              (SELECT CHARINDEX('.', @str))-1) As Part1, 
			  
			  (SELECT SUBSTRING(@str, 
		          (SELECT LEN(@str) - (SELECT CHARINDEX('.', 
		                        (REVERSE(@str)))-1)+1), 
								(SELECT LEN(@str))))  AS Part2 )

			END
		END

		--Test 
		SELECT * FROM endAndBegining1('Server3.officeBranches.UK')
		SELECT * FROM endAndBegining1('Server1.officeBranches.USA')
		SELECT * FROM endAndBegining1('Server5') --Boundary Condition