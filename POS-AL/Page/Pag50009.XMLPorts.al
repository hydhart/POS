page 50009 "XML Ports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Object;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ObjectID; ID)
                {
                    ApplicationArea = All;

                }
                field(ObjectName; Name)
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
            action(MemberAccount)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50000, false, true);
                end;
            }
            action(MemberContact)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50001, false, true);
                end;
            }
            action(MembershipCard)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50002, false, true);
                end;
            }
            action(MemberPointJournal)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50003, false, true);
                end;
            }
        }
    }

    var
        myInt: Integer;
}