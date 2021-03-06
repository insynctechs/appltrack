USE [master]
GO
/****** Object:  Database [recruiterdb19]    Script Date: 04-Sep-19 04:57:48 PM ******/
CREATE DATABASE [recruiterdb19] ON  PRIMARY 
( NAME = N'insynctechs.co.in_recruiterdb19_Data', FILENAME = N'D:\SQLData\insynctechs.co.in_recruiterdb19_Data.mdf' , SIZE = 3328KB , MAXSIZE = 322560KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'insynctechs.co.in_recruiterdb19_Log', FILENAME = N'D:\SQLData\insynctechs.co.in_recruiterdb19_Log.ldf' , SIZE = 1024KB , MAXSIZE = 35840KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [recruiterdb19] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [recruiterdb19].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [recruiterdb19] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [recruiterdb19] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [recruiterdb19] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [recruiterdb19] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [recruiterdb19] SET ARITHABORT OFF 
GO
ALTER DATABASE [recruiterdb19] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [recruiterdb19] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [recruiterdb19] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [recruiterdb19] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [recruiterdb19] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [recruiterdb19] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [recruiterdb19] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [recruiterdb19] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [recruiterdb19] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [recruiterdb19] SET  ENABLE_BROKER 
GO
ALTER DATABASE [recruiterdb19] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [recruiterdb19] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [recruiterdb19] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [recruiterdb19] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [recruiterdb19] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [recruiterdb19] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [recruiterdb19] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [recruiterdb19] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [recruiterdb19] SET  MULTI_USER 
GO
ALTER DATABASE [recruiterdb19] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [recruiterdb19] SET DB_CHAINING OFF 
GO
USE [recruiterdb19]
GO
/****** Object:  User [recrinsync19]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE USER [recrinsync19] FOR LOGIN [recrinsync19] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [db_executor]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE ROLE [db_executor]
GO
ALTER ROLE [db_executor] ADD MEMBER [recrinsync19]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [recrinsync19]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [recrinsync19]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [recrinsync19]
GO
ALTER ROLE [db_datareader] ADD MEMBER [recrinsync19]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [recrinsync19]
GO
/****** Object:  UserDefinedTableType [dbo].[CandidateExperiencesTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[CandidateExperiencesTableType] AS TABLE(
	[designation] [varchar](150) NULL,
	[organisation] [varchar](150) NULL,
	[from_year] [int] NULL,
	[to_year] [int] NULL,
	[description] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[CandidateQualificationsTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[CandidateQualificationsTableType] AS TABLE(
	[qualification] [varchar](150) NULL,
	[institute] [varchar](150) NULL,
	[year] [int] NULL,
	[percentage] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EntityIdsTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[EntityIdsTableType] AS TABLE(
	[id] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InterviewCandidatesTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[InterviewCandidatesTableType] AS TABLE(
	[candidate_id] [int] NULL,
	[score] [int] NULL,
	[rating] [int] NULL,
	[employer_comments] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[QualificationsTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[QualificationsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SkillsTableType]    Script Date: 04-Sep-19 04:57:49 PM ******/
CREATE TYPE [dbo].[SkillsTableType] AS TABLE(
	[title] [varchar](150) NULL
)
GO
/****** Object:  Table [dbo].[candidate_documents]    Script Date: 04-Sep-19 04:57:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_documents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NOT NULL,
	[document_type_id] [int] NOT NULL,
	[filename] [varchar](max) NOT NULL,
	[uploaded_date] [datetime] NOT NULL,
 CONSTRAINT [PK_candidate_documents] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_experiences]    Script Date: 04-Sep-19 04:57:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_experiences](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NOT NULL,
	[designation] [varchar](max) NOT NULL,
	[organisation] [varchar](max) NOT NULL,
	[from_year] [int] NOT NULL,
	[to_year] [int] NOT NULL,
	[description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_candidate_experiences] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_interview_status]    Script Date: 04-Sep-19 04:57:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_interview_status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NOT NULL,
	[interview_id] [int] NOT NULL,
	[status] [int] NOT NULL,
	[date_added] [datetime] NOT NULL,
 CONSTRAINT [PK_candidate_interview_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_qualifications]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_qualifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NOT NULL,
	[qualification] [varchar](max) NOT NULL,
	[institute] [varchar](max) NOT NULL,
	[year] [int] NOT NULL,
	[percentage] [int] NOT NULL,
 CONSTRAINT [PK_candidate_qualifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_skills]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_skills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
 CONSTRAINT [PK_candidate_skills] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_status]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_candidate_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidates]    Script Date: 04-Sep-19 04:57:50 PM ******/
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
	[address] [varchar](250) NOT NULL,
	[email] [varchar](250) NOT NULL,
	[phone] [varchar](250) NOT NULL,
	[others] [text] NOT NULL,
	[status] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[employer_comments] [text] NOT NULL,
	[active] [tinyint] NOT NULL,
	[added_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
 CONSTRAINT [PK_candidates] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[currencies]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[currencies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[code] [varchar](10) NOT NULL,
 CONSTRAINT [PK_currencies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_document_types]    Script Date: 04-Sep-19 04:57:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_document_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[document_type_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
 CONSTRAINT [PK_customer_document_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_staffs]    Script Date: 04-Sep-19 04:57:50 PM ******/
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
/****** Object:  Table [dbo].[customers]    Script Date: 04-Sep-19 04:57:51 PM ******/
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
/****** Object:  Table [dbo].[document_types]    Script Date: 04-Sep-19 04:57:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[document_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_document_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emp_branches]    Script Date: 04-Sep-19 04:57:51 PM ******/
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
/****** Object:  Table [dbo].[employer_documents]    Script Date: 04-Sep-19 04:57:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_documents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employer_id] [int] NOT NULL,
	[document_type_id] [int] NOT NULL,
 CONSTRAINT [PK_employer_documents] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_locations]    Script Date: 04-Sep-19 04:57:51 PM ******/
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
/****** Object:  Table [dbo].[employer_staffs]    Script Date: 04-Sep-19 04:57:51 PM ******/
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
/****** Object:  Table [dbo].[employers]    Script Date: 04-Sep-19 04:57:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[industries]    Script Date: 04-Sep-19 04:57:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[industries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
 CONSTRAINT [PK_industries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interview_candidates]    Script Date: 04-Sep-19 04:57:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[interview_candidates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[interview_id] [int] NOT NULL,
	[candidate_id] [int] NOT NULL,
	[status] [int] NOT NULL,
	[score] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[employer_comments] [varchar](250) NOT NULL,
	[date_added] [datetime] NOT NULL,
	[logged_in_user_id] [int] NOT NULL,
	[active] [tinyint] NULL,
 CONSTRAINT [PK_interview_candidates] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interviews]    Script Date: 04-Sep-19 04:57:52 PM ******/
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
/****** Object:  Table [dbo].[job_candidates]    Script Date: 04-Sep-19 04:57:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_candidates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [int] NOT NULL,
	[candidate_id] [int] NOT NULL,
	[status] [int] NOT NULL,
	[score] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[employer_comments] [varchar](250) NOT NULL,
	[date_added] [datetime] NOT NULL,
	[date_updated] [datetime] NOT NULL,
	[logged_in_userid] [int] NOT NULL,
 CONSTRAINT [PK_job_candidates] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_qualifications]    Script Date: 04-Sep-19 04:57:52 PM ******/
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
/****** Object:  Table [dbo].[job_skills]    Script Date: 04-Sep-19 04:57:52 PM ******/
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
/****** Object:  Table [dbo].[jobs]    Script Date: 04-Sep-19 04:57:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_code] [varchar](150) NOT NULL,
	[industry] [int] NOT NULL,
	[category] [int] NOT NULL,
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
	[date_added] [date] NOT NULL,
	[date_updated] [date] NOT NULL,
 CONSTRAINT [PK_jobs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qualifications]    Script Date: 04-Sep-19 04:57:52 PM ******/
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
/****** Object:  Table [dbo].[qualifications_temp]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[skills]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[skills_temp]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[status]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[user_level]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[user_type]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidate_Experiences_Add2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidate_Experiences_Add2] @candidate_id int, @designation varchar(200)=NULL, @organisation varchar(max)=NULL, 
@from_year int, @to_year int, @description varchar(max) AS
DECLARE @Ret int;
SET @Ret = 0;
BEGIN
INSERT INTO dbo.candidate_experiences(candidate_id, designation, organisation, from_year, to_year, description) VALUES(CAST(@candidate_id AS int), @designation, @organisation, CAST(@from_year AS int), CAST(@to_year AS int), @description);
SET @Ret = 1;
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidate_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidate_GetSingle] @candidate_id int AS
BEGIN
SELECT t1.*, t2.* FROM candidates as t1 JOIN candidate_skills as t2 ON t1.id=t2.candidate_id WHERE t1.id=@candidate_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidate_Qualifications_Add2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidate_Qualifications_Add2] @candidate_id int, @qualification varchar(200)=NULL, @institute varchar(max)=NULL, 
@year int, @percentage int AS
DECLARE @Ret int;
SET @Ret = 0;
BEGIN
INSERT INTO dbo.candidate_qualifications(candidate_id, qualification, institute, year, percentage) VALUES(CAST(@candidate_id AS int), @qualification, @institute, CAST(@year AS int), CAST(@percentage AS int));
SET @Ret = 1;
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateDocuments_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidateDocuments_Add] @candidate_id int, @document_type_id int, @filename varchar(max), @Ret int OUTPUT AS
BEGIN
/*DECLARE @Ret int;*/
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM candidate_documents WHERE document_type_id=@document_type_id AND candidate_id=@candidate_id)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.candidate_documents(candidate_id, document_type_id, filename, uploaded_date) VALUES(CAST(@candidate_id AS int), CAST(@document_type_id AS int), @filename, GETDATE());
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateDocuments_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidateDocuments_Delete] @filename varchar(max) As
 DECLARE @Ret int;
 SET @Ret = -1; 
 BEGIN 
 DELETE FROM candidate_documents WHERE filename=@filename;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateDocuments_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidateDocuments_Get] @candidate_id int AS
BEGIN
SELECT * FROM candidate_documents WHERE candidate_id = @candidate_id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateDocuments_GetAll]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidateDocuments_GetAll] @candidate_id int AS
BEGIN
SELECT t1.document_type_id, t1.filename, t1.uploaded_date, t2.type_name as document_type FROM candidate_documents as t1 JOIN document_types as t2 ON t1.document_type_id = t2.id WHERE candidate_id = @candidate_id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateExperiences_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* To insert records in candidatequalifications table through user defined table type */
CREATE PROCEDURE [dbo].[uspCandidateExperiences_Add] @candidate_id int, @experienceList AS dbo.CandidateExperiencesTableType READONLY, @RowsInserted int OUTPUT AS
BEGIN
INSERT INTO candidate_experiences (candidate_id, designation, organisation, from_year, to_year, description) SELECT @candidate_id, * FROM @experienceList;
END
SET @RowsInserted = @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateExperiences_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidateExperiences_Get] @candidate_id int as
BEGIN
SELECT t1.* FROM candidate_experiences as t1 WHERE t1.candidate_id = @candidate_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateQualifications_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* To insert records in candidatequalifications table through user defined table type */
CREATE PROCEDURE [dbo].[uspCandidateQualifications_Add] @candidate_id int, @qualificationList AS dbo.CandidateQualificationsTableType READONLY, @RowsInserted int OUTPUT AS
BEGIN
INSERT INTO candidate_qualifications (candidate_id, qualification, institute, year, percentage) SELECT @candidate_id, * FROM @qualificationList;
END
SET @RowsInserted = @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateQualifications_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidateQualifications_Get] @candidate_id int as
BEGIN
SELECT t1.* FROM candidate_qualifications as t1 WHERE t1.candidate_id = @candidate_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspCandidates_Add] @user_id int, @name varchar(150), @gender varchar(50)=NULL, @dob datetime,
@address varchar(max) = NULL, @email varchar(150), @phone varchar(150), @others varchar(max)=NULL, @skills varchar(max), @status int, @rating int, @employer_comments varchar(max)=NULL, @active int,
@password varchar(max), @ip_address varchar(16), @notification int, @user_type int,
@experienceList AS dbo.CandidateExperiencesTableType READONLY, @qualificationList AS dbo.CandidateQualificationsTableType READONLY, 
@Ret int OUTPUT AS
BEGIN
DECLARE @candidate_id AS int;
DECLARE @candidate_user_id AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM candidates WHERE email=@email)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.candidates(user_id, name, gender, dob, address, email, phone, others, status, rating, employer_comments, active, added_date, updated_date) 
VALUES(CAST(@user_id AS int), @name, @gender, @dob, @address, @email, @phone, @others, CAST(@status AS int), CAST(@rating AS int), @employer_comments, CAST(@active AS int), GETDATE(), GETDATE());
IF(@@ROWCOUNT > 0 )
BEGIN
SET @candidate_id = SCOPE_IDENTITY();
WITH tempCandidateSkills AS (SELECT value FROM string_split(@skills, ',')) INSERT INTO candidate_skills (candidate_id, skill_id) SELECT @candidate_id, t.value FROM tempCandidateSkills as t;
EXEC @candidate_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;
UPDATE dbo.candidates SET user_id = @candidate_user_id WHERE id=@candidate_id;

