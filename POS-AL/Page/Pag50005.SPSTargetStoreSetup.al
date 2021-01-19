page 50005 "Target Store Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SPS Target Store";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Store Code"; "Store Code")
                {
                    ApplicationArea = All;
                }
                field("Target Qty"; "Target Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ADO: Codeunit ADOFunction;
                begin
                    //Message(ADO.RunSQLProcedure());
                    Message('Import');
                end;
            }
        }
    }

    var
        myInt: Integer;
}