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
        field(50001; "Item Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(50002; "Inventory Posting Group"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Inventory Posting Group" where("No." = field("Item No.")));
        }
    }

    var
        myInt: Integer;
}