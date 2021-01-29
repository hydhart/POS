table 50008 "Store Weekly Target"
{
    Caption = 'Store Weekly Target';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Store No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Store."No.";
            ValidateTableRelation = true;
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
            trigger OnValidate()
            begin
                "Start Date" := DWY2DATE(1, Week, Year);
                "End Date" := DWY2Date(7, Week, Year);
            end;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
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