EXEC uspCandidateQualifications_Add @candidate_id, @qualificationList, @Ret;
EXEC uspCandidateExperiences_Add @candidate_id, @experienceList, @Ret;
SET @Ret = @candidate_id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Add2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidates_Add2] @user_id int, @name varchar(150), @gender varchar(50)=NULL, @dob datetime,
@address varchar(max) = NULL, @email varchar(150), @phone varchar(150), @others varchar(max)=NULL, @skills varchar(max), @status int, @rating int, @employer_comments varchar(max)=NULL, @active int,
@password varchar(max), @ip_address varchar(16), @notification int, @user_type int, 
@Ret int OUTPUT AS
BEGIN
DECLARE @candidate_id AS int;
DECLARE @candidate_user_id AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM candidates WHERE email=@email)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.candidates(user_id, name, gender, dob, address, email, phone, others, status, rating, employer_comments, active, added_date, updated_date) 
VALUES(CAST(@user_id AS int), @name, @gender, @dob, @address, @email, @phone, @others, CAST(@status AS int), CAST(@rating AS int), @employer_comments, CAST(@active AS int), GETDATE(), GETDATE());
IF(@@ROWCOUNT > 0 )
BEGIN
SET @candidate_id = SCOPE_IDENTITY();
WITH tempCandidateSkills AS (SELECT value FROM string_split(@skills, ',')) INSERT INTO candidate_skills (candidate_id, skill_id) SELECT @candidate_id, t.value FROM tempCandidateSkills as t;
EXEC @candidate_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;
UPDATE dbo.candidates SET user_id = @candidate_user_id WHERE id=@candidate_id;

