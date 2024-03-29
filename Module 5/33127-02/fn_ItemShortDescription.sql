USE [Antiques]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemShortDescription]    Script Date: 26/07/2017 3:57:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.ItemID reference to return a ShortDescription based upon Material and Style of Item>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemShortDescription] 
(
	-- Add the parameters for the function here
	@ItemID INT
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemDescription varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SET @ItemDescription = (SELECT Materials.MaterialName + ' ' + Styles.StyleName
							FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
										JOIN Styles ON Items.StyleID = Styles.StyleID
							WHERE Items.ItemID = @ItemID)

	-- Return the result of the function
	RETURN @ItemDescription

END
