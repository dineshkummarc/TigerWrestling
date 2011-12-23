USE [master]
IF NOT EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = 'TigerWrestling') CREATE DATABASE TigerWrestling
Go

USE [master]
 -- Create the sql to kill the active database connections
declare @execSql varchar(1000), @databaseName varchar(100)
-- Set the database name for which to kill the connections
set @databaseName = 'TigerWrestling'

set @execSql = '' 
select  @execSql = @execSql + 'kill ' + convert(char(10), spid) + ' '
from master.dbo.sysprocesses
where db_name(dbid) = @databaseName
	and status in ('runnable','sleeping') 
	and status <> 'background' 
	and
	DBID <> 0
	and
	spid <> @@spid
	
--print @execSql 
exec(@execSql)
GO

Use TigerWrestling
GO


--DROP TABLES

PRINT 'Started dropping tables' 
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaInfo]') AND type IN ( N'U' ) )  DROP TABLE [SchemaInfo]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleUser]') AND type IN ( N'U' ) )  DROP TABLE [RoleUser]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type IN ( N'U' ) )  DROP TABLE [Role] 
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type IN ( N'U' ) )  DROP TABLE [User]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppLog]') AND type IN ( N'U' ) )  DROP TABLE [AppLog]  
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectProperty]') AND type IN ( N'U' ) )  DROP TABLE [ProjectProperty]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentVersion]') AND type IN ( N'U' ) )  DROP TABLE [ContentVersion]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Content]') AND type IN ( N'U' ) )  DROP TABLE [Content]
IF EXISTS (SELECT *  FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Entry]')  AND type in (N'U')) DROP TABLE [Entry]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Faq]') AND type IN ( N'U' ) )  DROP TABLE [Faq] 
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Media]') AND type IN ( N'U' ) ) DROP TABLE [Media]
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Prospect]') AND type IN ( N'U' ) ) DROP TABLE [Prospect] 
GO
PRINT '... Finished dropping tables' 



IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAppLog]'))  DROP PROCEDURE [dbo].[DeleteAppLog]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContent]'))  DROP PROCEDURE [dbo].[DeleteContent]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContentVersion]'))  DROP PROCEDURE [dbo].[DeleteContentVersion]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEntry]'))  DROP PROCEDURE [dbo].[DeleteEntry]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFaq]'))  DROP PROCEDURE [dbo].[DeleteFaq]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteInternet]'))  DROP PROCEDURE [dbo].[DeleteInternet]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteMedia]'))  DROP PROCEDURE [dbo].[DeleteMedia]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProjectProperty]'))  DROP PROCEDURE [dbo].[DeleteProjectProperty]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProspect]'))  DROP PROCEDURE [dbo].[DeleteProspect]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRole]'))  DROP PROCEDURE [dbo].[DeleteRole]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRoleUser]'))  DROP PROCEDURE [dbo].[DeleteRoleUser]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSchemaInfo]'))  DROP PROCEDURE [dbo].[DeleteSchemaInfo]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUser]'))  DROP PROCEDURE [dbo].[DeleteUser]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DisableAllTriggers]'))  DROP PROCEDURE [dbo].[DisableAllTriggers]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EnableAllTriggers]'))  DROP PROCEDURE [dbo].[EnableAllTriggers]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveAppLog]'))  DROP PROCEDURE [dbo].[SaveAppLog]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveContent]'))  DROP PROCEDURE [dbo].[SaveContent]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveContentVersion]'))  DROP PROCEDURE [dbo].[SaveContentVersion]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveEntry]'))  DROP PROCEDURE [dbo].[SaveEntry]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveFaq]'))  DROP PROCEDURE [dbo].[SaveFaq]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveInternet]'))  DROP PROCEDURE [dbo].[SaveInternet]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveMedia]'))  DROP PROCEDURE [dbo].[SaveMedia]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveProjectProperty]'))  DROP PROCEDURE [dbo].[SaveProjectProperty]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveProspect]'))  DROP PROCEDURE [dbo].[SaveProspect]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveRole]'))  DROP PROCEDURE [dbo].[SaveRole]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveRoleUser]'))  DROP PROCEDURE [dbo].[SaveRoleUser]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveSchemaInfo]'))  DROP PROCEDURE [dbo].[SaveSchemaInfo]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SaveUser]'))  DROP PROCEDURE [dbo].[SaveUser]
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_generate_inserts_plain]'))  DROP PROCEDURE [dbo].[usp_generate_inserts_plain]



IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Content_Audit]'))  DROP Trigger [dbo].[Content_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentVersion_Audit]'))  DROP Trigger [dbo].[ContentVersion_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Entry_Audit]'))  DROP Trigger [dbo].[Entry_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Faq_Audit]'))  DROP Trigger [dbo].[Faq_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Internet_Audit]'))  DROP Trigger [dbo].[Internet_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Media_Audit]'))  DROP Trigger [dbo].[Media_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectProperty_Audit]'))  DROP Trigger [dbo].[ProjectProperty_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Prospect_Audit]'))  DROP Trigger [dbo].[Prospect_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role_Audit]'))  DROP Trigger [dbo].[Role_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleUser_Audit]'))  DROP Trigger [dbo].[RoleUser_Audit] 
IF  EXISTS (SELECT  * FROM    sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User_Audit]'))  DROP Trigger [dbo].[User_Audit] 














--ADD TABLES

PRINT 'Started adding tables' 

 
PRINT N' [SchemaInfo]'

CREATE TABLE [dbo].[SchemaInfo]
	(
	  [Id] [int] IDENTITY(1, 1) NOT NULL , 
	  [Version] [bigint] NOT NULL,
	  [Date] [datetime] DEFAULT (GETDATE()),
	  [UtcDate]  [datetime] DEFAULT (GETUTCDATE()),
	  [BuildNumber] [nvarchar](100)  , 
	  [Status] [nvarchar](50) NULL ,
	  [CreatedDate] [datetime] NULL ,
	  [CreatedBy] [nvarchar](50) NULL ,
	  [ModifiedDate] [datetime] NULL ,
	  [ModifiedBy] [nvarchar](50) NULL 
	) ;

INSERT [SchemaInfo] ([Version], [BuildNumber]  ) Values(1, 'BuildNumber'  )





-- Prospect --
PRINT N' [Prospect]' 
CREATE TABLE Prospect
	(
	  [Id] INT NOT NULL IDENTITY PRIMARY KEY , 
	  [FirstName] NVARCHAR(50) ,
	  [LastName] NVARCHAR(50) ,
	  [DateOfBirth] NVARCHAR(50) ,
	  [Phone] NVARCHAR(15) ,
	  [Email] NVARCHAR(50) ,
	  [Address1] NVARCHAR(100) , 
	  [City] NVARCHAR(50) , 
	  [SampleOptIn] Bit,
	  [Ip] NVARCHAR(128) , 
	  [Session] NVARCHAR(128) , 
	  [CustomerId] NVARCHAR(16) ,
	  [ProspectVisitDate] DATETIME ,
	  [Status] NVARCHAR(50) ,
	  [CreatedDate] DATETIME ,
	  [CreatedBy] NVARCHAR(50) ,
	  [ModifiedDate] DATETIME ,
	  [ModifiedBy] NVARCHAR(50)
	); 
