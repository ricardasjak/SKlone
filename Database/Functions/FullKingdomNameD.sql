﻿/****** Object:  User Defined Function dbo.FullKingdomNameD    Script Date: 5/1/2004 6:12:45 PM ******/
CREATE FUNCTION dbo.FullKingdomNameD
	(
		@kdID int
	)
RETURNS nvarchar(100)
BEGIN
	DECLARE @Name nvarchar(100)
	SET @Name = (SELECT [Name] FROM Kingdoms WHERE kdID = @kdID)
	IF @Name IS NULL
	BEGIN
		SET @Name = 'Nobody'
	END
	ELSE
	BEGIN
		IF dbo.GetSL((SELECT SectorID FROM Kingdoms WHERE kdID = @kdID)) = @kdID 
		BEGIN
			SET @Name = @Name + (SELECT ' (' + CAST(Sectors.Galaxy AS nvarchar(2)) + ':' + CAST(Sectors.Sector AS nvarchar(2)) + ')' FROM Kingdoms, Sectors WHERE Kingdoms.kdID = @kdID AND Sectors.SectorID = Kingdoms.SectorID)
			SET @Name = '<a href=Profile.aspx?KingdomID=' + CAST(@kdID AS nvarchar(8)) + ' style="color: #FFFFFF;"><i>' + @Name + '</i></a>'
		END
		ELSE
		BEGIN
		SET @Name = @Name + (SELECT ' (' + CAST(Sectors.Galaxy AS nvarchar(2)) + ':' + CAST(Sectors.Sector AS nvarchar(2)) + ')' FROM Kingdoms, Sectors WHERE Kingdoms.kdID = @kdID AND Sectors.SectorID = Kingdoms.SectorID)
		SET @Name = '<a href=Profile.aspx?KingdomID=' + CAST(@kdID AS nvarchar(8)) + ' style="color: #FFFFFF;">' + @Name + '</a>'
		END
		
	END
	RETURN(@Name)
END
