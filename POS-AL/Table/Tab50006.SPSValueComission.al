table 50006 "SPS Value Comission"
{
    Caption = 'SPS Value Comission';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Inventory Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
            ValidateTableRelation = true;
        }
        field(2; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
            ValidateTableRelation = true;
        }
        field(3; "Min Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Max Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Comission; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Inventory Posting Group", "Item Category Code", "Min Val", "Max Val")
        {
            Clustered = true;
        }
    }
}