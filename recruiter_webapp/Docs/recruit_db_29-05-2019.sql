USE [master]
GO
/****** Object:  Database [recruit_db]    Script Date: 29-May-19 03:43:24 PM ******/
CREATE DATABASE [recruit_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'recruit_db', FILENAME = N'D:\Microsoft SQL Server\MSSQL14.INSYNCSQL\MSSQL\DATA\recruit_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'recruit_db_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL14.INSYNCSQL\MSSQL\DATA\recruit_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [recruit_db] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [recruit_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [recruit_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [recruit_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [recruit_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [recruit_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [recruit_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [recruit_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [recruit_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [recruit_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [recruit_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [recruit_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [recruit_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [recruit_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [recruit_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [recruit_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [recruit_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [recruit_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [recruit_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [recruit_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [recruit_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [recruit_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [recruit_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [recruit_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [recruit_db] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [recruit_db] SET  MULTI_USER 
GO
ALTER DATABASE [recruit_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [recruit_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [recruit_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [recruit_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [recruit_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [recruit_db] SET QUERY_STORE = OFF
GO
USE [recruit_db]
GO
/****** Object:  UserDefinedTableType [dbo].[QualificationsTableType]    Script Date: 29-May-19 03:43:25 PM ******/
CREATE TYPE [dbo].[QualificationsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SkillsTableType]    Script Date: 29-May-19 03:43:25 PM ******/
CREATE TYPE [dbo].[SkillsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  Table [dbo].[candidates]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[candidate_name] [varchar](150) NOT NULL,
	[dob] [date] NOT NULL,
	[gender] [char](10) NOT NULL,
	[qualifications] [varchar](50) NOT NULL,
	[experience] [int] NOT NULL,
	[address] [varchar](250) NOT NULL,
	[others] [text] NOT NULL,
	[skills] [text] NOT NULL,
	[status] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[employer_comments] [text] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
 CONSTRAINT [PK_candidates] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] NULL,
	[name] [varchar](350) NULL,
	[address] [varchar](250) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip] [int] NULL,
	[contact] [varchar](350) NULL,
	[email] [varchar](350) NULL,
	[phone] [varchar](350) NULL,
	[active] [tinyint] NULL,
	[license] [varchar](350) NULL,
	[license_expiry] [datetime] NULL,
	[license_year] [int] NULL,
	[added_date] [datetime] NULL,
	[updated_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emp_branches]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emp_branches](
	[id] [int] NOT NULL,
	[employer_id] [int] NOT NULL,
	[branch_name] [varchar](350) NOT NULL,
	[address] [varchar](350) NOT NULL,
	[city] [varchar](350) NOT NULL,
	[state] [varchar](350) NOT NULL,
	[zip] [int] NOT NULL,
	[country] [int] NOT NULL,
	[email] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employers]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employers](
	[id] [int] NULL,
	[name] [varchar](350) NULL,
	[address] [varchar](250) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip] [int] NULL,
	[contact] [varchar](350) NULL,
	[email] [varchar](350) NULL,
	[phone] [varchar](350) NULL,
	[active] [tinyint] NULL,
	[license] [varchar](350) NULL,
	[license_expiry] [datetime] NULL,
	[license_year] [int] NULL,
	[added_date] [datetime] NULL,
	[updated_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_qualifications]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_qualifications](
	[id] [int] NOT NULL,
	[job_id] [int] IDENTITY(1,1) NOT NULL,
	[qualification_id] [int] NULL,
 CONSTRAINT [PK_job_qualifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_skills]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_skills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [int] NULL,
	[skill_id] [int] NULL,
 CONSTRAINT [PK_job_skills] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobs]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs](
	[id] [int] NULL,
	[job_code] [varchar](150) NULL,
	[description] [text] NULL,
	[employer_id] [int] NULL,
	[branch_id] [int] NULL,
	[vacancy_count] [int] NULL,
	[other_notes] [text] NULL,
	[experience] [int] NULL,
	[active] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qualifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications_temp]    Script Date: 29-May-19 03:43:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qualifications_temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](max) NULL,
	[userid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skills]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
 CONSTRAINT [PK_skills] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skills_temp]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skills_temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](max) NULL,
	[userid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](100) NOT NULL,
	[title] [varchar](100) NOT NULL,
 CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_level]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_level](
	[id] [int] NULL,
	[level_name] [varchar](20) NULL,
	[level_type] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_type]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_type](
	[id] [int] NULL,
	[type_name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](250) NOT NULL,
	[pwd] [varbinary](max) NOT NULL,
	[salt] [varbinary](4) NOT NULL,
	[user_level] [tinyint] NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[last_logged_in] [datetime] NULL,
	[ipaddress] [varchar](16) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_active]  DEFAULT ((1)) FOR [active]
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCandidates_Add] @candidate_name varchar(100), @dob date, @gender char(1), @qualifications varchar(50)=NULL, @experience int,
@address varchar(max) = NULL, @others varchar(max)=NULL, @skills varchar(max) = NULL, @status int, @rating int, @employer_comments varchar(max)=NULL, @added_date datetime, @updated_date datetime AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM candidates WHERE candidate_name=@candidate_name)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.candidates(candidate_name, dob, gender, qualifications, experience, address, others, skills, status, rating, employer_comments, added_date, updated_date) 
VALUES (@candidate_name, @dob, @gender, @qualifications, @experience,
@address, @others, @skills, @status, @rating, @employer_comments, @added_date, @updated_date);
SET @Ret = (SELECT id FROM candidates WHERE candidate_name=@candidate_name);
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidates_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM candidates WHERE id=@id)
 BEGIN 
 DELETE FROM candidates WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCandidates_Edit] @id int, @candidate_name varchar(100), @dob date, @gender char(1), @qualifications varchar(50)=NULL, @experience int,
@address varchar(max) = NULL, @others varchar(max)=NULL, @skills varchar(max) = NULL, @status int, @rating int, @employer_comments varchar(max)=NULL, @added_date datetime, @updated_date datetime AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;

UPDATE dbo.candidates SET candidate_name = @candidate_name, dob = @dob, gender = @gender, qualifications = @qualifications, experience = @experience, address = @address, others = @others, 
skills = @skills, status = @status, rating = @rating, employer_comments = @employer_comments, added_date = @added_date, updated_date = @updated_date WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCandidates_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM candidates ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by candidate_name';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCustomers_Add] @name varchar(100), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @contact varchar(max)=NULL, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @license varchar(max)=NULL, @license_expiry datetime, @license_year int, @added_date datetime, 
@updated_date datetime AS

BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM customers WHERE name=@name)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.customers(name, address, city, state, zip, contact, email, phone, active, license, license_expiry,
license_year, added_date, updated_date) VALUES(@name, @address, @city, @state, @zip, @contact, @email, @phone, 
@active, @license, @license_expiry, @license_year, @added_date, @updated_date);
SET @Ret = (SELECT id FROM customers WHERE name=@name);
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCustomers_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM customers WHERE id=@id)
 BEGIN 
 DELETE FROM customers WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCustomers_Edit] @id int, @name varchar(100), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @contact varchar(max)=NULL, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @license varchar(max)=NULL, @license_expiry datetime, @license_year int, @added_date datetime, 
@updated_date datetime AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.customers SET name = @name, address = @address, city = @city, state = @state, zip = @zip, contact = @contact, email = @email, phone = @phone, active = @active, license = @license, license_expiry = @license_expiry,
license_year = @license_year, added_date = @added_date, updated_date = @updated_date WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCustomers_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM customers ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by name';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Add] @job_code varchar(150), @description varchar(max)=NULL, @employer_id int, 
@branch_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @experience int, @active int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM jobs WHERE job_code=@job_code)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.jobs(job_code, description, employer_id, 
branch_id, vacancy_count, other_notes, experience, active) 
VALUES(@job_code, @description, @employer_id, 
@branch_id, @vacancy_count, @other_notes, @experience, @active);
SET @Ret = (SELECT id FROM jobs WHERE job_code=@job_code);
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM jobs WHERE id=@id)
 BEGIN 
 DELETE FROM jobs WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Edit] @id int, @job_code varchar(150), @description varchar(max)=NULL, @employer_id int, 
@branch_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @experience int, @active int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.jobs SET job_code = @job_code, description = @description, employer_id = @employer_id, 
branch_id = @branch_id, vacancy_count = @vacancy_count, other_notes = @other_notes, experience = @experience, active = @active 
WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspJobs_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM jobs ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by job_code';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications&Temp_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspQualifications&Temp_Get] @Userid int AS
BEGIN
SELECT qua.id as qua_id, qua.title as qua_title, tmp.id as tmp_id, tmp.title as tmp_title FROM qualifications as qua JOIN qualifications_temp as tmp ON qua.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Add] @title varchar(150), @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM qualifications WHERE title=@title)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.qualifications(title) VALUES(@title);
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add_FromFile]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* To insert records in Skills table through user defined table type */
CREATE PROCEDURE [dbo].[uspQualifications_Add_FromFile] @List AS dbo.QualificationsTableType READONLY, @Userid int, @RowsInserted int OUTPUT AS
BEGIN
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[qualifications_temp]') AND type in (N'U'))
CREATE TABLE qualifications_temp (
	id int IDENTITY(1,1) PRIMARY KEY,
	title varchar(max),
	userid int null
)
DELETE FROM qualifications_temp WHERE userid = @Userid
END
BEGIN
INSERT INTO qualifications_temp(title, userid) (SELECT t1.title, @Userid FROM @List as t1 INNER JOIN qualifications as t2 ON t1.title = t2.title)
END
BEGIN
INSERT INTO qualifications
SELECT * FROM @List AS t1
WHERE NOT EXISTS (
    SELECT title
    FROM qualifications AS t2 
    WHERE t1.title = t2.title
    )
END
SET @RowsInserted = @@ROWCOUNT



GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspQualifications_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM qualifications WHERE id=@id)
 BEGIN 
 DELETE FROM qualifications WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Edit] @id int, @title varchar(150) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.qualifications SET title = @title WHERE id=@id; 
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspQualifications_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM Qualifications WHERE title LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempQualifications AS
	(SELECT id, title,
	ROW_NUMBER() OVER (order by title) as RowNumber
	FROM Qualifications WHERE title LIKE @SrchVal+'%')

	SELECT * 
	FROM tempQualifications 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_GetSingle]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_GetSingle] @id int as
BEGIN
SELECT * FROM qualifications WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills&Temp_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspSkills&Temp_Get] @Userid int AS
BEGIN
SELECT skl.id as skl_id, skl.title as skl_title, tmp.id as tmp_id, tmp.title as tmp_title FROM skills as skl JOIN skills_temp as tmp ON skl.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Add] @title varchar(150), @Ret int OUTPUT AS
BEGIN
/*DECLARE @Ret int;*/
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM skills WHERE title=@title)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.skills(title) VALUES(@title);
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Add_FromFile]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* To insert records in Skills table through user defined table type */
CREATE PROCEDURE [dbo].[uspSkills_Add_FromFile] @List AS dbo.SkillsTableType READONLY, @Userid int, @RowsInserted int OUTPUT AS
BEGIN
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[skills_temp]') AND type in (N'U'))
CREATE TABLE skills_temp (
	id int IDENTITY(1,1) PRIMARY KEY,
	title varchar(max),
	userid int null
)
DELETE FROM skills_temp WHERE userid = @Userid
END
BEGIN
INSERT INTO skills_temp(title, userid) (SELECT t1.title, @Userid FROM @List as t1 INNER JOIN skills as t2 ON t1.title = t2.title)
END
BEGIN
INSERT INTO skills
SELECT * FROM @List AS t1
WHERE NOT EXISTS (
    SELECT title
    FROM skills AS t2 
    WHERE t1.title = t2.title
    )
