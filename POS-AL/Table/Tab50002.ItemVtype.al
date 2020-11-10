table 50002 "Item Vtype"
{
    Caption = 'Item Vtype';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.") then
                    Description := Item.Description
                else
                    Description := '';
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; vtype; Text[10])
        {
            Caption = 'vtype';
            DataClassification = ToBeClassified;
        }
        field(4; "vtype Description"; Text[50])
        {
            Caption = 'vtype Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }

}
