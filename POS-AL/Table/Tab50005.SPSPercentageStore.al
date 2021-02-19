table 50005 "SPS Percentage Store"
{
    Caption = 'SPS Percentage Store';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Inventory Posting Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Group Comission Code';
        }
        field(3; "Store Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Store."No.";
            ValidateTableRelation = true;
        }
        field(4; "Min Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Max Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Inventory Posting Group", "Store Code", "Min Val", "Max Val", "Start Date")
        {
            Clustered = true;
        }
    }
}