SET @Ret = @candidate_id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Add3]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidates_Add3] @user_id int, @name varchar(150), @gender varchar(50)=NULL, @dob date,
@address varchar(max) = NULL, @email varchar(150), @phone varchar(150), @others varchar(max)=NULL, @skillList dbo.EntityIdsTableType READONLY, @status int, @rating int, @employer_comments varchar(max)=NULL, @active int,
@password varchar(max), @ip_address varchar(16), @notification int, @user_type int, 
@Ret int OUTPUT AS
BEGIN
DECLARE @candidate_id AS int;
DECLARE @candidate_user_id AS int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM candidates WHERE email=@email)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.candidates(user_id, name, gender, dob, address, email, phone, others, status, rating, employer_comments, active, added_date, updated_date) 
VALUES(CAST(@user_id AS int), @name, @gender, convert(date, @dob, 105), @address, @email, @phone, @others, CAST(@status AS int), CAST(@rating AS int), @employer_comments, CAST(@active AS int), GETDATE(), GETDATE());
IF(@@ROWCOUNT > 0 )
BEGIN
SET @candidate_id = SCOPE_IDENTITY();
INSERT into candidate_skills (candidate_id, skill_id) (SELECT @candidate_id, * FROM @skillList);
/*WITH tempCandidateSkills AS (SELECT value FROM string_split(@skills, ',')) INSERT INTO candidate_skills (candidate_id, skill_id) SELECT @candidate_id, t.value FROM tempCandidateSkills as t;*/
EXEC @candidate_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;
UPDATE dbo.candidates SET user_id = @candidate_user_id WHERE id=@candidate_id;

SET @Ret = @candidate_id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
 DELETE FROM candidate_documents WHERE candidate_id=@id;
 DELETE FROM candidate_skills WHERE candidate_id=@id; 
 DELETE FROM candidate_qualifications WHERE candidate_id=@id;
 DELETE FROM candidate_experiences WHERE candidate_id=@id;    
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidates_Edit] @id int, @user_id int, @name varchar(150), @gender varchar(50)=NULL, @dob date,
@address varchar(max) = NULL, @email varchar(150), @phone varchar(150), @others varchar(max)=NULL, @skillList dbo.EntityIdsTableType READONLY, @status int, @rating int, @employer_comments varchar(max)=NULL, @active int,
@ip_address varchar(16), @notification int, @user_type int, 
@Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM users WHERE email=@email AND id<>@user_id)
SET @RET = -2;
ELSE
BEGIN
UPDATE dbo.candidates SET name=@name, gender=@gender, dob=CONVERT(date, @dob, 105), address=@address, email=@email, phone=@phone, others=@others, status=@status, rating=@rating, employer_comments=@employer_comments, active=@active, updated_date=GETDATE() WHERE id=@id; 
IF(@@ROWCOUNT > 0 )
BEGIN
DELETE FROM candidate_skills WHERE candidate_id=@id;
DELETE FROM candidate_qualifications WHERE candidate_id=@id;
DELETE FROM candidate_experiences WHERE candidate_id=@id;

INSERT into candidate_skills (candidate_id, skill_id) (SELECT @id, * FROM @skillList);
UPDATE users SET email=@email WHERE id=@user_id;
/*EXEC @candidate_user_id = uspUsers_Add @email=@email, @password=@password, @user_type=@user_type, @active=@active, @ip_address=@ip_address, @notification=@notification;*/
SET @Ret = @id;
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCandidates_Get]
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM candidates WHERE name LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempCandidates AS
	(SELECT id, name, email, address, active,
	ROW_NUMBER() OVER (order by name) as RowNumber
	FROM candidates WHERE name LIKE @SrchVal+'%')

	SELECT * 
	FROM tempCandidates 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidates_GetSingle] @candidate_id int as
BEGIN
SELECT t1.* FROM candidates as t1 WHERE t1.id = @candidate_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateSkills_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCandidateSkills_Get] @candidate_id int as
BEGIN
SELECT t1.skill_id as id, t2.title as skill FROM candidate_skills as t1 JOIN skills as t2 ON t1.skill_id = t2.id WHERE t1.candidate_id = @candidate_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidateStatus_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCandidateStatus_GetList] AS
BEGIN
SELECT * FROM candidate_status;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspCategories_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCategories_GetList] AS
BEGIN
SELECT * FROM categories;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspCurrencies_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCurrencies_GetList] AS
BEGIN
SELECT * FROM currencies;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit2]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomers_GetSingle] @id int as
BEGIN
SELECT * FROM customers WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomerStaffs_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCustomerStaffs_GetSingle] @id int as
BEGIN
SELECT t1.*, t2.user_type as user_type FROM customer_staffs as t1 JOIN users as t2 ON t1.user_id = t2.id WHERE t1.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspDocumentTypes_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspDocumentTypes_GetList] AS
BEGIN
SELECT * FROM document_types;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerLocations_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerLocations_GetSingle] @id int as
BEGIN
SELECT t1.id as employer_id, t1.name as employer_name, t2.* FROM employers as t1 JOIN employer_locations as t2 ON t2.employer_id=t1.id WHERE t2.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_Add] @customer_id int, @name varchar(max), @address varchar(max)=NULL, @city varchar(50)=NULL, 
@state varchar(50)=NULL, @zip int, @email varchar(100)=NULL, @phone varchar(50)=NULL, 
@active int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM employers WHERE name=@name)
SET @RET = -2;
ELSE
BEGIN
INSERT INTO dbo.employers(customer_id, name, address, city, state, zip, email, phone, active, added_date, updated_date, progress) 
VALUES(CAST(@customer_id AS int), @name, @address, @city, @state,CAST(@zip AS int), @email, @phone, CAST(@active AS int), GETDATE(), GETDATE(), 1);
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployers_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetFormData]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetList2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspEmployers_GetList2] @customer_id int AS
BEGIN
SELECT id, name FROM employers WHERE customer_id=@customer_id AND progress = 3;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployers_GetSingle] @id int as
BEGIN
SELECT * FROM employers WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspEmployers_Update_Progress]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
	SET @ItemCount = (SELECT COUNT(*) FROM employer_staffs WHERE employer_id = @EmployerId AND name LIKE '%'+@SrchVal)

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempEmployerStaffs AS
	(SELECT t1.id as employer_staff_id, t1.employer_id as employer_staff_emp_id, t1.employer_location_id as employer_staff_loc_id, t1.name as employer_staff_name, t1.email as employer_staff_email, t1.active as employer_staff_active,
	t2.address as employer_staff_location, t4.type_name as employer_staff_user_type,
	ROW_NUMBER() OVER (order by t1.address) as RowNumber
	FROM employer_staffs as t1 JOIN employers ON t1.employer_id = employers.id JOIN employer_locations as t2 ON t1.employer_location_id = t2.id JOIN users as t3 ON t1.user_id = t3.id JOIN user_type as t4 ON t4.id = t3.user_type WHERE t1.employer_id = @EmployerId AND t1.name LIKE '%'+@SrchVal)

	SELECT * 
	FROM tempEmployerStaffs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspEmployerStaffs_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspEmployerStaffs_GetSingle] @id int as
