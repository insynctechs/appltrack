CREATE  procedure [dbo].[uspCandidates_Add] @candidate_name varchar(100), @dob date, @gender char(1), @qualifications varchar(50)=NULL, @experience int,
@address varchar(max) = NULL, @others varchar(max)=NULL, @skills varchar(max) = NULL, @status int, @rating int, @employer_comments varchar(max)=NULL, @added_date datetime, @updated_date datetime AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
BEGIN
INSERT INTO dbo.candidates(candidate_name, dob, gender, qualifications, experience, address, others, skills, status, rating, employer_comments, added_date, updated_date) 
VALUES (@candidate_name, @dob, @gender, @qualifications, @experience,
@address, @others, @skills, @status, @rating, @employer_comments, @added_date, @updated_date);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCandidates_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidates_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCandidates_Get]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Add]    Script Date: 08-May-19 03:05:05 PM ******/
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
BEGIN
INSERT INTO dbo.customers(name, address, city, state, zip, contact, email, phone, active, license, license_expiry,
license_year, added_date, updated_date) VALUES(@name, @address, @city, @state, @zip, @contact, @email, @phone, 
@active, @license, @license_expiry, @license_year, @added_date, @updated_date);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspCustomers_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCustomers_Get]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Add]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspJobs_Add] @job_code varchar(150), @description varchar(max)=NULL, @employer_id int, 
@branch_id int, @vacancy_count int, @other_notes varchar(max)=NULL, @experience int, @active int AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
BEGIN
INSERT INTO dbo.jobs(job_code, description, employer_id, 
branch_id, vacancy_count, other_notes, experience, active) 
VALUES(@job_code, @description, @employer_id, 
@branch_id, @vacancy_count, @other_notes, @experience, @active);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspJobs_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspJobs_Get]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Add]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Add] @qualification varchar(max) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
BEGIN
INSERT INTO dbo.qualifications(qualification) 
VALUES(@qualification);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspQualifications_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspQualifications_Edit] @id int, @qualification varchar(max) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.qualifications SET qualification = @qualification WHERE id=@id; 
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspQualifications_Get]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspQualifications_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM qualifications ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by qualification';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Add]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Add] @skill varchar(max) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
BEGIN
INSERT INTO dbo.skills(skill) 
VALUES(@skill);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSkills_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspSkills_Edit] @id int, @skill varchar(max) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
UPDATE dbo.skills SET skill = @skill WHERE id = @id;
SET @Ret = @@ROWCOUNT;
SELECT @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[uspSkills_Get]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[uspSkills_Get] @SearchBy varchar(50), @SearchValue varchar(100) as
begin
declare @sql nvarchar(max);
set @sql = 'select * FROM skills ';
if(@SearchBy <> 'All')
begin
set @sql = @sql + ' where ' + @SearchBy + ' like ''' + @SearchValue + '%''';
end
set @sql = @sql + ' order by skill';
exec(@sql);
end
GO
/****** Object:  StoredProcedure [dbo].[uspUser_Add]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUser_Add] @email varchar(250), @user_level int, 
@active int, @added_date datetime, @updated_date datetime, @last_logged_in datetime, @ipaddress varchar(16)=NULL AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
DECLARE @pwd VARBINARY(MAX);
 SELECT @pwd = CAST(@email AS VARBINARY(MAX)); 
 DECLARE @salt VARBINARY(4) = CRYPT_GEN_RANDOM(4);
BEGIN
INSERT INTO dbo.users(email, pwd, salt, user_level, active, added_date, updated_date, last_logged_in, ipaddress) 
VALUES(@email, CONVERT(varbinary, @pwd), @salt, @user_level, @active, @added_date, @updated_date, @last_logged_in, @ipaddress);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUser_Edit]    Script Date: 08-May-19 03:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Need to redo the code */
CREATE procedure [dbo].[uspUser_Edit] @id int, @email varchar(250), @user_level int, 
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
/****** Object:  StoredProcedure [dbo].[uspUsers_Delete]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUsers_Get]    Script Date: 08-May-19 03:05:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Add]    Script Date: 08-May-19 03:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUserTypes_Add] @type_name varchar(50) AS
BEGIN
DECLARE @Ret int;
SET @Ret = -1;
BEGIN
INSERT INTO dbo.user_type(type_name) 
VALUES(@type_name);
SET @Ret = 1;
END
SELECT @Ret;
END
GO
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Delete]    Script Date: 08-May-19 03:05:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Edit]    Script Date: 08-May-19 03:05:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspUserTypes_Get]    Script Date: 08-May-19 03:05:06 PM ******/
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
