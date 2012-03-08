JSql
----

JSql is probably an idiotic attempt at running Javascript inside of Sql Server 2005/2008, through the use of Fredrik Holms [IronJS][IronJS].
If you run this, I make no guarantees on your software, hardware or anything else. 

Code is in F# with a dependency on IronJS (included in the repo).


## Functions

#### JSExecute
Executes the JavaScript nvarchar sent in and returns the output of that as a string. Should probably figure out some other way to marshall values between JS and Sql.

    SELECT dbo.JSExecute('1 + 2;') --> returns '3'
    SELECT dbo.JSExecute('var a = 1; var b = 2; a + b;') --> returns '3'



## Installing
Edit 'Configure.sql' before executing it on the Sql Server. You'll need to edit the paths to 'FSharp.Core.dll' and 'JSql.dll'. You may also need to adjust parameter lengths for the functions to suit your string matching needs. The files need to be on the actual server. 

[IronJS]: https://github.com/fholm/IronJS