BEGIN
SELECT t1.*, t2.user_type as user_type FROM employer_staffs as t1 JOIN users as t2 ON t1.user_id = t2.id WHERE t1.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspIndustries_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspIndustries_GetList] AS
BEGIN
SELECT * FROM industries;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterview_Candidates_SetInterview]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterview_Candidates_SetInterview] @interview_id int, @candidateList dbo.EntityIdsTableType READONLY, @status int, @logged_in_user_id int, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
BEGIN
IF EXISTS (SELECT 1 FROM interview_candidates WHERE interview_id = @interview_id AND candidate_id = (SELECT * FROM @candidateList))
SET @Ret = -2;
ELSE
BEGIN
UPDATE interview_candidates set active=0 WHERE interview_candidates.candidate_id = (SELECT * FROM @candidateList);
INSERT into interview_candidates(interview_id, status, score, rating, employer_comments, date_added, logged_in_user_id, active, candidate_id) (SELECT @interview_id, @status, 0, 0, '', GETDATE(), @logged_in_user_id, 1, * FROM @candidateList);
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterview_Candidates_UpdateCandidates]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterview_Candidates_UpdateCandidates] @interview_id int, @candidateList dbo.InterviewCandidatesTableType READONLY, @status int, @logged_in_user_id int, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
/*IF EXISTS (SELECT 1 FROM jobs WHERE job_code=@job_code)
BEGIN
SET @RET = -2;
END
ELSE
*/
/*
BEGIN
INSERT into interview_candidates(interview_id, status, date_added, logged_in_user_id, candidate_id, score, rating, employer_comments) (SELECT @interview_id, @status, GETDATE(), @logged_in_user_id, candidate_id, score, rating, employer_comments FROM @candidateList);

*/
BEGIN
UPDATE interview_candidates SET status = @status, date_added = GETDATE(), logged_in_user_id = @logged_in_user_id, score = t.score, rating = t.rating, employer_comments = t.employer_comments FROM @candidateList t WHERE interview_id = @interview_id AND interview_candidates.candidate_id = t.candidate_id;


/*DELETE FROM candidate_interview_status WHERE interview_id = @interview_id AND candidate_id IN (SELECT * FROM @candidateList);
INSERT into candidate_interview_status (interview_id, status, date_added, candidate_id) (SELECT @interview_id, @status, GETDATE(), * FROM @candidateList);*/
/*
END
*/
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterviews_Add] @job_id int, @title varchar(200)=NULL, @description varchar(max)=NULL, 
@round int, @venue varchar(200)=NULL, @date_of_interview date, @active int, @logged_in_user_id int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM interviews WHERE title=@title AND job_id=@job_id)
SET @RET = -2;
ELSE IF EXISTS (SELECT 1 FROM interviews WHERE job_id=@job_id AND round=@round)
SET @RET = -3;
ELSE
BEGIN
INSERT INTO dbo.interviews(job_id, title, description, round, venue, date_of_interview, active, logged_in_user_id) VALUES(CAST(@job_id AS int), @title, @description, CAST(@round AS int), @venue, convert(date, @date_of_interview, 105), CAST(@active AS int), CAST(@logged_in_user_id AS int));
SET @Ret = SCOPE_IDENTITY()
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInterviews_Delete] @id int As
 DECLARE @Ret int; 
 SET @Ret = -1;
 IF EXISTS (SELECT 1 FROM interviews WHERE id=@id)
 BEGIN 
 DELETE FROM interviews WHERE id=@id;  
 SET @Ret = 1;
 END
 SELECT @Ret
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterviews_Edit] @id int, @job_id int, @title varchar(200)=NULL, @description varchar(max)=NULL, 
@round int, @venue varchar(200)=NULL, @date_of_interview date, @active int, @logged_in_user_id int, @Ret int OUTPUT AS
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM interviews WHERE title=@title AND job_id=@job_id AND id<>@id)
SET @RET = -2;
ELSE IF EXISTS (SELECT 1 FROM interviews WHERE job_id=@job_id AND round=@round AND id<>@id)
SET @RET = -3;
ELSE
BEGIN
UPDATE dbo.interviews SET title=@title, description=@description, round=@round, venue=@venue, date_of_interview=convert(date, @date_of_interview, 105), active=@active, logged_in_user_id=@logged_in_user_id WHERE id=@id;
SET @Ret = 1
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
	SET @ItemCount = (SELECT COUNT(*) FROM interviews WHERE @srchBy LIKE @SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempInterviews AS
	(SELECT id, job_id, title, description, round, venue, date_of_interview, active,
	ROW_NUMBER() OVER (order by date_of_interview) as RowNumber
	FROM interviews WHERE @SrchBy LIKE @SrchVal+'%')

	SELECT * 
	FROM tempInterviews 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_GetList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInterviews_GetList] @job_id int AS
