page 50010 "History Sales"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SPS History Sales";
    //Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order ID"; "Order ID")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Line Nbr"; "Line Nbr")
                {
                    ApplicationArea = All;
                }
                field("SPG Code"; "SPG Code")
                {
                    ApplicationArea = All;
                }
                field("Store Code"; "Store Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; "Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Item No"; "Item No")
                {
                    ApplicationArea = All;
                }
                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field(Percentage; Percentage)
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
            action("Calculate Comission")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    Report.RunModal(50004, true, false);
                    CurrPage.Update(false);
                    SetRange("Order ID");
                    if FindFirst() then;
                    */
                end;
            }
            action("Report History Sales")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Report.RunModal(50005, true, false);
                end;
            }
            action("Report Summary Sales")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Report.RunModal(50006, true, false);
                end;
            }
            action("Report Comission")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Report.RunModal(50007, true, false);
                end;
            }
        }
    }
}