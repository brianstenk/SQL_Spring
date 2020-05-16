--ALTER TABLE dbo.Staff
   --ALTER COLUMN fName varchar(100) not null;
   --ALTER COLUMN   lName varchar(100) not null;
  -- ALTER COLUMN CarNo varchar(50) not null
   -- ALTER COLUMN Position varchar(50) not null
   -- ALTER COLUMN EndMileage int not null
	--ALTER COLUMN Gender nchar(10)
	                      --  check(GENDER in ('Male', 'Female', 'Unknown'))


--ALTER TABLE Client
--ADD CONSTRAINT check_gender_client
--CHECK (Gender IN ('Male', 'Female'));

DROP TABLE IF EXISTS Car
CREATE TABLE Car (
 CarNo smallint IDENTITY(1,1) NOT NULL PRIMARY KEY,
 BranchNo SMALLINT NOT NULL,
 registrationNo VARCHAR(15) NOT NULL)