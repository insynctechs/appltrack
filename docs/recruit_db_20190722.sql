USE [master]
GO
/****** Object:  Database [recruit_db]    Script Date: 22-Jul-19 12:36:35 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[QualificationsTableType]    Script Date: 22-Jul-19 12:36:36 PM ******/
CREATE TYPE [dbo].[QualificationsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SkillsTableType]    Script Date: 22-Jul-19 12:36:36 PM ******/
CREATE TYPE [dbo].[SkillsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  Table [dbo].[candidates]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [varchar](150) NOT NULL,
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
/****** Object:  Table [dbo].[customer_staffs]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_staffs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[name] [varchar](350) NOT NULL,
	[gender] [char](10) NOT NULL,
	[designation] [varchar](250) NOT NULL,
	[address] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[email] [varchar](350) NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[logged_in_user_id] [int] NOT NULL,
 CONSTRAINT [PK_customer_staffs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](350) NOT NULL,
	[address] [varchar](250) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[state] [varchar](50) NOT NULL,
	[zip] [int] NOT NULL,
	[contact] [varchar](350) NOT NULL,
	[email] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[active] [tinyint] NOT NULL,
	[license] [varchar](350) NULL,
	[license_expiry] [datetime] NOT NULL,
	[license_year] [int] NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emp_branches]    Script Date: 22-Jul-19 12:36:36 PM ******/
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
/****** Object:  Table [dbo].[employer_locations]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employer_id] [int] NOT NULL,
	[address] [varchar](250) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[zip] [int] NOT NULL,
	[country] [varchar](100) NOT NULL,
	[email] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
 CONSTRAINT [PK_employer_locations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_staffs]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_staffs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[employer_id] [int] NOT NULL,
	[employer_location_id] [int] NOT NULL,
	[name] [varchar](350) NOT NULL,
	[gender] [char](10) NOT NULL,
	[designation] [varchar](250) NOT NULL,
	[address] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[email] [varchar](350) NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[logged_in_user_id] [int] NOT NULL,
 CONSTRAINT [PK_employer_staffs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employers]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](350) NOT NULL,
	[address] [varchar](250) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[state] [varchar](50) NOT NULL,
	[zip] [int] NOT NULL,
	[email] [varchar](350) NOT NULL,
	[phone] [varchar](350) NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[progress] [tinyint] NOT NULL,
 CONSTRAINT [PK_employers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interviews]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[interviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [int] NOT NULL,
	[title] [varchar](200) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[round] [tinyint] NOT NULL,
	[venue] [varchar](200) NOT NULL,
	[date_of_interview] [date] NOT NULL,
	[active] [tinyint] NOT NULL,
	[logged_in_user_id] [int] NOT NULL,
 CONSTRAINT [PK_interviews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_qualifications]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_qualifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [int] NOT NULL,
	[qualification_id] [int] NOT NULL,
 CONSTRAINT [PK_job_qualifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_skills]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_skills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
 CONSTRAINT [PK_job_skills] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobs]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_code] [varchar](150) NOT NULL,
	[description] [text] NOT NULL,
	[employer_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[vacancy_count] [int] NOT NULL,
	[other_notes] [text] NOT NULL,
	[min_exp] [int] NOT NULL,
	[max_exp] [int] NOT NULL,
	[currency] [int] NOT NULL,
	[min_sal] [int] NOT NULL,
	[max_sal] [int] NOT NULL,
	[join_date] [date] NULL,
	[active] [int] NOT NULL,
	[logged_in_userid] [int] NOT NULL,
 CONSTRAINT [PK_jobs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications]    Script Date: 22-Jul-19 12:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qualifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
 CONSTRAINT [PK_qualifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications_temp]    Script Date: 22-Jul-19 12:36:36 PM ******/
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
/****** Object:  Table [dbo].[skills]    Script Date: 22-Jul-19 12:36:36 PM ******/
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
/****** Object:  Table [dbo].[skills_temp]    Script Date: 22-Jul-19 12:36:36 PM ******/
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
/****** Object:  Table [dbo].[status]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  Table [dbo].[user_level]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_level](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[level_name] [varchar](20) NOT NULL,
	[level_type] [tinyint] NOT NULL,
 CONSTRAINT [PK_user_level] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_type]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_user_type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](250) NOT NULL,
	[password] [varbinary](max) NOT NULL,
	[salt] [varbinary](4) NOT NULL,
	[user_type] [tinyint] NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[last_logged_in] [datetime] NULL,
	[ip_address] [varchar](16) NOT NULL,
	[notification] [tinyint] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_active]  DEFAULT ((1)) FOR [active]
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidates_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidates_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidates_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCustomers_Add] @name varchar(max), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @contact varchar(max)=NULL, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM customers WHERE name=@name)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.customers(name, address, city, state, zip, contact, email, phone, active, license_expiry, added_date, updated_date) VALUES(@name, @address, @city, @state, CAST(@zip AS INT), @contact, @email, @phone, 
CAST(@active AS INT), 0, GETDATE(), GETDATE());
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomers_Edit] @id int, @name varchar(100), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @contact varchar(max)=NULL, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @Ret int output AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM customers WHERE name=@name AND id<>@id)
BEGIN
SET @Ret = -2;
END
ELSE IF EXISTS (SELECT 1 FROM customers WHERE email=@email AND id<>@id)
BEGIN
SET @Ret = -3;
END
ELSE
BEGIN
UPDATE dbo.customers SET name = @name, address = @address, city = @city, state = @state, zip = CAST(@zip AS INT), contact = @contact, email = @email, phone = @phone, active = CAST(@active AS INT) WHERE id = @id;
SET @Ret = @@ROWCOUNT;
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit2]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCustomers_Edit2] @id int, @name varchar(100), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @contact varchar(max)=NULL, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -10;
IF EXISTS (SELECT 1 FROM customers WHERE name=@name AND id<>@id)
BEGIN
PRINT 'NAME';
SET @Ret = -2;
END
ELSE IF EXISTS (SELECT 1 FROM customers WHERE email=@email AND id<>@id)
BEGIN
PRINT 'EMAIL';
SET @Ret = -3;
END
ELSE
BEGIN
print 'ok'
/*UPDATE dbo.customers SET name = @name, address = @address, city = @city, state = @state, zip = CAST(@zip AS INT), contact = @contact, email = @email, phone = @phone, active = CAST(@active AS INT) WHERE id = @id;
SET @Ret = @@ROWCOUNT;*/
END
SET @Ret = 10;
PRINT @Ret
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCustomers_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM customers WHERE name LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempCustomers AS
	(SELECT id, name, address, city, state, contact, email, active,
	ROW_NUMBER() OVER (order by name) as RowNumber
	FROM customers WHERE name LIKE @SrchVal+'%')

	SELECT * 
	FROM tempCustomers 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomers_GetSingle] @id int as
