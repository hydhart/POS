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
        ConnStr := 'Server=FTAN\SQL2017Dev;Database=Demo Database NAV (16-0);User Id=sa;Password=Pa$$w0rd;'; // change connection parameters
        SQLQuery := '[dbo].[sp_insertTestTable]'; // change store procedure name

        SQLConn := SQLConn.SqlConnection();
        SQLConn.ConnectionString := ConnStr;
        SQLCmd := SQLCmd.SqlCommand(SQLQuery, SQLConn);
        SQLCmd.Connection.Open();
        SQLResultAsXML := FORMAT(SQLCmd.ExecuteNonQuery());
        SQLConn.Close();

        exit(SQLResultAsXML);
    end;
}