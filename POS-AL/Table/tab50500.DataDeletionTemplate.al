table 50500 "Data Deletion Template"
{
    DataClassification = ToBeClassified;
    Caption = 'Data Deletion Template';
    fields
    {
        field(1; Name; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Template Name';
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Template Description';
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}