BEGIN
SELECT * FROM customers WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomerStaffs_Add] @user_id int, @customer_id int, @name varchar(max), @gender varchar(50)=NULL, @designation varchar(250)=NULL, @address varchar(max)=NULL, 
@phone varchar(50)=NULL, @email varchar(100)=NULL, @active int, @logged_in_user_id int, @password varchar(max), @ip_address varchar(16), @notification int, @user_type int, @Ret int OUTPUT AS
BEGIN
DECLARE @customer_staff_id AS int;
DECLARE @customer_user_id AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM customer_staffs WHERE email=@email)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.customer_staffs(user_id, customer_id, name, gender, designation, address, phone, email, active, added_date, updated_date, logged_in_user_id) 
VALUES(CAST(@user_id AS int), CAST(@customer_id AS int), @name, @gender, @designation, @address, @phone, @email, CAST(@active AS int), GETDATE(), GETDATE(), CAST(@logged_in_user_id AS int));
IF(@@ROWCOUNT > 0 )
BEGIN
SET @customer_staff_id = SCOPE_IDENTITY()
EXEC @customer_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;
UPDATE dbo.customer_staffs SET user_id = @customer_user_id WHERE id=@customer_staff_id;
SET @Ret = @customer_user_id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCustomerStaffs_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM customer_staffs WHERE id=@id)
 BEGIN 
 DELETE FROM customer_staffs WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomerStaffs_Edit] @id int, @user_id int, @name varchar(max), @gender varchar(50)=NULL, @designation varchar(250)=NULL, @address varchar(max)=NULL, 
