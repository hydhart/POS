dotnet
{
    assembly(System.Data)
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        type(System.Data.DataSet; SQLDataSet) { }
        type(System.Data.SqlClient.SqlDataAdapter; SQLDataAdapter) { }
        type(System.Data.SqlClient.SqlConnection; SQLConnection) { }
        type(System.Data.SqlClient.SqlCommand; SQLCommand) { }
        type(System.Data.SqlClient.SqlDataReader; SQLDataReader) { }
    }
}