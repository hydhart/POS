tableextension 50008 "Store Ext" extends Store
{
    fields
    {
        field(50000; "Channel ID"; Text[20])
        {
            Caption = 'Channel ID';
            DataClassification = ToBeClassified;
        }
        field(50001; "Store ID"; Text[20])
        {
            Caption = 'Store ID';
            DataClassification = ToBeClassified;
        }
        field(50002; PIN; Text[10])
        {
            Caption = 'PIN';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(50003; "Secret Key"; Text[10])
        {
            Caption = 'Secret Key';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(50004; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
    }
}
