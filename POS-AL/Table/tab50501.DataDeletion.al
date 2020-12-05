table 50501 "Data Deletion"
{
    DataClassification = ToBeClassified;
    Caption = 'Data Deletion';

    fields
    {
        field(1; "Company Name"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Name';
        }
        field(2; "Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Template Name';
            TableRelation = "Data Deletion Template".Name;
        }
        field(3; "Table No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Table No.';
        }
        field(4; "Table Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Table Name';
        }
        field(5; "No. of Records"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. of Records';
            //FieldClass = FlowField;
            //CalcFormula = lookup("Table Information"."No. of Records" where("Company Name" = field("Company Name"), "Table No." = field("Table No.")));
        }
        field(6; "Delete Data"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Delete Data';
        }
        field(7; "Filters"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Record Filters';
        }
    }

    keys
    {
        key(PK; "Company Name", "Template Name", "Table No.")
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