ALTER TABLE [dbo].[Prospect] ADD  CONSTRAINT [DF_Prospect_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO  
ALTER TABLE [dbo].[Prospect] ADD  CONSTRAINT [DF_Prospect_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO  
ALTER TABLE [dbo].[Prospect] ADD  CONSTRAINT [DF_Prospect_Status]  DEFAULT ('Active') FOR [Status]
GO 
SET IDENTITY_INSERT Prospect ON 
INSERT  INTO Prospect ( [Id] , [FirstName], [LastName], [Status], [Email]) VALUES  ( '1', 'qatest', 'Garcia', 'Active', 'qatest@test.com')
SET IDENTITY_INSERT Prospect OFF  
INSERT  INTO Prospect ( [FirstName], [LastName], [Status], [Email], [SampleOptIn]) VALUES  (  'qatest1', 'aaaaaaaa', 'Active', 'qatest@test.com', 1) 



PRINT N' [User]'

CREATE TABLE [dbo].[User]
	(
	  [Id] [int] IDENTITY(1, 1)
				 NOT NULL , 
	  [UserType] [nvarchar](25) NULL,
	  [Name] [nvarchar](100) NULL, 
	  [Email] [nvarchar](256) NULL,
	  [Password] [nvarchar](128) NULL , 
	  [Description] [nvarchar](MAX) NULL , 
	  [FirstName] [nvarchar](50) NULL ,
	  [LastName] [nvarchar](50) NULL ,
	  [Status] [nvarchar](50) NULL ,
	  [CreatedDate] [datetime] NULL ,
	  [CreatedBy] [nvarchar](50) NULL ,
	  [ModifiedDate] [datetime] NULL ,
	  [ModifiedBy] [nvarchar](50) NULL ,
	  PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 

GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Status]  DEFAULT ('Active') FOR [Status]
GO

CREATE NONCLUSTERED INDEX [IX_Name_NC] ON [dbo].[User] 
(
[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO
				
SET IDENTITY_INSERT [User] ON
 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '1' ,  'aaa' ,   'aaa@test.com' ,  'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '2' ,  'bbb' ,   'bbb@test.com' ,   'sx1alyN9+68wRi6+Ez1Vug==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '3' ,  'admin' ,   'admin@test.com' ,  'Q+TJeJoRW0sDqyFqNQrhbA==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '4' ,  'ccc' ,   'ccc@test.com' ,   'Tryhi5jVkXbmcB/8W3n2oQ==','MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '5' ,  'ddd' ,  'ddd@test.com' ,   'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '6' ,  'eee' ,  'eee@test.com' ,   'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '7' ,  'fff' ,  'fff@test.com' ,   'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '8' ,  'ggg' ,  'ggg@test.com' ,   'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '9' ,  'hhh' ,   'hhh@test.com' ,   'aaaaaaaaaaaaaa==' , 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '10' ,  'iii' , 'iii@test.com' ,   'aaaaaaaaaaaaaa==', 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '11' ,  'jjj' , 'jjj@test.com' ,   'mjgw7n+mrXQbhv7W1Sf+7A==' , 'MigrationInsert', 'MigrationInsert') 
INSERT  INTO [User] (Id, Name, Email, [Password], CreatedBy, ModifiedBy)
VALUES  ( '12' ,  'kkk' , 'kkk@test.com' ,   'mjgw7n+mrXQbhv7W1Sf+7A==' , 'MigrationInsert', 'MigrationInsert') 

SET IDENTITY_INSERT [User] OFF


PRINT N' [Role]'

CREATE TABLE [dbo].[Role]
	(
		[Id] [int] IDENTITY(1, 1) NOT NULL ,
		[Name] [nvarchar](50) NULL ,
		[Description] [nvarchar](250) NULL ,
		[Status] NVARCHAR(50) ,
		[CreatedDate] [datetime] NULL ,
		[CreatedBy] [nvarchar](50) NULL ,
		[ModifiedDate] [datetime] NULL ,
		[ModifiedBy] [nvarchar](50) NULL ,
		PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 

GO

ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_Status]  DEFAULT ('Active') FOR [Status]
GO

CREATE NONCLUSTERED INDEX [IX_Role_NC] ON [dbo].[Role] 
(
[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO


SET IDENTITY_INSERT [Role] ON
INSERT  INTO Role( Id ,Name )VALUES  ( '1' ,  'Admin') 
INSERT  INTO Role( Id ,Name )VALUES  ( '2' ,  'Dev' ) 
INSERT  INTO Role( Id ,Name )VALUES  ( '3' ,  'Edit' ) 
INSERT  INTO Role( Id ,Name )VALUES  ( '4' ,  'Audit' ) 
INSERT  INTO Role( Id ,Name )VALUES  ( '5' ,  'Log' ) 
INSERT  INTO Role( Id ,Name )VALUES  ( '6' ,  'Approve' )
INSERT  INTO Role( Id ,Name )VALUES  ( '7' ,  'Report' ) 
SET IDENTITY_INSERT [Role] OFF 


-- RoleUser --
PRINT N' [RoleUser]'

CREATE TABLE [dbo].[RoleUser]
	(
		[Id] [int] IDENTITY(1, 1) NOT NULL ,
		[Name] [nvarchar](50) NULL ,
		[UserId] [int] NOT NULL ,
		[RoleId] [int] NOT NULL ,
		[Status] [nvarchar](50) NULL ,
		[CreatedDate] [datetime] NULL ,
		[CreatedBy] [nvarchar](50) NULL ,
		[ModifiedDate] [datetime] NULL ,
		[ModifiedBy] [nvarchar](50) NULL ,
		PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 

GO

ALTER TABLE [dbo].[RoleUser]  WITH CHECK ADD  CONSTRAINT [FK_Role_RoleUser] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO

ALTER TABLE [dbo].[RoleUser] CHECK CONSTRAINT [FK_Role_RoleUser]
GO

ALTER TABLE [dbo].[RoleUser]  WITH CHECK ADD  CONSTRAINT [FK_User_RoleUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO

ALTER TABLE [dbo].[RoleUser] CHECK CONSTRAINT [FK_User_RoleUser]
GO

ALTER TABLE [dbo].[RoleUser] ADD  CONSTRAINT [DF_RoleUser_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[RoleUser] ADD  CONSTRAINT [DF_RoleUser_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[RoleUser] ADD  CONSTRAINT [DF_RoleUser_Status]  DEFAULT ('Active') FOR [Status]
GO

INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '1', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '1', '1' )  
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '2', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '2', '1' )

--Nick is the UberMensch!
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '1' )  
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '3' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '4' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '5' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '6' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '3', '7' )   

INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '4', '2' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '4', '1' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '5', '2' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '5', '1' ) 
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '6', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '6', '1' ) 
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '7', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '7', '1' ) 
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '8', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '8', '1' ) 
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '9', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '9', '1' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '10', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '10', '1' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '11', '2' )   
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '11', '1' ) 
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '12', '2' )
INSERT  INTO RoleUser( UserId, RoleId ) VALUES(  '12', '1' ) 

