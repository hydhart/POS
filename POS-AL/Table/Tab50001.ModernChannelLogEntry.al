table 50001 "Modern Channel Log Entry"
{
    Caption = 'Modern Channel Log Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Channel ID"; Text[20])
        {
            Caption = 'Channel ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Store ID"; Text[20])
        {
            Caption = 'Store ID';
            DataClassification = ToBeClassified;
        }
        field(4; "POS ID"; Text[20])
        {
            Caption = 'POS ID';
            DataClassification = ToBeClassified;
        }
        field(5; "Cashier ID"; Text[20])
        {
            Caption = 'Cashier ID';
            DataClassification = ToBeClassified;
        }
        field(6; Signature; Text[50])
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
        }
        field(7; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Transaction Line No."; Integer)
        {
            Caption = 'Transaction Line No.';
            DataClassification = ToBeClassified;
        }
        field(9; Command; Enum "MC Command")
        {
            Caption = 'Command';
            DataClassification = ToBeClassified;
        }
        field(10; VType; Text[20])
        {
            Caption = 'VType';
            DataClassification = ToBeClassified;
        }
        field(11; "Subscriber ID"; Text[20])
        {
            Caption = 'Subscriber ID';
            DataClassification = ToBeClassified;
        }
        field(12; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
            DataClassification = ToBeClassified;
        }
        field(14; "Log Date"; Date)
        {
            Caption = 'Log Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Log Time"; Time)
        {
            Caption = 'Log Time';
            DataClassification = ToBeClassified;
        }
        field(16; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
        }
        field(17; "URL 2"; Text[250])
        {
            Caption = 'URL 2';
            DataClassification = ToBeClassified;
        }
        field(18; "Response Message"; Blob)
        {
            Caption = 'Response Message';
            DataClassification = ToBeClassified;
        }
        field(19; Handphone; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Status Message"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Nama Pelanggan"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        Key(SK1; Handphone) { }
    }

}
