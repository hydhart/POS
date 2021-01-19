codeunit 50006 ADOFunction
{
    var
        SQLConn: DotNet SQLConnection;
        SQLCmd: DotNet SQLCommand;
        SQLReader: DotNet SQLDataReader;
        ConnStr: Text;
        SQLQuery: Text;
        SQLResultAsXML: Text;

    procedure RunSQLProcedure(): Text
    begin
        ConnStr := 'Server=FTAN\SQL2017Dev;Database=w1-ls-central-release-17-0-0-0;User Id=sa;Password=P@ssw0rd;'; // change connection parameters
        SQLQuery := '[dbo].[SPS_Calculate_Comission] ''2021-01-01'', ''2021-01-05'''; // change store procedure name

        SQLConn := SQLConn.SqlConnection();
        SQLConn.ConnectionString := ConnStr;
        SQLCmd := SQLCmd.SqlCommand(SQLQuery, SQLConn);
        SQLCmd.Connection.Open();
        SQLResultAsXML := FORMAT(SQLCmd.ExecuteNonQuery());
        SQLConn.Close();

        exit(SQLResultAsXML);
    end;
}