page 50007 "Percentage Store Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SPS Percentage Store";

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
                    Caption = 'Group Comission Code';
                }
                field("Store Code"; "Store Code")
                {
                    ApplicationArea = All;
                    ;
                }
                field("Min Val"; "Min Val")
                {
                    ApplicationArea = All;
                }
                field("Max Val"; "Max Val")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Percentage)
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
                    Xmlport.Run(50005, false, true);
                end;
            }
        }
    }
}