@phone varchar(50)=NULL, @email varchar(100)=NULL, @active int, @logged_in_user_id int, @ip_address varchar(16), @notification int, @user_type int AS
BEGIN
DECLARE @Ret AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM customer_staffs WHERE email=@email AND id<>@id)
SET @RET = -2;
ELSE
BEGIN
UPDATE dbo.customer_staffs SET name = @name, gender = @gender, designation = @designation, address = @address, phone = @phone, email = @email, active = CAST(@active AS INT), updated_date = GETDATE(), logged_in_user_id = @logged_in_user_id WHERE id = @id;
IF(@@ROWCOUNT > 0 )
SET @user_id = (SELECT user_id FROM customer_staffs WHERE id = @id);
BEGIN
EXEC @Ret = uspUsers_Edit @id = @user_id, @email = @email, @user_type = @user_type, @active=@active, @ipaddress = @ip_address, @notification = @notification;
END
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCustomerStaffs_Get]
	@CustomerId int,
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	SET @SrchVal = @SrchVal+'%';
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM customer_staffs WHERE customer_id = @CustomerId AND @SrchBy LIKE @SrchVal)

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempCustomerStaffs AS
	(SELECT t1.id as customer_staff_id, t1.customer_id as customer_staff_cust_id, t1.name as customer_staff_name, t1.designation as customer_staff_designation, t1.email as customer_staff_email, t1.active as customer_staff_active,
	t4.type_name as customer_staff_user_type,
	ROW_NUMBER() OVER (order by t1.name) as RowNumber
	FROM customer_staffs as t1 JOIN customers as t2 ON t1.customer_id = t2.id JOIN users as t3 ON t1.user_id = t3.id JOIN user_type as t4 ON t3.user_type = t4.id WHERE t1.customer_id = @CustomerId AND @SrchBy LIKE @SrchVal)

	SELECT * 
	FROM tempCustomerStaffs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomerStaffs_GetSingle] @id int as
BEGIN
SELECT t1.*, t2.user_type as user_type FROM customer_staffs as t1 JOIN users as t2 ON t1.user_id = t2.id WHERE t1.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerLocations_Add] @employer_id int, @address varchar(max)=NULL, @city varchar(50)=NULL, @zip int, @email varchar(100)=NULL, @phone varchar(50)=NULL, @country varchar(100)=NULL, 
@active int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM employer_locations WHERE address=@address)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.employer_locations(employer_id, address, city, zip, email, phone, country, active, added_date, updated_date) 
VALUES(CAST(@employer_id AS int), @address, @city, CAST(@zip AS int), @email, @phone, @country, CAST(@active AS int), GETDATE(), GETDATE());
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerLocations_Edit] @id int, @employer_id int, @address varchar(max)=NULL, @city varchar(50)=NULL, @zip int, @email varchar(100)=NULL, @phone varchar(50)=NULL, @country varchar(100)=NULL, 
@active int, @Ret int OUTPUT AS
SET @Ret = -1;
BEGIN
UPDATE dbo.employer_locations SET address=@address, city=@city, zip=CAST(@zip AS int), email=@email, phone=@phone, country=@country, active=CAST(@active AS int), updated_date=GETDATE() WHERE id=@id;
SET @Ret = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspEmployerLocations_Get]
	@EmployerId int,
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	-- Get The Count Of The Rows That They Meet the Criteria
	DECLARE @SQL VARCHAR(MAX);
	
	SET @ItemCount = (SELECT COUNT(*) FROM employer_locations WHERE employer_id = @EmployerId AND address LIKE @SrchVal+'%');

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempEmployerLocations AS
	(SELECT t1.id as employer_loc_id, t1.address as employer_loc_address, t1.active as employer_loc_active, t2.name as employer_name,
	ROW_NUMBER() OVER (order by t1.address) as RowNumber
	FROM employer_locations as t1 JOIN employers as t2 ON t1.employer_id = t2.id WHERE t1.employer_id = @EmployerId AND t1.address LIKE @SrchVal+'%')

	SELECT * 
	FROM tempEmployerLocations 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_GetList]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEmployerLocations_GetList] @id int AS
