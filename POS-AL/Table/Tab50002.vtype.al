table 50002 vtype
{
    Caption = 'vtype';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Type; enum "MC Item Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Type, Code)
        {
            Clustered = true;
        }
    }

}
