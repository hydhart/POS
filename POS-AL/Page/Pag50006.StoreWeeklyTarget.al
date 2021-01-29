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
        area(Content)
        {
            repeater(WeeklyTarget)
            {
                field("Store No."; "Store No.")
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field(Week; Week)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Target Sales"; "Target Sales")
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
