USE [Restaurant]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 2019/11/30 00:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[TableId] [int] NOT NULL,
	[WaiterId] [int] NOT NULL,
	[PurchaseDate] [datetime] NOT NULL,
	[Settled] [bit] NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [decimal](18, 6) NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](150) NULL,
	[LastName] [nvarchar](150) NULL,
	[CellNumber] [nvarchar](150) NULL,
	[Time] [datetime] NULL,
	[TableId] [int] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[TableId] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NOT NULL,
	[WaiterId] [int] NULL,
	[IsOpen] [bit] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[TableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Waiter]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Waiter](
	[WaiterId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](150) NULL,
	[LastName] [nvarchar](150) NULL,
	[Login] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Waiter] PRIMARY KEY CLUSTERED 
(
	[WaiterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (1, N'Chargrilled Rump', N'Juicy and perfectly prepared.', CAST(125.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (2, N'New York Sirloin', N'The tastiest cut of beef.', CAST(147.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (3, N'Fillet', N'Still the most tender cut of all!', CAST(167.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (4, N'Cheddamelt Steak', N'Rump or Sirloin topped with a slice of melted cheese and pepper or creamy mushroom sauce.', CAST(165.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (5, N'Portuguese Steak', N'Tender Rump or Sirloin topped with Peri-Peri sauce and a fried egg.', CAST(140.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (6, N'Lazy Aged Steak', N'Prime cut of rump, extra matured.', CAST(200.000000 AS Decimal(18, 6)))
INSERT [dbo].[Items] ([ItemId], [Name], [Description], [Price]) VALUES (7, N'T-Bone Steak', N'Generous in size and taste.', CAST(152.900000 AS Decimal(18, 6)))
SET IDENTITY_INSERT [dbo].[Items] OFF
SET IDENTITY_INSERT [dbo].[Tables] ON 

INSERT [dbo].[Tables] ([TableId], [TableNumber], [WaiterId], [IsOpen]) VALUES (1, 1, NULL, 0)
INSERT [dbo].[Tables] ([TableId], [TableNumber], [WaiterId], [IsOpen]) VALUES (2, 2, NULL, 0)
INSERT [dbo].[Tables] ([TableId], [TableNumber], [WaiterId], [IsOpen]) VALUES (3, 3, NULL, 0)
INSERT [dbo].[Tables] ([TableId], [TableNumber], [WaiterId], [IsOpen]) VALUES (4, 4, NULL, 0)
INSERT [dbo].[Tables] ([TableId], [TableNumber], [WaiterId], [IsOpen]) VALUES (5, 5, NULL, 0)
SET IDENTITY_INSERT [dbo].[Tables] OFF
SET IDENTITY_INSERT [dbo].[Waiter] ON 

INSERT [dbo].[Waiter] ([WaiterId], [FirstName], [LastName], [Login], [Password]) VALUES (2, N'Ainsley', N'Roth', N'ainsley_roth', N'Password1')
INSERT [dbo].[Waiter] ([WaiterId], [FirstName], [LastName], [Login], [Password]) VALUES (3, N'Bill', N'Addams', N'bill_addams', N'Password2')
SET IDENTITY_INSERT [dbo].[Waiter] OFF
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_Settelled]  DEFAULT ((0)) FOR [Settled]
GO
ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_IsOpen]  DEFAULT ((0)) FOR [IsOpen]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Items] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([ItemId])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Items]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Tables] FOREIGN KEY([TableId])
REFERENCES [dbo].[Tables] ([TableId])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Tables]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Waiter] FOREIGN KEY([WaiterId])
REFERENCES [dbo].[Waiter] ([WaiterId])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Waiter]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Tables] FOREIGN KEY([TableId])
REFERENCES [dbo].[Tables] ([TableId])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Tables]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Waiter] FOREIGN KEY([WaiterId])
REFERENCES [dbo].[Waiter] ([WaiterId])
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Waiter]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBillByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBillByID] 
	-- Add the parameters for the stored procedure here
	@BillId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Bill WHERE BillId = @BillId
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteByItemsID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteByItemsID] 
	-- Add the parameters for the stored procedure here
	@Items		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Items WHERE ItemId = @Items
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteReservationByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteReservationByID]
	-- Add the parameters for the stored procedure here
	@ReservationId		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Reservations WHERE ReservationId = @ReservationId
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteTableByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTableByID] 
	-- Add the parameters for the stored procedure here
	@TableId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE [Tables] WHERE TableId = @TableId 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteWaiterByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteWaiterByID] 
	-- Add the parameters for the stored procedure here
	@WaiterId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Waiter WHERE WaiterId = @WaiterId 
