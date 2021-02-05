table 50004 "SPS Target Store"
{
    Caption = 'SPS Target Store';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Inventory Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Store Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Store."No.";
            ValidateTableRelation = true;
        }
        field(4; "Item Family Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Family";
            ValidateTableRelation = true;
        }
        field(5; Mode; Enum "Target Mode")
        {
            DataClassification = ToBeClassified;
        }
        field(6; Target; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Start Date", "Inventory Posting Group", "Store Code", "Item Family Code")
        {
            Clustered = true;
        }
    }
}