tableextension 50004 "Retail Setup Ext" extends "Retail Setup"
{
    fields
    {
        field(50000; "NM Phone Info"; code[10])
        {
            Caption = 'Phone No. Infocode';
            DataClassification = ToBeClassified;
            TableRelation = Infocode.Code;
        }
        field(50001; "NM Name Info"; Code[10])
        {
            Caption = 'Name Infocode';
            DataClassification = ToBeClassified;
            TableRelation = Infocode.Code;
        }
        field(50002; "NM Club Code"; Code[10])
        {
            Caption = 'Club';
            DataClassification = ToBeClassified;
            TableRelation = "Member Club".Code;
        }
        field(50003; "NM Scheme Code"; Code[10])
        {
            Caption = 'Scheme';
            DataClassification = ToBeClassified;
            TableRelation = "Member Scheme".Code where("Club Code" = field("NM Club Code"));
        }
    }

    var
        myInt: Integer;
}