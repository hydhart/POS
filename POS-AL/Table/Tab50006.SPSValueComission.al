table 50006 "SPS Value Comission"
{
    Caption = 'SPS Value Comission';
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
            TableRelation = "Inventory Posting Group".Code;
        }
        field(3; "Item Family Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Family".Code;
            ValidateTableRelation = true;
        }
        field(4; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
            ValidateTableRelation = true;
        }
        field(5; "Item No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            ValidateTableRelation = true;
        }
        field(6; "Min Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Comission; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Start Date", "Inventory Posting Group", "Item Family Code", "Item Category Code", "Item No", "Min Val", "Max Val")
        {
            Clustered = true;
        }
    }
}