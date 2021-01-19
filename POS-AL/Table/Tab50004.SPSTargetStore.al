table 50004 "SPS Target Store"
{
    Caption = 'SPS Target Store';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Inventory Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
            ValidateTableRelation = true;
        }
        field(2; "Store Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Store;
            ValidateTableRelation = true;
        }
        field(3; "Target Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Inventory Posting Group", "Store Code")
        {
            Clustered = true;
        }
    }
}