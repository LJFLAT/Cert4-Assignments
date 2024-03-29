USE [Antiques]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemGender]    Script Date: 26/07/2017 3:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.Gender field to return the full Gender name relevant to the Item>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemGender]
(
	-- Add the parameters for the function here
	@ItemGender varchar(1)
)
RETURNS varchar(6)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @GenderName varchar(6)

	IF @ItemGender = 'M'
		SET @GenderName = 'Males'
	IF @ItemGender = 'W'
		SET @GenderName = 'Womens'

	-- This option might be used later if expanding range and requires a Unisex option.
	IF @ItemGender = 'U'
		SET @GenderName = 'Unisex'

	RETURN @GenderName

END
