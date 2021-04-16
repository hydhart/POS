pageextension 50010 "Service Order Ext" extends "Service Order"
{
    layout
    {
        addafter("Contact No.")
        {
            field(IProtech; IProtech)
            {
                Caption = 'I Pro Tech';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}