BEGIN
SELECT id, title, round, date_of_interview FROM interviews WHERE job_id = @job_id order by round;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspInterviews_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspInterviews_GetSingle] @id int as
BEGIN
SELECT * FROM interviews WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJob_Candidates_AddApplied]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJob_Candidates_AddApplied] @job_id int, @candidate_id int, @logged_in_userid int, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
BEGIN
INSERT into job_candidates(job_id, candidate_id, status, score, rating, employer_comments, date_added, date_updated, logged_in_userid) VALUES (@job_id, @candidate_id, 1, 0, 0, '', GETDATE(), GETDATE(), @logged_in_userid);
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJob_Candidates_AddNotified]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJob_Candidates_AddNotified] @interview_id int, @candidateList dbo.EntityIdsTableType READONLY, @status int, @logged_in_user_id int, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
DECLARE @job_id int;
SET @job_id = (SELECT job_id FROM interviews WHERE id=@interview_id);
BEGIN
INSERT into job_candidates(job_id, status, score, rating, employer_comments, date_added, date_updated, logged_in_userid, candidate_id) (SELECT @job_id, @status, 0, 0, '', GETDATE(), GETDATE(), @logged_in_user_id, * FROM @candidateList);
/*DELETE FROM candidate_interview_status WHERE interview_id = @interview_id AND candidate_id IN (SELECT * FROM @candidateList);
INSERT into candidate_interview_status (interview_id, status, date_added, candidate_id) (SELECT @interview_id, @status, GETDATE(), * FROM @candidateList);*/
/*
END
*/
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJob_Candidates_IsApplied]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJob_Candidates_IsApplied] @job_id int, @candidate_id int, @Ret int OUTPUT AS 
BEGIN
SET @Ret = 0;
IF EXISTS (SELECT 1 FROM job_candidates WHERE job_id = @job_id AND candidate_id = @candidate_id AND status = 1)
BEGIN
SET @Ret = 1
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobQualifications_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobQualifications_Get] @job_id int as
BEGIN
SELECT t1.qualification_id as id, t2.title as qualification FROM job_qualifications as t1 JOIN qualifications as t2 ON t1.qualification_id = t2.id WHERE t1.job_id = @job_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Add] @job_code varchar(150), @description varchar(max)=NULL, @industry int, @category int, @employer_id int, 
@location_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @min_exp int, @max_exp int, @currency int, @min_sal int, @max_sal int, @active int, @logged_in_userid int, @skillList dbo.EntityIdsTableType READONLY, @qualificationList dbo.EntityIdsTableType READONLY, @join_date date, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM jobs WHERE job_code=@job_code)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
INSERT INTO dbo.jobs(job_code, description, industry, category, employer_id, 
location_id, vacancy_count, other_notes, min_exp, max_exp, currency, min_sal, max_sal, join_Date, active, logged_in_userid, date_added, date_updated) 
VALUES(@job_code, @description, @industry, @category, CAST(@employer_id AS int), 
CAST(@location_id AS int), CAST(@vacancy_count AS int), @other_notes, CAST(@min_exp AS int), CAST(@max_exp AS int), CAST(@currency AS int), CAST(@min_sal AS int), 
CAST(@max_sal AS int), convert(varchar(20), @join_date, 110), CAST(@active AS int), CAST(@logged_in_userid AS int), GETDATE(), GETDATE());
SET @Ret = SCOPE_IDENTITY();
IF(@Ret > 0)
BEGIN
INSERT into job_skills (job_id, skill_id) (SELECT @Ret, * FROM @skillList);
INSERT into job_qualifications(job_id, qualification_id) (SELECT @Ret, * FROM @qualificationList);
/*
WITH tempJobSkills AS (SELECT value FROM string_split(@job_skills, ',')) INSERT INTO job_skills (job_id, skill_id) SELECT @Ret, t.value FROM tempJobSkills as t;
WITH tempJobQualifications AS (SELECT value FROM string_split(@job_qualifications, ',')) INSERT INTO job_qualifications (job_id, qualification_id) SELECT @Ret, t.value FROM tempJobQualifications as t;
*/
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Edit] @job_id int, @job_code varchar(150), @industry int, @category int, @description varchar(max)=NULL, @employer_id int, 
@location_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @min_exp int, @max_exp int, @currency int, @min_sal int,
@max_sal int, @active int, @logged_in_userid int, @skillList dbo.EntityIdsTableType READONLY, 
@qualificationList dbo.EntityIdsTableType READONLY, @join_date date, @Ret int OUTPUT AS 
BEGIN
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM jobs WHERE job_code=@job_code AND id<>@job_id)
BEGIN
SET @RET = -2;
END
ELSE
BEGIN
UPDATE dbo.jobs SET job_code=@job_code, industry=CAST(@industry AS int), category=CAST(@category AS int), description=@description, employer_id=@employer_id, 
location_id=CAST(@location_id AS int), vacancy_count=CAST(@vacancy_count AS int), other_notes=@other_notes, 
min_exp=CAST(@min_exp AS int), max_exp=CAST(@max_exp AS int), currency=CAST(@currency AS int), min_sal=CAST(@min_sal AS int), 
max_sal=CAST(@max_sal AS int), join_Date=convert(varchar(20), @join_date, 110), active=CAST(@active AS int), logged_in_userid=CAST(@logged_in_userid AS int), date_updated=GETDATE() 
WHERE id=@job_id;
SET @Ret = @@ROWCOUNT;
IF(@Ret > 0)
BEGIN
DELETE FROM job_skills WHERE job_id = @job_id;
DELETE FROM job_qualifications WHERE job_id = @job_id;
INSERT into job_skills (job_id, skill_id) (SELECT @job_id, * FROM @skillList);
INSERT into job_qualifications(job_id, qualification_id) (SELECT @job_id, * FROM @qualificationList);
/*WITH tempJobSkills AS (SELECT value FROM string_split(@job_skills, ',')) INSERT INTO job_skills (job_id, skill_id) SELECT @Ret, t.value FROM tempJobSkills as t;
WITH tempJobQualifications AS (SELECT value FROM string_split(@job_qualifications, ',')) INSERT INTO job_qualifications (job_id, qualification_id) SELECT @Ret, t.value FROM tempJobQualifications as t;*/
END
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspJobs_Get]
	@employer_id int,
	@SrchBy varchar(50), 
	@SrchVal varchar(100),
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM jobs WHERE job_code LIKE '%'+@SrchVal+'%')

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempJobs AS
	(SELECT t1.id, t1.job_code, t2.name as employer , t1.description, t1.active,
	ROW_NUMBER() OVER (order by job_code) as RowNumber
	FROM jobs as t1 JOIN employers as t2 ON t1.employer_id=t2.id WHERE t1.job_code LIKE '%'+@SrchVal+'%')

	SELECT * 
	FROM tempJobs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetDetails]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_GetDetails] @job_id int as
BEGIN
SELECT t1.job_code, t1.description, t1.date_added, t1.vacancy_count, t1.min_sal, t1.max_sal, t1.min_exp, 
t1.max_exp, t1.other_notes, t1.join_date, t2.title as industry, t3.title as category, 
t4.name as currency, (SELECT title + ', ' FROM skills s JOIN job_skills as js ON s.id = js.skill_id WHERE js.job_id=t1.id AND s.id = js.skill_id ORDER BY s.title FOR XML PATH('') ) AS skills, 
(SELECT title + ', ' FROM qualifications q JOIN job_qualifications as jq ON q.id = jq.qualification_id WHERE jq.job_id=t1.id AND q.id = jq.qualification_id  ORDER BY q.title FOR XML PATH('') ) AS qualifications

