table 50008 "Store Weekly Target"
{
    Caption = 'Store Weekly Target';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Store No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Week"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 52;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Target Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Store No.", Year, Week)
        {
            Clustered = true;
        }
    }
}