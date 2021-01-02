tableextension 50007 ItemLedgerEntryExt extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Item Family Code"; Code[10])
        {
            Caption = 'Item Family Code';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}