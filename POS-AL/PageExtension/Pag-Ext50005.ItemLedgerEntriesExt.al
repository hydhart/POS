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
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("Retail Product Code"; Rec."Retail Product Code")
            {
                ApplicationArea = All;
            }
        }
    }
}