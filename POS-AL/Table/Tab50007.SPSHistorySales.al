table 50007 "SPS History Sales"
{
    Caption = 'SPS History Sales';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line Nbr"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "SPG Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Staff.ID;
        }
        field(4; "Store Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Store."No.";
        }
        field(5; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(8; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Comission; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
        field(14; "Qty Target Store"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Serial No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Mode; Enum "Target Mode")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Order ID", "Line Nbr")
        {
            Clustered = true;
        }
        key(SecondKey; "Store Code", "SPG Code", "Order Date")
        {
        }
    }
}