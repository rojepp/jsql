
-- Enable Sql Clr on the server
EXEC sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

-- Avoid having to sign assemblies and worry about other security issues
-- TODO: Revisit this? Is it possible with F# to not set trustworthy?

-- Change DBName to your own.
ALTER DATABASE DBName SET TRUSTWORTHY ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JSExecute]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
    DROP FUNCTION [dbo].[JSExecute]
GO

IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'Jsql')
    DROP ASSEMBLY [JSql]
GO
IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'FSCore')
    DROP ASSEMBLY [FSCore]
GO

-- May need to adjust path to assemblies below
CREATE ASSEMBLY FSCore FROM 'C:\Program Files (x86)\Reference Assemblies\Microsoft\FSharp\2.0\Runtime\v2.0\FSharp.Core.dll' WITH PERMISSION_SET = UNSAFE
GO
CREATE ASSEMBLY JSql FROM 'D:\Robert\Dokument\Visual Studio 2010\Projects\JSql\JSql\bin\Debug\JSql.dll' WITH PERMISSION_SET = UNSAFE
GO

-- Adjust the length of inputs to your needs
CREATE FUNCTION [dbo].JSExecute(@a nvarchar(3000))
RETURNS nvarchar(100)
AS 
EXTERNAL NAME JSql.[JSql].[Execute]
GO

SELECT dbo.JSExecute('var a = 1; var b = 3; a + b;')
SELECT dbo.JSExecute('a + b;') -- Should error