END
SET @RowsInserted = @@ROWCOUNT



GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspSkills_Delete] @id int As
 DECLARE @Ret int;
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM skills WHERE id=@id) 
 BEGIN 
 DELETE FROM skills WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Edit] @id int, @title varchar(150) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.skills SET title = @title WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspSkills_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM Skills WHERE title LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempSkills AS
	(SELECT id, title,
	ROW_NUMBER() OVER (order by title) as RowNumber
	FROM Skills WHERE title LIKE @SrchVal+'%')

	SELECT * 
	FROM tempSkills 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_GetSingle]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_GetSingle] @id int as
BEGIN
SELECT * FROM skills WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_Add] @email varchar(250), @user_level int, 
@active int, @added_date datetime, @updated_date datetime, @last_logged_in datetime, @ipaddress varchar(16)=NULL AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM users WHERE email=@email)
BEGIN
SET @RET = -2;
END
ELSE
DECLARE @pwd VARBINARY(MAX);
SELECT @pwd = CAST(@email AS VARBINARY(MAX)); 
DECLARE @salt VARBINARY(4) = CRYPT_GEN_RANDOM(4);
BEGIN
INSERT INTO dbo.users(email, pwd, salt, user_level, active, added_date, updated_date, last_logged_in, ipaddress) 
VALUES(@email, CONVERT(varbinary, @pwd), @salt, @user_level, @active, @added_date, @updated_date, @last_logged_in, @ipaddress);
SET @Ret = (SELECT id FROM users WHERE email=@email);
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsers_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM users WHERE id=@id)
 BEGIN 
 DELETE FROM users WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Need to redo the code */
