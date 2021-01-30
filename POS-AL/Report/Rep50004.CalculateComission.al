report 50004 "Calculate Comission"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        ADO: Codeunit ADOFunction;
    begin
        Message(ADO.RunSQLProcedure(StartDate, EndDate));
    end;

    var
        StartDate: Date;
        EndDate: Date;
}