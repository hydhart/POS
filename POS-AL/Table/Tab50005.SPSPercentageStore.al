table 50005 "SPS Percentage Store"
{
    Caption = 'SPS Percentage Store';
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
            TableRelation = Store."No.";
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
        field(5; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Inventory Posting Group", "Store Code", "Min Val", "Max Val")
        {
            Clustered = true;
        }
    }
}