BEGIN
SELECT id as employer_loc_id, address as employer_loc_address FROM employer_locations WHERE employer_id = @id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerLocations_GetSingle] @id int as
BEGIN
SELECT t1.id as employer_id, t1.name as employer_name, t2.* FROM employers as t1 JOIN employer_locations as t2 ON t2.employer_id=t1.id WHERE t2.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_Add] @name varchar(max), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM employers WHERE name=@name)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.employers(name, address, city, state, zip, email, phone, active, added_date, updated_date, progress) 
VALUES(@name, @address, @city, @state,CAST(@zip AS int), @email, @phone, CAST(@active AS int), GETDATE(), GETDATE(), 1);
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_Edit] @id int, @name varchar(max), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @Ret int OUTPUT AS
SET @Ret = -1;
BEGIN
UPDATE dbo.employers SET name=@name, address=@address, city=@city, state=@state, zip=CAST(@zip AS int), email=@email, phone=@phone, active=CAST(@active AS int), updated_date=GETDATE() WHERE id=@id;
SET @Ret = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspEmployers_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	SET @SrchVal = @SrchVal+'%';
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM employers WHERE @SrchBy LIKE @SrchVal)

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempEmployers AS
	(SELECT id, name, email, phone, active, progress,
	ROW_NUMBER() OVER (order by name) as RowNumber
	FROM employers WHERE @SrchBy LIKE @SrchVal)

	SELECT * 
	FROM tempEmployers 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetFormData]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEmployers_GetFormData] @id int AS
BEGIN
DECLARE @progress VARCHAR(10);
SET @progress = (SELECT progress FROM employers WHERE id=@id);
IF(@progress = '2')
SELECT t1.id as employer_id, t1.name as employer_name, t1.progress as progress, t2.id as employer_loc_id FROM employers as t1 JOIN employer_locations as t2 ON t1.id=t2.employer_id WHERE t1.id = @id;
ELSE
SELECT id as employer_id, name as employer_name, progress as progress, employer_loc_id='' FROM employers WHERE id = @id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetList]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspEmployers_GetList] AS
BEGIN
SELECT id, name FROM employers WHERE progress = 3;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_GetSingle] @id int as
BEGIN
SELECT * FROM employers WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Update_Progress]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_Update_Progress] @id int, @progress int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.employers SET progress=@progress WHERE id=@id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerStaffs_Add] @user_id int, @employer_id int, @employer_location_id int, @name varchar(max), @gender varchar(10), @designation varchar(max)=NULL, @address varchar(max)=NULL,
@phone varchar(50)=NULL, @email varchar(100)=NULL, @logged_in_userid int, @active int, @password varchar(max), @ip_address varchar(16), @notification int, @user_type int, @Ret int OUTPUT AS
BEGIN
DECLARE @employer_staff_id AS int;
DECLARE @employer_user_id AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM employer_staffs WHERE email=@email)
SET @Ret = -2;
ELSE
BEGIN
INSERT INTO dbo.employer_staffs(user_id, employer_id, employer_location_id, name, gender, designation, address, phone, email, active, added_date, updated_date, logged_in_user_id) 
VALUES(CAST(@user_id AS int), CAST(@employer_id AS int), CAST(@employer_location_id AS int), @name, @gender, @designation, @address, @phone, @email, CAST(@active AS int), GETDATE(), GETDATE(), CAST(@logged_in_userid AS int));
IF(@@ROWCOUNT > 0 )
BEGIN
SET @employer_staff_id = SCOPE_IDENTITY()
EXEC @employer_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;
UPDATE dbo.employer_staffs SET user_id = @employer_user_id WHERE id=@employer_staff_id;
SET @Ret = @employer_user_id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerStaffs_Edit] @employer_staff_id int, @employer_id int, @employer_location_id int, @name varchar(max), @gender varchar(10), @designation varchar(max)=NULL, @address varchar(max)=NULL,
@phone varchar(50)=NULL, @email varchar(100)=NULL, @logged_in_userid int, @active int, @Ret int OUTPUT AS
SET @Ret = -1;
BEGIN
UPDATE dbo.employer_staffs SET name=@name, gender=@gender, designation=@designation, address=@address, email=@email, phone=@phone, active=CAST(@active AS int), logged_in_user_id=CAST(@logged_in_userid AS int), updated_date=GETDATE() WHERE id=@employer_staff_id;
SET @Ret = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspEmployerStaffs_Get]
	@EmployerId int,
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	SET @SrchVal = @SrchVal+'%';
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM employer_staffs WHERE employer_id = @EmployerId AND @SrchBy LIKE @SrchVal)

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempEmployerStaffs AS
	(SELECT t1.id as employer_staff_id, t1.employer_id as employer_staff_emp_id, t1.employer_location_id as employer_staff_loc_id, t1.name as employer_staff_name, t1.email as employer_staff_email, t1.active as employer_staff_active,
	t2.address as employer_staff_location, t4.type_name as employer_staff_user_type,
	ROW_NUMBER() OVER (order by t1.address) as RowNumber
	FROM employer_staffs as t1 JOIN employers ON t1.employer_id = employers.id JOIN employer_locations as t2 ON t1.employer_location_id = t2.id JOIN users as t3 ON t1.user_id = t3.id JOIN user_type as t4 ON t4.id = t3.user_type WHERE t1.employer_id = @EmployerId AND @SrchBy LIKE @SrchVal)

	SELECT * 
	FROM tempEmployerStaffs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerStaffs_GetSingle] @id int as
