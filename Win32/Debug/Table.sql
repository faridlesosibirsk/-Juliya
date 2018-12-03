USE [Тест0]

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

CREATE TABLE [dbo].[AddFiles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [char](28) NOT NULL,
	[DateChange] [smalldatetime] NOT NULL,
	[Lines] [int] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING OFF

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

CREATE TABLE [dbo].[Call_records](
	[№] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](0) NOT NULL,
	[duration] [int] NOT NULL,
	[statuscall] [char](9) NOT NULL,
	[typecall] [char](9) NULL,
	[code] [int] NULL,
	[citynumber] [varchar](17) NOT NULL,
	[insidenumber] [bigint] NULL,
	[id] [int] NULL,
	[trunkid1] [int] NULL,
	[trunkid2] [int] NULL,
	[trunkid3] [int] NULL
) ON [PRIMARY]

SET ANSI_PADDING OFF