FROM jobs as t1 JOIN industries as t2 ON t1.industry = t2.id JOIN categories as t3 
ON t1.category = t3.id JOIN currencies as t4 ON t1.currency = t4.id WHERE t1.id = @job_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetInterviewList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetInterviewList] @job_id int AS
BEGIN
SELECT id, title FROM interviews WHERE job_id = @job_id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetInterviewResults]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetInterviewResults] @job_id int AS
BEGIN
SELECT t1.interview_id, t2.name as candidate_name, t3.title as status, t1.score, t1.rating, t1.employer_comments, t1.date_added FROM interview_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id JOIN candidate_status as t3 ON t1.status = t3.id WHERE interview_id IN (SELECT id FROM interviews WHERE job_id = @job_id) ORDER BY interview_id;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetInterviewResults2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetInterviewResults2] @job_id int, @int_id int AS
BEGIN
DECLARE @cursor CURSOR;
DECLARE @interview_id INT;
IF(@int_id<>0)
BEGIN
SET @cursor = CURSOR FOR SELECT id FROM interviews WHERE id=@int_id
END
ELSE IF(@int_id=0)
BEGIN
SET @cursor = CURSOR FOR SELECT id FROM interviews WHERE job_id = @job_id ORDER BY id DESC;
END
BEGIN
OPEN @cursor FETCH NEXT FROM @cursor INTO @interview_id 
WHILE @@FETCH_STATUS = 0
    BEGIN
      SELECT t1.interview_id, t4.title, t4.round, t4.date_of_interview, t2.name as candidate_name, t3.title as status, t1.score, t1.rating, t1.employer_comments, t1.date_added FROM interview_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id JOIN candidate_status as t3 ON t1.status = t3.id JOIN interviews as t4 ON t1.interview_id = t4.id WHERE interview_id = @interview_id
      FETCH NEXT FROM @cursor 
      INTO @interview_id
    END; 

    CLOSE @cursor ;
    DEALLOCATE @cursor;
  
RETURN
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetQualifiedsList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetQualifiedsList] @job_id int AS
BEGIN
SELECT candidate_id as id, t2.name as name, t1.status FROM job_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id WHERE t1.candidate_id NOT IN (SELECT candidate_id FROM interview_candidates) AND job_id=@job_id 
UNION
SELECT DISTINCT t1.id, t1.name, status=0 FROM candidates as t1 JOIN candidate_skills as t2 ON t1.id=t2.candidate_id
WHERE t1.id NOT IN (SELECT candidate_id FROM interview_candidates) AND t2.skill_id IN (SELECT skill_id FROM job_skills WHERE job_id=@job_id)
AND NOT EXISTS (SELECT * FROM job_candidates as j WHERE t1.id=j.candidate_id)
ORDER BY name;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetQualifiedsList2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetQualifiedsList2] @job_id int AS
BEGIN
DECLARE @round int;
DECLARE @prev_interview_id int;
SET @round = (SELECT MAX(round) FROM interviews WHERE job_id = @job_id);
SET @prev_interview_id = (SELECT id FROM interviews WHERE job_id = @job_id AND round = @round-1);
SELECT candidate_id as id, t2.name as name, t1.status, t1.score, t1.rating, t1.employer_comments FROM interview_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id WHERE t1.status = 4 AND t1.interview_id=@prev_interview_id AND t1.active=1
ORDER BY name;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetQualifiedsList3]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetQualifiedsList3] @job_id int, @status varchar(50) AS
BEGIN
IF(@status = 'applied')
BEGIN
SELECT candidate_id as id, t2.name as name, t1.status FROM job_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id WHERE t1.candidate_id NOT IN (SELECT candidate_id FROM interview_candidates) AND t1.status=1 AND job_id=@job_id ORDER BY name;
END
ELSE IF(@status = 'eligible')
BEGIN
SELECT candidate_id as id, t2.name as name, t1.status FROM job_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id WHERE t1.candidate_id NOT IN (SELECT candidate_id FROM interview_candidates) AND t1.status=7 AND job_id=@job_id 
UNION
SELECT DISTINCT t1.id, t1.name, status=0 FROM candidates as t1 JOIN candidate_skills as t2 ON t1.id=t2.candidate_id
WHERE t1.id NOT IN (SELECT candidate_id FROM interview_candidates) AND t2.skill_id IN (SELECT skill_id FROM job_skills WHERE job_id=@job_id)
AND NOT EXISTS (SELECT * FROM job_candidates as j WHERE t1.id=j.candidate_id)
ORDER BY name;
END
ELSE
BEGIN
SELECT candidate_id as id, t2.name as name, t1.status FROM job_candidates as t1 JOIN candidates as t2 ON t1.candidate_id = t2.id WHERE t1.candidate_id NOT IN (SELECT candidate_id FROM interview_candidates) AND job_id=@job_id 
UNION
SELECT DISTINCT t1.id, t1.name, status=0 FROM candidates as t1 JOIN candidate_skills as t2 ON t1.id=t2.candidate_id
WHERE t1.id NOT IN (SELECT candidate_id FROM interview_candidates) AND t2.skill_id IN (SELECT skill_id FROM job_skills WHERE job_id=@job_id)
AND NOT EXISTS (SELECT * FROM job_candidates as j WHERE t1.id=j.candidate_id)
ORDER BY name;
END
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetSelectedsList]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspJobs_GetSelectedsList] @interview_id int, @Ret int OUTPUT AS
BEGIN
SELECT t1.candidate_id, t1.interview_id, t1.score, t1.rating, t1.employer_comments, t2.name as name, t3.title as status FROM interview_candidates as t1 JOIN candidates as t2 
ON t1.candidate_id = t2.id JOIN candidate_status as t3 ON t1.status = t3.id WHERE interview_id = @interview_id AND t1.status IN (2,3,4,5);
SET @Ret = @@ROWCOUNT;
RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_GetSingle] @id int as
BEGIN
SELECT * FROM jobs WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetVacancies]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspJobs_GetVacancies]
	@customer int,
	@industry int,
	@category int, 
	@skill int,
	@job_code varchar(150),
	@employer int,
	@min_exp int,
	@max_exp int,
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	
	-- Get The Count Of The Rows That They Meet the Criteria
	SET @ItemCount = (SELECT COUNT(*) FROM jobs WHERE employer_id IN (SELECT id FROM employers WHERE customer_id = @customer))

	-- Calculate the @LowerCount and @UpperCount
	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	BEGIN
	WITH tempJobs AS
	(SELECT t1.*, t2.name as employer, t3.title as industry_name, t4.title as category_name,
	ROW_NUMBER() OVER (order by job_code) as RowNumber
	FROM jobs as t1 JOIN employers as t2 ON t1.employer_id=t2.id JOIN industries as t3 ON t1.industry=t3.id JOIN categories as t4 ON t1.category=t4.id WHERE employer_id IN (SELECT id FROM employers WHERE customer_id = @customer))

	SELECT * 
	FROM tempJobs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetVacancies2]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspJobs_GetVacancies2]
	@customer int,
	@industry int,
	@category int, 
	@skill int,
	@job_code varchar(150),
	@employer int,
	@min_exp int,
	@max_exp int,
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	Declare @UpperBand int, @LowerBand int
	DECLARE @sql1 nvarchar(max);
	DECLARE @sql2 nvarchar(max);

	SET @sql1 = 'SELECT COUNT(t1.id) FROM jobs as t1 JOIN job_skills as t2 ON t1.id = t2.job_id WHERE employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+')';
	SET @sql2 = 'SELECT t1.* FROM jobs as t1 JOIN job_skills as t2 ON t1.id = t2.job_id WHERE employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+')';
	
	BEGIN
	
	IF(@industry <> 0)
	BEGIN
	SET @sql1 = @sql1 + 'AND t1.industry=' + CAST(@industry AS nvarchar);
	SET @sql2 = @sql2 + 'AND t1.industry=' + CAST(@industry AS nvarchar);
	END

	IF(@category <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND t1.category=' + CAST(@category AS nvarchar);
	SET @sql2 = @sql2 + ' AND t1.category=' + CAST(@category AS nvarchar);
	END

	IF(@skill <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND t2.skill_id=' + CAST(@skill AS nvarchar);
	SET @sql2 = @sql2 + ' AND t2.skill_id=' + CAST(@skill AS nvarchar);
	END

	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	SET @sql2 = @sql2 + ' ORDER BY t1.date_added OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY';

	PRINT @sql1
	PRINT @sql2

	EXEC @ItemCount = @sql1
	EXEC (@sql2)



	/*
	-- Get The Count Of The Rows That They Meet the Criteria
	/*SET @ItemCount = (SELECT COUNT(*) FROM jobs WHERE employer_id IN (SELECT id FROM employers WHERE customer_id = @customer))*/

	-- Calculate the @LowerCount and @UpperCount

	BEGIN
	WITH tempJobs AS
	(SELECT t1.*, t2.name as employer, t3.title as industry_name, t4.title as category_name,
	ROW_NUMBER() OVER (order by job_code) as RowNumber
	FROM jobs as t1 JOIN employers as t2 ON t1.employer_id=t2.id JOIN industries as t3 ON t1.industry=t3.id JOIN categories as t4 ON t1.category=t4.id WHERE employer_id IN (SELECT id FROM employers WHERE customer_id = @customer))

	SELECT * 
	FROM tempJobs 
	WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	END
	*/
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_GetVacancies3]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspJobs_GetVacancies3]
	@customer int,
	@industry int,
	@category int, 
	@skill int,
	@job_code varchar(150),
	@employer int,
	@min_exp int,
	@max_exp int,
	@PageSize int,
	@CurrentPage int,
	@ItemCount int output
