table 50000 "Modern Channel Setup"
{
    Caption = 'PPOB Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
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
        field(4; PIN; Text[10])
        {
            Caption = 'PIN';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(5; "Secret Key"; Text[10])
        {
            Caption = 'Secret Key';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(6; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(7; Path; Text[250])
        {
            Caption = 'Log File Path';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}
