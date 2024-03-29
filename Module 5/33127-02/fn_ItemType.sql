USE [Antiques]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemType]    Script Date: 26/07/2017 4:03:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.ItemID reference to return the Full Gender description along with the Group the Item belongs to>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemType]
(
	-- Add the parameters for the function here
	@ItemID int
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemType varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SET @ItemType = (SELECT (dbo.fn_ItemGender(Items.Gender) + ' ' + Groups.GroupName)
					FROM Items JOIN Groups ON Items.GroupID = Groups.GroupID
					WHERE Items.ItemID = @ItemID)

	-- Return the result of the function
	RETURN @ItemType

END