CREATE procedure [dbo].[uspUsers_Edit] @id int, @email varchar(250), @user_level int, 
@active int, @added_date datetime, @updated_date datetime, @last_logged_in datetime, @ipaddress varchar(16)=NULL AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
DECLARE @pwd VARBINARY(MAX);
 SELECT @pwd = CAST(@email AS VARBINARY(MAX)); 
 DECLARE @salt VARBINARY(4) = CRYPT_GEN_RANDOM(4);
UPDATE dbo.users SET email = @email, user_level = @user_level, active = @active, updated_date = @updated_date WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspUsers_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM users ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by id';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Add]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUserTypes_Add] @type_name varchar(50) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM user_type WHERE type_name=@type_name)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.user_type(type_name) VALUES(@type_name);
SET @Ret = (SELECT id FROM user_type WHERE type_name=@type_name);
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Delete]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUserTypes_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM user_type WHERE id=@id)
 BEGIN 
 DELETE FROM user_type WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Edit]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUserTypes_Edit] @id int, @type_name varchar(50) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.user_type SET type_name = @type_name WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Get]    Script Date: 29-May-19 03:43:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspUserTypes_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM user_types ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by type_name';
exec(@sql);
end
GO
USE [master]
GO
ALTER DATABASE [recruit_db] SET  READ_WRITE 
GO