END
GO
/****** Object:  StoredProcedure [dbo].[GetBillByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetBillByID] 
	-- Add the parameters for the stored procedure here
	@BillId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Bill WHERE BillId = @BillId
END
GO
/****** Object:  StoredProcedure [dbo].[GetItemsByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetItemsByID] 
	-- Add the parameters for the stored procedure here
	@Items		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Items WHERE ItemId = @Items
END
GO
/****** Object:  StoredProcedure [dbo].[GetReservationByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReservationByID] 
	-- Add the parameters for the stored procedure here
	@ReservationId		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Reservations WHERE ReservationId = @ReservationId
END
GO
/****** Object:  StoredProcedure [dbo].[GetTableByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTableByID] 
	-- Add the parameters for the stored procedure here
	@TableId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [Tables] WHERE TableId = @TableId
END
GO
/****** Object:  StoredProcedure [dbo].[GetTableItems]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTableItems]
	-- Add the parameters for the stored procedure here
	@WaiterId		INT,
	@TableId		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * fROM Items I
	INNER JOIN Bill B ON B.ItemId = I.ItemId
	WHERE B.WaiterId = @WaiterId AND B.TableId = @TableId AND B.Settled = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetTablesAvailableToWaiter]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTablesAvailableToWaiter] 
	-- Add the parameters for the stored procedure here
	@WaiterId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Tables T WHERE IsOpen = 0 OR WaiterId IS NULL OR WaiterId = @WaiterId
END
GO
/****** Object:  StoredProcedure [dbo].[GetWaiterByID]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWaiterByID] 
	-- Add the parameters for the stored procedure here
	@WaiterId		INT		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Waiter WHERE WaiterId = @WaiterId
END
GO
/****** Object:  StoredProcedure [dbo].[GetWaiterByUsernameAndPassword]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWaiterByUsernameAndPassword]
	-- Add the parameters for the stored procedure here
	@Username NVARCHAR(100),
	@Password NVARCHAR(100)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Waiter WHERE Login = @Username AND Password = @Password

END
GO
/****** Object:  StoredProcedure [dbo].[InsertBill]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertBill] 
	-- Add the parameters for the stored procedure here
	@ItemId			INT,
	@TableId		INT,
	@WaiterId		INT,
	@PurchaseDate	DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Bill(ItemId, TableId, WaiterId, PurchaseDate)
	VALUES (@ItemId, @TableId, @WaiterId, @PurchaseDate)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertItems]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertItems] 
	-- Add the parameters for the stored procedure here
	@Name			NVARCHAR(150),
	@Description	NVARCHAR(MAX),
	@Price			DECIMAL(18,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Items([Name], [Description], Price)
	VALUES (@Name, @Description, @Price)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertReservation]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertReservation] 
	-- Add the parameters for the stored procedure here
	@FirstName			NVARCHAR(150),
	@LastName			NVARCHAR(150),
	@CellNumber			NVARCHAR(150),
	@Date				DATETIME,
	@TableId			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Reservations(FirstName, LastName, CellNumber, [Time], TableId)
	VALUES(@FirstName, @LastName, @CellNumber, @Date, @TableId)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertTables]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTables] 
	-- Add the parameters for the stored procedure here
	@TableNumber		INT,
	@WaiterId			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Tables (TableNumber, WaiterId)
	VALUES (@TableNumber, @WaiterId)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertWaiter]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertWaiter] 
	-- Add the parameters for the stored procedure here
	@FirstName		NVARCHAR(150),
	@LastName		NVARCHAR(150),
	@Login			NVARCHAR(150),
	@Password		NVARCHAR(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Waiter(FirstName, LastName, [Login], Password)
	VALUES (@FirstName, @LastName, @Login, @Password)
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllFromBill]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFromBill]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Bill
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllFromItems]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFromItems] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Items
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllFromReservations]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFromReservations] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Reservations
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllFromTables]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFromTables] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [Tables]
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllFromWaiter]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFromWaiter] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Waiter
END
GO
/****** Object:  StoredProcedure [dbo].[SettleBill]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SettleBill]
	-- Add the parameters for the stored procedure here
	@TableId		INT,
	@WaiterId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Bill
	SET Settled = 1
	WHERE TableId = @TableId AND WaiterId = @WaiterId AND Settled = 0
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBill]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateBill] 
	-- Add the parameters for the stored procedure here
	@BillId			INT,
	@ItemId			INT,
	@TableId		INT,
	@WaiterId		INT,
	@PurchaseDate	DATETIME,
	@Settled		BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Bill

	SET ItemId	= @ItemId,
		TableId	= @TableId,
		WaiterId = @WaiterId,
		PurchaseDate = @PurchaseDate,
		Settled = @Settled
	WHERE BillId = @BillId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateItems]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateItems] 
	-- Add the parameters for the stored procedure here
	@ItemsId		INT,
	@Name			NVARCHAR(150),
	@Description	NVARCHAR(MAX),
	@Price			DECIMAL(18,0)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Items

	SET		[Name]			= @Name,
			[Description]	= @Description,
			Price			= @Price

	WHERE ItemId = @ItemsId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateReservation]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateReservation] 
	-- Add the parameters for the stored procedure here
	@ReservationId		INT,
	@FirstName			NVARCHAR(150),
	@LastName			NVARCHAR(150),
	@CellNumber			NVARCHAR(150),
	@Time				DATETIME,
	@TableId			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Reservations
	SET FirstName	= @FirstName,
		LastName	= @LastName,
		CellNumber	= @CellNumber,
		[Time]		= @Time,
		TableId		= @TableId
	WHERE ReservationId = @ReservationId	 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateTable]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateTable] 
	-- Add the parameters for the stored procedure here
	@TableId		INT,
	@TableNumber	INT,
	@WaiterId		INT NULL,
	@IsOpen			BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE  [Tables]

	SET		
			TableNumber	 = @TableNumber,
			WaiterId	 = @WaiterId,
			IsOpen		 = @IsOpen

	WHERE TableId = @TableId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateWaiter]    Script Date: 2019/11/30 00:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateWaiter] 
	-- Add the parameters for the stored procedure here
	@WaiterId		INT,
	@FirstName		NVARCHAR(150),
	@LastName		NVARCHAR(150),
	@Login			NVARCHAR(150),
	@Password		NVARCHAR(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Waiter

	SET		
			FirstName	= @FirstName,
			LastName	= @LastName,
			[Login]		= @Login,
			[Password]	= @Password
			
	WHERE	WaiterId	= @WaiterId	
END
GO