--[AppLog]--
PRINT N' [AppLog]'

CREATE TABLE [dbo].[AppLog]
	(
		[Id] [int] IDENTITY(1, 1) NOT NULL ,
		[Name] [nvarchar](50) NULL ,
	  [Timestamp] [datetime] NULL ,
	  [Message] [nvarchar](MAX) NULL ,
	  [Description] [nvarchar](MAX) NULL ,
	  [Summary] [nvarchar](100) NULL ,
	  [Level] [nvarchar](16) NULL ,
	  [Logger] [nvarchar](128) NULL ,
	  [Status] [nvarchar](50) NULL ,
	  [IpAddress] [nvarchar](100) NULL ,
	  [Browser] [nvarchar](100) NULL ,
	  [Server] [nvarchar](100) NULL ,
	  [Session] [nvarchar](100) NULL ,
	  [UserName] [nvarchar](100) NULL ,
	  [UserId] [nvarchar](100) NULL ,
	  [Application] [nvarchar](100) NULL ,
	  [Type] [nvarchar](100) NULL ,
	  [CreatedDate] [datetime] NULL ,
	  [CreatedBy] [nvarchar](50) NULL ,
	  [ModifiedDate] [datetime] NULL ,
	  [ModifiedBy] [nvarchar](50) NULL ,
	  CONSTRAINT [PK_AppLog_ID] PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 

ALTER TABLE [dbo].[AppLog] ADD  CONSTRAINT [DF_AppLog_Timestamp]  DEFAULT (GETDATE()) FOR [Timestamp]
GO

ALTER TABLE [dbo].[AppLog] ADD  CONSTRAINT [DF_AppLog_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[AppLog] ADD  CONSTRAINT [DF_AppLog_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO

SET IDENTITY_INSERT [AppLog] ON

INSERT  INTO AppLog  ( [Id] ,[Name] ,[IpAddress] ,[Browser] ,[Server] ,[UserName] ,[Type] ,[Timestamp] ,[Description] ,[Level] )
VALUES  ( '1' ,'name' ,'127.0.0.1' ,'Firefox' ,'WCH' ,'tmctester' ,'Error' ,'1/1/2000' ,'message' ,'test') 

SET IDENTITY_INSERT [AppLog] OFF 





--[Internet]--
PRINT N' [Internet]'
IF EXISTS ( SELECT  *			FROM    sys.objects			WHERE   object_id = OBJECT_ID(N'[dbo].[Internet]')				AND type IN ( N'U' ) ) 	DROP TABLE [Internet]
 
CREATE TABLE [dbo].[Internet](
	[Id] INT NOT NULL IDENTITY PRIMARY KEY , 
	[Website] [nvarchar](150)   , 
	[Enviernement] [nvarchar](50)   , 
	[Ip] [nvarchar](50)   , 
	[NewIp] [nvarchar](50)   ,  
	[ServerIp] [nvarchar](50)   , 
	[SqlServer] [nvarchar](50)   , 
	[SqlDataBase] [nvarchar](50)   ,
	[NatAddress] [nvarchar](50)   , 
	  [Status] [nvarchar](50) NULL ,
	[CreatedDate] [datetime]   ,
	[CreatedBy] [nvarchar](50)   ,
	[ModifiedDate] [datetime]   ,
	[ModifiedBy] [nvarchar](50)    
	)
GO 

ALTER TABLE [dbo].[Internet] ADD  CONSTRAINT [DF_Internet_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO 

ALTER TABLE [dbo].[Internet] ADD  CONSTRAINT [DF_Internet_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO 

 
SET IDENTITY_INSERT [dbo].[Internet] ON
INSERT [dbo].[Internet] ([Id], [Website], [Enviernement], [Ip], [NewIp], [ServerIp], [SqlServer], [SqlDataBase], [NatAddress] ) VALUES (3, N'dev.abc.net', N'dev', N'143.54.12.43', N'143.54.12.43', N'143.54.12.128', N'db1dev', N'', N'143.54.12.43' )
INSERT [dbo].[Internet] ([Id], [Website], [Enviernement], [Ip], [NewIp], [ServerIp], [SqlServer], [SqlDataBase], [NatAddress] ) VALUES (4, N'dev.xyz.com', N'dev', N'143.54.12.83', N'143.54.12.83', N'143.54.12.128', N'db1dev', N'', N'143.54.12.83' )
SET IDENTITY_INSERT [dbo].[Internet] OFF 


 



 



--[Audit]--
PRINT N' [Audit]'

CREATE TABLE [dbo].[Audit](
	[Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	[Type] [char](1) NULL,
	[Application] [char](128) NULL,
	[Table] [varchar](128) NULL,
	[Name] [varchar](128) NULL,
	[PrimaryKeyFields] [varchar](300) NULL,
	[PrimaryKeyValues] [varchar](300) NULL,
	[UpdateDates] [datetime] NULL,
	[UserName] [varchar](128) NULL,
	[CreatedDate] [datetime] NULL ,
	[CreatedBy] [nvarchar](50) NULL ,
	[ModifiedDate] [datetime] NULL ,
	[ModifiedBy] [nvarchar](50) NULL  
	)
GO


--[AuditDetail]--
PRINT N' [AuditDetail]'

CREATE TABLE [dbo].[AuditDetail](
	[Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	[AuditId] [int] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[OldValue] [varchar](max) NULL,
	[NewValue] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL ,
	[CreatedBy] [nvarchar](50) NULL ,
	[ModifiedDate] [datetime] NULL ,
	[ModifiedBy] [nvarchar](50) NULL  
	)
GO 

ALTER TABLE [dbo].[AuditDetail] ADD  CONSTRAINT [DF_AuditDetail_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO 

ALTER TABLE [dbo].[AuditDetail] ADD  CONSTRAINT [DF_AuditDetail_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO 

ALTER TABLE AuditDetail ADD CONSTRAINT FK_Audit_AuditDetail FOREIGN KEY (AuditId) REFERENCES [Audit] (Id) 
GO 
 

-- ProjectProperty -- 
/****** Object:  Table [dbo].[ProjectProperty]    Script Date: 02/14/2011 12:57:12 ******/
SET ANSI_NULLS ON
GO 

SET QUOTED_IDENTIFIER ON
GO 

PRINT N' [ProjectProperty]'

CREATE TABLE [dbo].[ProjectProperty]
	(
	  [Id] [int] IDENTITY(1, 1) NOT NULL ,
	  [Name] [nvarchar](50) NULL ,
	  [Value] [nvarchar](200) NULL ,
	  [Status] [nvarchar](50) NULL ,
	  [CreatedDate] [datetime] NULL ,
	  [CreatedBy] [nvarchar](50) NULL ,
	  [ModifiedDate] [datetime] NULL ,
	  [ModifiedBy] [nvarchar](50) NULL ,
	  PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 
GO

ALTER TABLE [dbo].[ProjectProperty] ADD  CONSTRAINT [DF_ProjectProperty_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[ProjectProperty] ADD  CONSTRAINT [DF_ProjectProperty_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[ProjectProperty] ADD  CONSTRAINT [DF_ProjectProperty_Status]  DEFAULT ('Active') FOR [Status]
GO

CREATE NONCLUSTERED INDEX [IX_ProjectProperty_Name_Status_NC] ON [dbo].[ProjectProperty] 
(
[Name] ASC,
[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO

INSERT  INTO ProjectProperty (Name, Value)
VALUES  ( 'TimeZone', 'Eastern Standard Time' ),
		( 'StartDate', '12/1/2010' ),
		( 'EndDate', '' );

 
-- Media --
PRINT N' [Media]'

CREATE TABLE [dbo].[Media]
	(
	  [Id] [int] IDENTITY(1, 1) NOT NULL ,
	  [Name] [nvarchar](50) NULL ,
	  [Description] [nvarchar](500) NULL ,  
	  [Data] [varbinary](MAX) NULL ,
	  [Meta] [nvarchar](500) NULL ,
	  [FileName] [nvarchar](50) NULL ,
	  [FileType] [nvarchar](50) NULL ,
	  [FileSize] [int] NULL ,
	  [Status] [nvarchar](50) ,
	  [CreatedDate] [datetime] NULL ,
	  [CreatedBy] [nvarchar](50) NULL ,
	  [ModifiedDate] [datetime] NULL ,
	  [ModifiedBy] [nvarchar](50) NULL ,
	  PRIMARY KEY CLUSTERED ( [Id] ASC )
		WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
			   IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
			   ALLOW_PAGE_LOCKS = ON )
	) 
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Media_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Media_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Media_Status]  DEFAULT ('Active') FOR [Status]
GO

CREATE NONCLUSTERED INDEX [IX_Media_Name_NC] ON [dbo].[Media] 
(
[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO


/*
INSERT  INTO [Media] ( [Name] , [ModifiedDate] , [Data] , [FileName] , [FileType] , [FileSize] )
VALUES  ( 'a' , '2011-01-21 04:23:00' ,
		  0xFFD8FFE000104A46494600010101006000600000FFE100684578696600004D4D002A000000080004011A0005000000010000003E011B0005000000010000004601280003000000010002000001310002000000110000004E00000000000000600000000100000060000000015061696E742E4E45542076332E352E360000FFDB004300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDB004301FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00011080017001903012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F006D14515601451450014514500145145007FFD9 ,
		  '1.jpg' , 'image/jpeg' , 738 )
*/

-- Content --
PRINT N' [Content]'

CREATE TABLE Content
	(
	  [Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	  [Name] NVARCHAR(50) , 
	  [Description] NVARCHAR(MAX) ,
	  [Status] NVARCHAR(50) ,
	  [CreatedDate] DATETIME ,
	  [CreatedBy] NVARCHAR(50) ,
	  [ModifiedDate] DATETIME ,
	  [ModifiedBy] NVARCHAR(50)
	);

ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO 

ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO 

SET IDENTITY_INSERT Content ON
--INSERT  INTO Content ( ID, Name, [Status] )
--VALUES  ( 1, '1', 'HomePage', 'Active' )
SET IDENTITY_INSERT Content OFF  


-- ContentVersion --
PRINT N' [ContentVersion]'

CREATE TABLE ContentVersion
	(
	  [Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	  [ContentId] INT NOT NULL ,
	  [Name] NVARCHAR(50) ,
	  [Description] NVARCHAR(MAX) ,
	  [Priority] INT ,
	  [Status] NVARCHAR(50) ,
	  [CreatedDate] DATETIME ,
	  [CreatedBy] NVARCHAR(50) ,
	  [ModifiedDate] DATETIME ,
	  [ModifiedBy] NVARCHAR(50),
	  [ActiveDate] DATETIME ,
	  [ExpireDate] DATETIME
	) ;

ALTER TABLE [dbo].[ContentVersion] ADD  CONSTRAINT [DF_ContentVersion_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[ContentVersion] ADD  CONSTRAINT [DF_ContentVersion_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO

ALTER TABLE ContentVersion ADD CONSTRAINT FK_Content_ContentVersion FOREIGN KEY (ContentId) REFERENCES Content (Id)
 
--INSERT  INTO ContentVersion ( ContentId , [Description] , Priority , [Status] )
--VALUES  ( '1' , '<h1>asdfa</h1>' , '999999' , 'Active' )


-- Entry --
PRINT N' [Entry]'

CREATE TABLE Entry
	(
	  [Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	  [FirstName] NVARCHAR(50) ,
	  [LastName] NVARCHAR(50) ,
	  [Address1] NVARCHAR(100) ,
	  [Address2] NVARCHAR(100) ,
	  [City] NVARCHAR(50) ,
	  [State] NVARCHAR(2) ,
	  [Zip] NVARCHAR(10) ,
	  [Phone] NVARCHAR(15) ,
	  [Email] NVARCHAR(100) ,
	  [UniqueGuid] uniqueidentifier ,
	  [Status] NVARCHAR(50) ,
	  [CreatedDate] DATETIME ,
	  [CreatedBy] NVARCHAR(50) ,
	  [ModifiedDate] DATETIME ,
	  [ModifiedBy] NVARCHAR(50)
	);

ALTER TABLE [dbo].[Entry] ADD  CONSTRAINT [DF_Entry_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO 

ALTER TABLE [dbo].[Entry] ADD  CONSTRAINT [DF_Entry_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO 

ALTER TABLE [dbo].[Entry] ADD  CONSTRAINT [DF_Entry_UniqueGuid]  DEFAULT (NEWID()) FOR [UniqueGuid] ;
GO 

ALTER TABLE [dbo].[Entry] ADD  CONSTRAINT [DF_Entry_Status]  DEFAULT ('Active') FOR [Status]
GO
 
-- FAQ --
PRINT N' [Faq]'

CREATE TABLE Faq
	(
	  [Id] INT NOT NULL IDENTITY PRIMARY KEY ,
	  [Question] NVARCHAR(MAX) ,
	  [Answer] NVARCHAR(MAX) ,
	  [Status] NVARCHAR(50) ,
	  [CreatedDate] DATETIME ,
	  [CreatedBy] NVARCHAR(50) ,
	  [ModifiedDate] DATETIME ,
	  [ModifiedBy] NVARCHAR(50)
	);

ALTER TABLE [dbo].[Faq] ADD  CONSTRAINT [DF_Faq_ModifiedDate]  DEFAULT (GETDATE()) FOR [ModifiedDate]
GO 

ALTER TABLE [dbo].[Faq] ADD  CONSTRAINT [DF_Faq_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate] ;
GO

ALTER TABLE [dbo].[Faq] ADD  CONSTRAINT [DF_Faq_Status]  DEFAULT ('Active') FOR [Status]
GO
 
--INSERT  INTO Faq ( [Question] , [Answer] , [CreatedBy] )
--VALUES  ( 'What is your Quest?', 'I seek the Holy Grail', 'King Arthur (script)' )
  
PRINT '... Finished adding tables' 


PRINT 'Started adding views' 

/****** Object:  View [dbo].[vw_User]    Script Date: 03/11/2011 10:17:07 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Vw_UsersEnhanced]'))
DROP VIEW [dbo].[Vw_UsersEnhanced]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_User]'))
DROP VIEW [dbo].[vw_User]
GO

/****** Object:  View [dbo].[[vw_User]]    Script Date: 03/11/2011 10:17:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

PRINT N' [vw_User]'
GO

CREATE VIEW [dbo].[vw_User]
AS
--Select from local member table.
SELECT [Id]
		,[Name] as [UserName]
		,[Password]  
		,[Email] 
		,[FirstName]
		,[LastName]
		,[Status]
		,[ModifiedBy]  
		,[ModifiedDate]
--Roles
	,STUFF((select ', ' + r.Name  
from dbo.Role r 
	inner join dbo.RoleUser ru
	on r.Id = ru.RoleId
where ru.UserId = u.id and ru.Status = 'Active' and r.Status = 'Active'
	FOR XML PATH('')),1,1,'') as Roles 
	FROM [TigerWrestling].[dbo].[User] u

GO

PRINT '... Finished adding views' 

