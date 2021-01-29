page 50010 "Store Weekly Target"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Store Weekly Target";

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

    var
        myInt: Integer;
}