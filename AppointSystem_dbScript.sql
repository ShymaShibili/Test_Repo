USE [master]
GO
/****** Object:  Database [AppointmentSystem]    Script Date: 03-08-2020 09:03:52 ******/
CREATE DATABASE [AppointmentSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AppointmentSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AppointmentSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AppointmentSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AppointmentSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AppointmentSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AppointmentSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AppointmentSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AppointmentSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AppointmentSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AppointmentSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AppointmentSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [AppointmentSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AppointmentSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AppointmentSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AppointmentSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AppointmentSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AppointmentSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AppointmentSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AppointmentSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AppointmentSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AppointmentSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AppointmentSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AppointmentSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AppointmentSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AppointmentSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AppointmentSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AppointmentSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AppointmentSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AppointmentSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AppointmentSystem] SET  MULTI_USER 
GO
ALTER DATABASE [AppointmentSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AppointmentSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AppointmentSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AppointmentSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AppointmentSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AppointmentSystem] SET QUERY_STORE = OFF
GO
USE [AppointmentSystem]
GO
/****** Object:  Table [dbo].[tblAppointments]    Script Date: 03-08-2020 09:03:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAppointments](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[AppointmentStartTime] [datetime] NULL,
	[AppointmentEndTime] [datetime] NULL,
	[Title] [nvarchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_tblAppointments] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteAppointment]    Script Date: 03-08-2020 09:03:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAppointment]
@AppointmentId INT

AS
DELETE FROM tblAppointments WHERE AppointmentId=@AppointmentId
GO
/****** Object:  StoredProcedure [dbo].[InsertAppointments]    Script Date: 03-08-2020 09:03:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAppointments]
@Name NVARCHAR(150),
@Email NVARCHAR(150),
@AppointmentTime DATETIME,
@Title NVARCHAR(250)
AS
 
DECLARE @AppointmentEndTime DATETIME=(SELECT DATEADD(MINUTE,30,@AppointmentTime))

IF((SELECT COUNT(*)FROM tblAppointments WHERE
   (CONVERT(time,AppointmentStartTime) < CONVERT(time,AppointmentEndTime) 
	AND CONVERT(time,@AppointmentTime) BETWEEN CONVERT(time,AppointmentStartTime) AND CONVERT(time,(SELECT DATEADD(MINUTE,-1,AppointmentEndTime)))
	AND CONVERT(date,AppointmentStartTime) = CONVERT(date,@AppointmentTime)))=0)
 
 BEGIN
	INSERT INTO tblAppointments (Name,Email,AppointmentStartTime,AppointmentEndTime,Title,CreatedDate,ActiveFlag) 
	VALUES(@Name,@Email,@AppointmentTime,@AppointmentEndTime,@Title,GETDATE(),1)
END
GO
/****** Object:  StoredProcedure [dbo].[ReadAppointmentDetails]    Script Date: 03-08-2020 09:03:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadAppointmentDetails]
@AppointmentId INT

AS
SELECT * FROM tblAppointments WHERE AppointmentId=@AppointmentId AND ActiveFlag=1
GO
/****** Object:  StoredProcedure [dbo].[SelectAllAppointments]    Script Date: 03-08-2020 09:03:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllAppointments]
AS

SELECT * FROM tblAppointments WHERE ActiveFlag=1
GO
USE [master]
GO
ALTER DATABASE [AppointmentSystem] SET  READ_WRITE 
GO