BEGIN
SELECT t1.*, t2.user_type as user_type FROM employer_staffs as t1 JOIN users as t2 ON t1.user_id = t2.id WHERE t1.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterviews_Add] @job_id int, @title varchar(200)=NULL, @description varchar(max)=NULL, 
@round int, @venue varchar(200)=NULL, @date_of_interview datetime, @active int, @logged_in_user_id int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM interviews WHERE title=@title)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.interviews(job_id, title, description, round, venue, date_of_interview, active, logged_in_user_id) VALUES(CAST(@job_id AS int), @title, @description, CAST(@round AS int), @venue, @date_of_interview, CAST(@active AS int), CAST(@logged_in_user_id AS int));
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspInterviews_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM interviews WHERE title LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempInterviews AS
	(SELECT id, title, description, round, venue, date_of_interview, active,
	ROW_NUMBER() OVER (order by date_of_interview) as RowNumber
	FROM interviews WHERE title LIKE @SrchVal+'%')

	SELECT * 
	FROM tempInterviews 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Add] @job_code varchar(150), @description varchar(max)=NULL, @employer_id int, 
@location_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @min_exp int, @max_exp int, @currency int, @min_sal int, @max_sal int, @active int, @logged_in_userid int, @job_skills varchar(max), @job_qualifications varchar(max), @join_date datetime, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM jobs WHERE job_code=@job_code)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.jobs(job_code, description, employer_id, 
location_id, vacancy_count, other_notes, min_exp, max_exp, currency, min_sal, max_sal, join_Date, active, logged_in_userid) 
VALUES(@job_code, @description, CAST(@employer_id AS int), 
CAST(@location_id AS int), CAST(@vacancy_count AS int), @other_notes, CAST(@min_exp AS int), CAST(@max_exp AS int), CAST(@currency AS int), CAST(@min_sal AS int), CAST(@max_sal AS int), @join_date, CAST(@active AS int), CAST(@logged_in_userid AS int));
SET @Ret = SCOPE_IDENTITY();
IF(@Ret > 0)
BEGIN
WITH tempJobSkills AS (SELECT value FROM string_split(@job_skills, ',')) INSERT INTO job_skills (job_id, skill_id) SELECT @Ret, t.value FROM tempJobSkills as t;
WITH tempJobQualifications AS (SELECT value FROM string_split(@job_qualifications, ',')) INSERT INTO job_qualifications (job_id, qualification_id) SELECT @Ret, t.value FROM tempJobQualifications as t;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspJobs_Get]
	@employer_id int,
	@location_id int,
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM jobs WHERE job_code LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempJobs AS
	(SELECT t1.id, t1.job_code, t2.name as employer , t1.description, t1.active,
	ROW_NUMBER() OVER (order by job_code) as RowNumber
	FROM jobs as t1 JOIN employers as t2 ON t1.employer_id=t2.id WHERE t1.job_code LIKE @SrchVal+'%')

	SELECT * 
	FROM tempJobs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications&Temp_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspQualifications&Temp_Get] @Userid int AS
