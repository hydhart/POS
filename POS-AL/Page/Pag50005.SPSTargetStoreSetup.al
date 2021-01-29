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
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Store Code"; "Store Code")
                {
                    ApplicationArea = All;
                }
                field("Item Family Code"; "Item Family Code")
                {
                    ApplicationArea = All;
                }
                field(Mode; Mode)
                {
                    ApplicationArea = All;
                }
                field(Target; Target)
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
                    Xmlport.Run(50004, false, true);
                    //Message(ADO.RunSQLProcedure());
                end;
            }
        }
    }

    var
        myInt: Integer;
}