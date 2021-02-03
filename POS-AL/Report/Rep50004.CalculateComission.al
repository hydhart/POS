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
                        trigger OnValidate()
                        begin
                            if StartDate = 0D then
                                StartDate := EndDate
                            else begin
                                if StartDate > EndDate then
                                    Message('End Date should be more advance than Start Date!');
                            end;
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if StartDate = 0D then
                                StartDate := EndDate
                            else begin
                                if StartDate > EndDate then
                                    Message('End Date should be more advance than Start Date!');
                            end;
                        end;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        ADO: Codeunit ADOFunction;
    begin
        if StartDate <= EndDate then
            Message(ADO.RunSQLProcedure(StartDate, EndDate));
    end;

    var
        StartDate: Date;
        EndDate: Date;
}