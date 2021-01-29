report 50003 "Sales Analyze"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50003.SalesAnalyze.rdlc';
    dataset
    {
        dataitem(Store; Store)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(No_Store; "No.") { }
            column(Name_Store; Name) { }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);

                trigger OnPreDataItem()
                begin
                    tempData.Reset();
                    SetRange(Number, 1, tempData.Count);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        tempData.FindFirst()
                    else
                        tempData.Next();
                end;
            }

            trigger OnAfterGetRecord()
            begin

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var
        tempData: Record "Trans. Sales Entry" temporary;
}
