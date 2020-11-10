table 50000 "Modern Channel Setup"
{
    Caption = 'Modern Channel Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Channel ID"; Code[20])
        {
            Caption = 'Channel ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Store ID"; Code[20])
        {
            Caption = 'Store ID';
            DataClassification = ToBeClassified;
        }
        field(3; PIN; Text[10])
        {
            Caption = 'PIN';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(4; "Secret Key"; Text[10])
        {
            Caption = 'Secret Key';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(5; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(6; Path; Text[250])
        {
            Caption = 'Log File Path';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Channel ID", "Store ID")
        {
            Clustered = true;
        }
    }

}
