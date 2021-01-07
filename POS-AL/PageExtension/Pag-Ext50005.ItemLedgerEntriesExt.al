pageextension 50005 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item Family Code"; "Item Family Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}