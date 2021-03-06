USE [master]
GO
/****** Object:  Database [EDS]    Script Date: 5/11/2020 11:41:02 PM ******/
CREATE DATABASE [EDS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EDS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EDS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EDS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EDS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EDS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EDS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EDS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EDS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EDS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EDS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EDS] SET ARITHABORT OFF 
GO
ALTER DATABASE [EDS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EDS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EDS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EDS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EDS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EDS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EDS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EDS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EDS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EDS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EDS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EDS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EDS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EDS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EDS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EDS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EDS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EDS] SET RECOVERY FULL 
GO
ALTER DATABASE [EDS] SET  MULTI_USER 
GO
ALTER DATABASE [EDS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EDS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EDS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EDS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EDS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EDS', N'ON'
GO
ALTER DATABASE [EDS] SET QUERY_STORE = OFF
GO
USE [EDS]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffNo] [smallint] NOT NULL,
	[fName] [varchar](100) NOT NULL,
	[lName] [varchar](100) NOT NULL,
	[CarNo] [smallint] NOT NULL,
	[Position] [varchar](50) NOT NULL,
	[Gender] [nchar](10) NULL,
	[DOB] [datetime] NOT NULL,
	[BranchNo] [int] NULL,
	[Telphone] [varchar](15) NOT NULL,
	[trackClients] [int] NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientNo] [smallint] NOT NULL,
	[fName] [nvarchar](50) NOT NULL,
	[lName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[ProvLicenceNo] [nvarchar](50) NOT NULL,
	[Written_Test_Passed] [varchar](50) NOT NULL,
	[SpecialNeedDesc] [varchar](500) NULL,
	[BranchNo] [int] NOT NULL,
	[StaffNo] [smallint] NOT NULL,
	[DoB] [date] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[StaffNo] [smallint] NOT NULL,
	[clientNo] [smallint] NOT NULL,
	[dateOfLesson] [datetime] NOT NULL,
	[startTime] [time](7) NOT NULL,
	[endTime] [time](7) NULL,
	[block] [tinyint] NOT NULL,
	[StartMilleage] [int] NOT NULL,
	[fee] [decimal](8, 2) NULL,
	[EndMileage] [int] NOT NULL,
 CONSTRAINT [PK_Lesson] PRIMARY KEY CLUSTERED 
(
	[StaffNo] ASC,
	[clientNo] ASC,
	[dateOfLesson] ASC,
	[startTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Client_Lesson]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[Client_Lesson] 
		AS
		SELECT c.fName, c.lName, c.Gender, c.SpecialNeedDesc, l.dateOfLesson, l.StaffNo, l.startTime, l.endTime
		FROM Client c INNER JOIN
		     Lesson l 
			 ON c.ClientNo = l.ClientNo
GO
/****** Object:  View [dbo].[Lesson_Info]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	 CREATE VIEW [dbo].[Lesson_Info]
	    AS 
		SELECT  st.StaffNo, st.fName, st.lName, cl.dateOfLesson, cl.startTime, cl.endTime
			FROM Client_Lesson  cl JOIN Staff st
		ON cl.StaffNo = st.StaffNo
GO
/****** Object:  Table [dbo].[Inspection]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inspection](
	[CarNo] [smallint] NOT NULL,
	[InspectionDateTime] [datetime] NOT NULL,
	[numberFaults] [smallint] NULL,
	[FaultsDescription] [text] NULL,
	[StaffNo] [smallint] NOT NULL,
 CONSTRAINT [PK_Inspection] PRIMARY KEY CLUSTERED 
(
	[CarNo] ASC,
	[InspectionDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview](
	[ClientNo] [smallint] NOT NULL,
	[date] [datetime] NOT NULL,
	[StaffNo] [smallint] NOT NULL,
 CONSTRAINT [PK_Interview] PRIMARY KEY CLUSTERED 
(
	[date] ASC,
	[StaffNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TimeTable]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[TimeTable] AS(
	
	SELECT StaffNo, dateOfLesson as DATE, 'Attending a Lesson' AS Task 
	FROM Lesson
	UNION ALL
	SELECT StaffNo, date, 'Having an Interview with a Client' AS Task
	FROM Interview
	UNION ALL
	SELECT StaffNo, InspectionDateTime, 'Inspecting the Car' AS Task
	FROM Inspection
	) 

GO
/****** Object:  View [dbo].[Clients_Passed_Written]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	 CREATE VIEW [dbo].[Clients_Passed_Written]
	 AS 
	 SELECT * 
	 FROM Client
	 WHERE Written_Test_Passed = 'Passed' 
GO
/****** Object:  View [dbo].[OK_Clients_failed_Written]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OK_Clients_failed_Written]
	     AS 
		 SELECT * 
			FROM Client
			WHERE Written_Test_Passed = 'failed' AND  SpecialNeedDesc = 'Ok'
GO
/****** Object:  UserDefinedFunction [dbo].[getTotalLessons]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE   FUNCTION [dbo].[getTotalLessons] ()
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
/****** Object:  UserDefinedFunction [dbo].[getTotalLessonsBeforeDate]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getTotalLessonsBeforeDate] (@dateVar DATETIME)
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
/****** Object:  UserDefinedFunction [dbo].[clientLesson]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       CREATE FUNCTION [dbo].[clientLesson](@clientId smallint)
	   RETURNS TABLE 
	   AS 
	   RETURN (
	      SELECT c.ClientNo, c.fName, c.lName, l.dateOfLesson, l.startTime, l.endTime 
		  FROM Client c INNER JOIN Lesson l 
		  ON c.ClientNo = l.ClientNo
		  WHERE c.ClientNo = @clientId
		  )
GO
/****** Object:  View [dbo].[computeMileage]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[computeMileage]
				 AS 
				 SELECT StaffNo, clientNo, dateOfLesson, 
				     endMileage-startMilleage AS  Mileage, DATEDIFF(hour, startTime, endTime)*fee AS Cost
					 FROM Lesson
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[BranchNo] [int] NOT NULL,
	[address] [varchar](250) NOT NULL,
	[city] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[BranchNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car](
	[CarNo] [smallint] IDENTITY(1,1) NOT NULL,
	[BranchNo] [int] NOT NULL,
	[registrationNo] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CarNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[computeMileageTable]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[computeMileageTable](
	[StaffNo] [smallint] NOT NULL,
	[clientNo] [smallint] NOT NULL,
	[dateOfLesson] [datetime] NOT NULL,
	[Mileage] [int] NULL,
	[Cost] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrivingTest]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivingTest](
	[ClientNo] [smallint] NOT NULL,
	[date] [datetime] NOT NULL,
	[drivingTestResult] [varchar](50) NOT NULL,
	[ReasonForFailing] [text] NULL,
	[attempsTracker] [smallint] NULL,
 CONSTRAINT [PK_DrivingTest] PRIMARY KEY CLUSTERED 
(
	[ClientNo] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD  CONSTRAINT [FK_Car_BranchNo] FOREIGN KEY([BranchNo])
REFERENCES [dbo].[Branch] ([BranchNo])
GO
ALTER TABLE [dbo].[Car] CHECK CONSTRAINT [FK_Car_BranchNo]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Client] FOREIGN KEY([BranchNo])
REFERENCES [dbo].[Branch] ([BranchNo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Branch_Client]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Client] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([StaffNo])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Staff_Client]
GO
ALTER TABLE [dbo].[DrivingTest]  WITH CHECK ADD  CONSTRAINT [FK_Tested_Client] FOREIGN KEY([ClientNo])
REFERENCES [dbo].[Client] ([ClientNo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DrivingTest] CHECK CONSTRAINT [FK_Tested_Client]
GO
ALTER TABLE [dbo].[Inspection]  WITH CHECK ADD  CONSTRAINT [FK_Inspect_CarNo] FOREIGN KEY([CarNo])
REFERENCES [dbo].[Car] ([CarNo])
GO
ALTER TABLE [dbo].[Inspection] CHECK CONSTRAINT [FK_Inspect_CarNo]
GO
ALTER TABLE [dbo].[Inspection]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Inspector] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([StaffNo])
GO
ALTER TABLE [dbo].[Inspection] CHECK CONSTRAINT [FK_Staff_Inspector]
GO
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interviewed_Client] FOREIGN KEY([ClientNo])
REFERENCES [dbo].[Client] ([ClientNo])
GO
ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interviewed_Client]
GO
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interviewing_Staff] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([StaffNo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interviewing_Staff]
GO
ALTER TABLE [dbo].[Lesson]  WITH CHECK ADD  CONSTRAINT [FK_Client_Lesson] FOREIGN KEY([clientNo])
REFERENCES [dbo].[Client] ([ClientNo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Lesson] CHECK CONSTRAINT [FK_Client_Lesson]
GO
ALTER TABLE [dbo].[Lesson]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Instructor] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([StaffNo])
GO
ALTER TABLE [dbo].[Lesson] CHECK CONSTRAINT [FK_Staff_Instructor]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Staff] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([StaffNo])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Staff]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [check_gender_client] CHECK  (([Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [check_gender_client]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [check_gender] CHECK  (([Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [check_gender]
GO
/****** Object:  StoredProcedure [dbo].[get_car_faults]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[get_car_faults]
			  @CarNo smallint , @dateBy DATETIME 
			  AS 
					 SELECT * 
					 FROM Inspection 
					 WHERE CarNo = @CarNo AND inspectionDateTime <= @dateBy
GO
/****** Object:  StoredProcedure [dbo].[get_client_Lessons]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_client_Lessons]
	@theClientNo smallint 
	 AS
	 SELECT l.*
	   FROM Lesson l
	   WHERE l.ClientNo = @theClientNo
GO
/****** Object:  StoredProcedure [dbo].[get_instructor_Lessons]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_instructor_Lessons]
	@theStaffNo smallint 
	 AS
	 SELECT l.*
	   FROM Lesson l
	   WHERE l.StaffNo = @theStaffNo
GO
/****** Object:  StoredProcedure [dbo].[get_lesson_afterDate]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       CREATE PROCEDURE [dbo].[get_lesson_afterDate]
	   @StaffNo smallint, @lessonStartDate DATETIME
	   AS 
			SELECT * 
			FROM Lesson l 
			WHERE l.StaffNo = @StaffNo AND l.dateOfLesson >= @lessonStartDate
GO
/****** Object:  StoredProcedure [dbo].[get_lesson_afterDate_for_Client]    Script Date: 5/11/2020 11:41:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_lesson_afterDate_for_Client]
	   @ClientNo smallint, @lessonStartDate DATETIME
	   AS 
			SELECT * 
			FROM Lesson l 
			WHERE l.ClientNo = @ClientNo AND l.dateOfLesson >= @lessonStartDate
GO
USE [master]
GO
ALTER DATABASE [EDS] SET  READ_WRITE 
GO
