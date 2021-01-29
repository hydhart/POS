page 50006 "Store Weekly Target"
{
    ApplicationArea = All;
    Caption = 'Store Weekly Target';
    PageType = List;
    SourceTable = "Store Weekly Target";
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Target Sales"; Rec."Target Sales")
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
                    Xmlport.Run(50007, false, true);
                end;
            }
        }
    }
}