AS
	  
	Declare @UpperBand int, @LowerBand int
	DECLARE @sql1 nvarchar(max);
	DECLARE @sql2 nvarchar(max);
	DECLARE @sql_title nvarchar(max);
	
	DECLARE @ParmDefinition nvarchar(500);
	SET @ParmDefinition = N'@retvalOUT int OUTPUT';
	

	SET @sql1 = 'SELECT @retvalOUT= COUNT(j.id)  FROM jobs as j WHERE j.employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+') AND j.active=1 ' ;
	--SET @sql2 = 'SELECT j.*, '+ @sql_title+' FROM jobs as j JOIN job_skills as js ON j.id = js.job_id WHERE j.employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+')';
	/*SET @sql2 = 'SELECT j.*,(SELECT title + '','' FROM skills s  JOIN job_skills as js ON s.id = js.skill_id WHERE js.job_id=j.id AND  s.id = js.skill_id  ORDER BY s.title FOR XML PATH('''') ) AS skill_name
FROM jobs as j WHERE j.employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+')' ;
*/

SET @sql2 = 'SELECT j.*, ind.title as industry_name, cat.title as category_name, (SELECT title + '','' FROM skills s  JOIN job_skills as js ON s.id = js.skill_id WHERE js.job_id=j.id AND  s.id = js.skill_id  ORDER BY s.title FOR XML PATH('''') ) AS skill_name, 
	ROW_NUMBER() OVER (order by j.date_added) as RowNumber
FROM jobs as j JOIN industries as ind ON j.industry = ind.id JOIN categories as cat ON j.category = cat.id WHERE j.employer_id IN (SELECT id FROM employers WHERE customer_id='+ CAST(@customer AS VARCHAR)+') AND j.active=1 ';

	BEGIN
	
	IF(@industry <> 0)
	BEGIN
	SET @sql1 = @sql1 + 'AND j.industry=' + CAST(@industry AS nvarchar);
	SET @sql2 = @sql2 + 'AND j.industry=' + CAST(@industry AS nvarchar);
	END

	IF(@category <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND j.category=' + CAST(@category AS nvarchar);
	SET @sql2 = @sql2 + ' AND j.category=' + CAST(@category AS nvarchar);
	END

	IF(@job_code <> '')
	BEGIN
	SET @sql1 = @sql1 + ' AND j.job_code LIKE ''%' + CAST(@job_code AS nvarchar) + '%''';
	SET @sql2 = @sql2 + ' AND j.job_code LIKE ''%' + CAST(@job_code AS nvarchar) + '%''';
	END

	IF(@employer <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND j.employer_id=' + CAST(@employer AS nvarchar);
	SET @sql2 = @sql2 + ' AND j.employer_id=' + CAST(@employer AS nvarchar);
	END

	IF(@min_exp <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND j.min_exp<=' + CAST(@min_exp AS nvarchar);
	SET @sql2 = @sql2 + ' AND j.min_exp<=' + CAST(@min_exp AS nvarchar);
	END

	IF(@max_exp <> 0)
	BEGIN
	SET @sql1 = @sql1 + ' AND j.max_exp<=' + CAST(@max_exp AS nvarchar);
	SET @sql2 = @sql2 + ' AND j.max_exp<=' + CAST(@max_exp AS nvarchar);
	END

	IF(@skill <> 0)
	BEGIN
	--SET @sql1 = @sql1 + ' AND js.skill_id=' + CAST(@skill AS nvarchar);
	--SET @sql2 = @sql2 + ' AND js.skill_id=' + CAST(@skill AS nvarchar);
	SET @sql1 = @sql1 + ' AND j.id IN (SELECT job_id FROM job_skills WHERE skill_id=' + CAST(@skill AS nvarchar)+')';
	SET @sql2 = @sql2 + ' AND j.id IN (SELECT job_id FROM job_skills WHERE skill_id=' + CAST(@skill AS nvarchar)+')';
	
	END

	SET @LowerBand  = (@CurrentPage - 1) * @PageSize
	SET @UpperBand  = (@CurrentPage * @PageSize) + 1

	--SET @sql2 = @sql2 + ' ORDER BY j.date_added OFFSET '+ CAST(@LowerBand AS nvarchar) + ' ROWS FETCH FIRST ' + CAST(@PageSize AS nvarchar) + ' ROWS ONLY';
	
	PRINT @sql1
	PRINT @sql2
	

	-- EXEC @ItemCount = @sql1
	-- EXEC (@sql1)
	
	EXEC sp_executesql @sql1, @ParmDefinition, @retvalOUT=@ItemCount OUTPUT;
	
CREATE TABLE ##TempTable ( 	[id] [int],
	[job_code] [varchar](150),
	[industry] [int] ,
	[category] [int] ,
	[description] [text] ,
	[employer_id] [int] ,
	[location_id] [int] ,
	[vacancy_count] [int] ,
	[other_notes] [text] ,
	[min_exp] [int] ,
	[max_exp] [int] ,
	[currency] [int] ,
	[min_sal] [int] ,
	[max_sal] [int],
	[join_date] [date] ,
	[active] [int] ,
	[logged_in_userid] [int],
	[date_added] [date] ,
	[date_updated] [date],
	[industry_name] [varchar](250),
	[category_name] [varchar](250),
	[skills] [varchar](250), RowNumber int)



	INSERT INTO ##TempTable	EXEC (@sql2)
	SELECT * FROM ##TempTable WHERE RowNumber > @LowerBand AND RowNumber < @UpperBand
	
	 IF OBJECT_ID('tempdb..##TempTable','u') IS NOT NULL
    DROP TABLE ##TempTable
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobSkills_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobSkills_Get] @job_id int as
BEGIN
SELECT t1.skill_id as id, t2.title as skill FROM job_skills as t1 JOIN skills as t2 ON t1.skill_id = t2.id WHERE t1.job_id = @job_id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications&Temp_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspQualifications&Temp_Get] @Userid int AS
BEGIN
SELECT qua.id as qua_id, qua.title as qua_title, tmp.id as tmp_id, tmp.title as tmp_title FROM qualifications as qua JOIN qualifications_temp as tmp ON qua.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add_FromFile]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get_StartingWith]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Get_StartingWith] @srchVal varchar(100) as
BEGIN
SELECT id, title as value FROM qualifications WHERE title LIKE @srchVal+'%' ORDER BY title;
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_GetSingle] @id int as
BEGIN
SELECT * FROM qualifications WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills&Temp_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspSkills&Temp_Get] @Userid int AS
BEGIN
SELECT skl.id as skl_id, skl.title as skl_title, tmp.id as tmp_id, tmp.title as tmp_title FROM skills as skl JOIN skills_temp as tmp ON skl.title = tmp.title WHERE userid = @Userid; 
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Add_FromFile]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Get_StartingWith]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Get_StartingWith] @srchVal varchar(100) as
BEGIN
SELECT id, title as value FROM skills WHERE title LIKE @srchVal+'%' ORDER BY title;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_GetSingle] @id int as
BEGIN
SELECT * FROM skills WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_ChangePassword]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsers_ChangePassword] @email varchar(100), @old_password varchar(100), @new_password varchar(100), @ip_address varchar(16), @Ret int OUTPUT  
AS
BEGIN
	 DECLARE @salt VARBINARY(4) = CRYPT_GEN_RANDOM(4);
	 DECLARE @new_salt VARBINARY(4);	 
	 DECLARE @hash VARBINARY(MAX); 
	 DECLARE @new_hash VARBINARY(MAX);
	 SET @Ret = 0;

	 SELECT @new_salt = salt, @new_hash=[password] FROM dbo.users WHERE email=@email;

	 if(@new_salt <> '' AND @new_hash <> '')
	 BEGIN		
		SET @hash = 0x0200 + @new_salt + HASHBYTES('SHA1', CAST(@old_password AS VARBINARY(MAX)) + @new_salt);
		/* Recreating hash from user input and matching with hash produced from existing record */
		IF(@hash = @new_hash)
		BEGIN
		IF((SELECT active FROM users WHERE email=@email) = 1)
		BEGIN
		SET @hash = 0x0200 + @salt + HASHBYTES('SHA1', CAST(@new_password AS VARBINARY(MAX)) + @salt)
		UPDATE users SET password=@hash, salt = @salt WHERE email = @email;
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
/****** Object:  StoredProcedure [dbo].[uspUsers_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_EditDetails]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_EditDetails] @ref_id int, @user_id int, @user_type int, @name varchar(max)=NULL, @gender varchar(10)=NULL, @designation varchar(150)=NULL, @address varchar(max)=NULL, @phone varchar(100)=NULL, @email varchar(100)=NULL, @Ret int OUTPUT as
BEGIN
DECLARE @return as int;
SET @Ret = -1;
IF EXISTS (SELECT 1 FROM users WHERE email=@email AND id<>@user_id)
SET @RET = -2;
ELSE
BEGIN
IF(@user_type = 1)
BEGIN
UPDATE users SET email=@email WHERE id = @user_id;
SET @return = 1;
END
ELSE IF(@user_type = 2 OR @user_type = 3)
BEGIN
UPDATE customer_staffs SET name=@name, gender=@gender, designation=@designation, address=@address, phone=@phone, email=@email;
UPDATE users SET email=@email WHERE id=@user_id;
SET @return = 1;
END
ELSE IF(@user_type = 4 OR @user_type = 5)
BEGIN
UPDATE employer_staffs SET name=@name, gender=@gender, designation=@designation, address=@address, phone=@phone, email=@email;
UPDATE users SET email=@email WHERE id=@user_id;
SET @return = 1;
END
ELSE
BEGIN
UPDATE candidates SET name=@name, gender=@gender, address=@address, phone=@phone, email=@email;
UPDATE users SET email=@email WHERE id=@user_id;
SET @return = 1;
END
END
SET @Ret = @return;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_GetDetails]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUsers_GetDetails] @ref_id int, @user_type int as
BEGIN
IF(@user_type = 1)
BEGIN
SELECT id, name='Super Admin', email as email, user_type_name='Super Admin', last_logged_in, ip_address FROM users WHERE id=1;
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
SELECT t1.*, t2.last_logged_in, t2.ip_address, t3.type_name as user_type_name from candidates as t1 JOIN users as t2 ON t1.user_id = t2.id JOIN user_type as t3 ON t2.user_type = t3.id WHERE t1.id=@ref_id; 
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsers_GetSingle]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_ValidateUser]    Script Date: 04-Sep-19 04:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsers_ValidateUser] @Username varchar(100), @Password  varchar(100), @Ip_address varchar(16)=NULL, @Ret int OUTPUT  
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
		UPDATE users SET last_logged_in = GETDATE(), ip_address = @Ip_address WHERE email = @Username;
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Add]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Delete]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Edit]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Get]    Script Date: 04-Sep-19 04:57:53 PM ******/
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
EXEC [recruiterdb19].sys.sp_addextendedproperty @name=N'Caption', @value=N'insynctechs.co.in' 
GO
USE [master]
GO
ALTER DATABASE [recruiterdb19] SET  READ_WRITE 
GO
