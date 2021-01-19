page 50008 "Value Comission Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SPS Value Comission";

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
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Min Val"; "Min Val")
                {
                    ApplicationArea = All;
                }
                field("Max Val"; "Max Val")
                {
                    ApplicationArea = All;
                }
                field(Comission; Comission)
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
                begin
                    Message('Import');
                end;
            }
        }
    }

    var
        myInt: Integer;
}