BEGIN
SELECT qua.id as qua_id, qua.title as qua_title, tmp.id as tmp_id, tmp.title as tmp_title FROM qualifications as qua JOIN qualifications_temp as tmp ON qua.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add_FromFile]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get_StartingWith]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Get_StartingWith] @srchVal varchar(100) as
BEGIN
SELECT id, title as value FROM qualifications WHERE title LIKE @srchVal+'%' ORDER BY title;
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_GetSingle] @id int as
BEGIN
SELECT * FROM qualifications WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills&Temp_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspSkills&Temp_Get] @Userid int AS
BEGIN
SELECT skl.id as skl_id, skl.title as skl_title, tmp.id as tmp_id, tmp.title as tmp_title FROM skills as skl JOIN skills_temp as tmp ON skl.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Add_FromFile]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Get_StartingWith]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Get_StartingWith] @srchVal varchar(100) as
BEGIN
SELECT id, title as value FROM skills WHERE title LIKE @srchVal+'%' ORDER BY title;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_GetSingle] @id int as
BEGIN
SELECT * FROM skills WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_Add] @email varchar(250), @password varchar(max), @user_type int, 
@active int, @ip_address varchar(16)=NULL, @notification int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM users WHERE email=@email)
BEGIN
SET @RET = -2;
END
ELSE
DECLARE @salt VARBINARY(4) = CRYPT_GEN_RANDOM(4);
DECLARE @hash VARBINARY(Max);
/*SET @hash = 0x0200 + @salt + HASHBYTES('SHA2_512', CAST(@password AS VARBINARY(MAX)) + @salt);*/
/* To be compatible with MSSQL version 10.0 which doesnot support HASHBYTES('SHA2_512') */
SET @hash = 0x0200 + @salt + HASHBYTES('SHA1', CAST(@password AS VARBINARY(MAX)) + @salt)
BEGIN
INSERT INTO dbo.users(email, password, salt, user_type, active, added_date, updated_date, ip_address, notification) 
VALUES(@email, @hash, @salt, @user_type, @active, GETDATE(), GETDATE(), @ip_address, @notification);
RETURN SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Need to redo the code */
CREATE procedure [dbo].[uspUsers_Edit] @id int, @email varchar(250), @user_type int, 
@active int, @ipaddress varchar(16)=NULL, @notification int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.users SET email = @email, user_type = @user_type, active = @active, notification = @notification, ip_address = @ipaddress, updated_date = GETDATE() WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_GetDetails]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_GetDetails] @ref_id int, @user_type int as
BEGIN
IF(@user_type = 1)
BEGIN
SELECT id, name='Super Admin', gender='', address='', phone='', email as email, user_type_name='Super Admin', last_logged_in as user_last_logged_in FROM users WHERE id=1;
END
ELSE IF(@user_type = 2 OR @user_type = 3)
BEGIN
SELECT t1.*, t2.name as customer_name, t4.type_name as user_type_name FROM customer_staffs as t1 JOIN customers as t2 ON t1.customer_id = t2.id JOIN users as t3 ON t1.user_id = t3.id JOIN user_type as t4 ON t3.user_type = t4.id WHERE t1.id=@ref_id; 
END
ELSE IF(@user_type = 4 OR @user_type = 5)
BEGIN
SELECT t1.*, t2.name as employer_name, t4.type_name as user_type_name from employer_staffs as t1 JOIN employers as t2 ON t1.employer_id = t2.id JOIN users as t3 ON t1.user_id = t3.id JOIN user_type as t4 ON t3.user_type = t4.id WHERE t1.id=@ref_id; 
END
ELSE
BEGIN
SELECT t1.*, t3.type_name as user_type_name from candidates as t1 JOIN users as t2 ON t1.user_id = t2.id JOIN user_type as t3 ON t2.user_type = t3.id WHERE t1.id=@ref_id; 
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_GetSingle]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_GetSingle] @email varchar(max) as
BEGIN
DECLARE @user_type int;
SET @user_type = (SELECT user_type FROM users WHERE email=@email);
IF(@user_type = 1)
BEGIN
SELECT id as user_id, email as user_email, user_type as user_type, last_logged_in as user_last_logged_in FROM users WHERE email = @email;
END
ELSE IF(@user_type = 2 OR @user_type = 3)
BEGIN
SELECT t1.id as user_id, t1.email as user_email, t1.user_type as user_type, t1.last_logged_in as user_last_logged_in, t2.id as user_ref_id, t2.name as user_name, t3.type_name as user_type_name FROM users as t1 JOIN customer_staffs as t2 ON t1.id = t2.user_id JOIN user_type as t3 ON t1.user_type = t3.id WHERE t1.email = @email;
END
ELSE IF(@user_type = 4 OR @user_type = 5)
BEGIN
SELECT t1.id as user_id, t1.email as user_email, t1.user_type as user_type, t1.last_logged_in as user_last_logged_in, t2.id as user_ref_id, t2.name as user_name, t3.type_name as user_type_name FROM users as t1 JOIN employer_staffs as t2 ON t1.id = t2.user_id JOIN user_type as t3 ON t1.user_type = t3.id WHERE t1.email = @email;
END
ELSE
BEGIN
SELECT t1.id as user_id, t1.email as user_email, t1.user_type as user_type, t1.last_logged_in as user_last_logged_in, t2.id as user_ref_id, t2.name as user_name, t3.type_name as user_type_name FROM users as t1 JOIN candidates as t2 ON t1.id = t2.user_id JOIN user_type as t3 ON t1.user_type = t3.id WHERE t1.email = @email;
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_ValidateUser]    Script Date: 22-Jul-19 12:36:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsers_ValidateUser] @Username varchar(100), @Password  varchar(100), @Ret int OUTPUT  
AS
BEGIN
	 DECLARE @new_salt VARBINARY(4);	 
	 DECLARE @hash VARBINARY(MAX); 
	 DECLARE @new_hash VARBINARY(MAX);
	 SET @Ret = 0;

	 SELECT @new_salt = salt, @new_hash=[password] FROM dbo.users WHERE email=@Username;

	 if(@new_salt <> '' AND @new_hash <> '')
	 BEGIN		
		/*SET @hash = 0x0200 + @new_salt + HASHBYTES('SHA2_512', CAST(@password AS VARBINARY(MAX)) + @new_salt);*/
		/* To be compatible with MSSQL version 10.0 which doesnot support HASHBYTES('SHA2_512') */
		SET @hash = 0x0200 + @new_salt + HASHBYTES('SHA1', CAST(@password AS VARBINARY(MAX)) + @new_salt);
		/* Recreating hash from user input and matching with hash produced from existing record */
		IF(@hash = @new_hash)
		BEGIN
		IF((SELECT active FROM users WHERE email=@Username) = 1)
		BEGIN
		SET @Ret = 1;
		END
		ELSE
		SET @Ret = -2;
		END
		ELSE
		BEGIN
			SET @Ret = -1;
		END	
	 END
	 SELECT @Ret;
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Add]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Delete]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Edit]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Get]    Script Date: 22-Jul-19 12:36:37 PM ******/
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
