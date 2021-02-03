codeunit 50006 ADOFunction
{
    var
        SQLConn: DotNet SQLConnection;
        SQLCmd: DotNet SQLCommand;
        SQLReader: DotNet SQLDataReader;
        ConnStr: Text;
        SQLQuery: Text;
        SQLResultAsXML: Text;

    procedure RunSQLProcedure(StartDate: Date; EndDate: Date): Text
    var
        DateFormat: Text;
    begin
        DateFormat := '<Year4>-<Month,2>-<Day,2>';
        ConnStr := 'Server=FTAN\SQL2017Dev;Database=w1-ls-central-release-17-0-0-0;User Id=sa;Password=P@ssw0rd;'; // change connection parameters
        SQLQuery := StrSubstNo('[dbo].[SPS_Calculate_Comission] ''%1'', ''%2''', Format(StartDate, 0, DateFormat), Format(EndDate, 0, DateFormat)); // change store procedure name

        SQLConn := SQLConn.SqlConnection();
        SQLConn.ConnectionString := ConnStr;
        SQLCmd := SQLCmd.SqlCommand(SQLQuery, SQLConn);
        SQLCmd.Connection.Open();
        SQLResultAsXML := FORMAT(SQLCmd.ExecuteNonQuery());
        SQLConn.Close();

        Commit();

        exit(SQLResultAsXML);
    end;
}