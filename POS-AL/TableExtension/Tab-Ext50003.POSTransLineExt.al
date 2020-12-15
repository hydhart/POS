tableextension 50003 "POS Trans Line Ext" extends "POS Trans. Line"
{
    fields
    {
        field(50000; mc_vtype; Enum "MC Item Type")
        {
            Caption = 'mc_vtype';
            DataClassification = ToBeClassified;
        }
        field(50001; mc_operator; Text[20])
        {
            Caption = 'mc_operator';
            DataClassification = ToBeClassified;
        }
        field(50002; mc_hp; Text[20])
        {
            Caption = 'mc_hp';
            DataClassification = ToBeClassified;
        }
        field(50003; mc_server_trxid; Text[20])
        {
            Caption = 'mc_server_trxid';
            DataClassification = ToBeClassified;
        }
        field(50004; mc_partner_trxid; Text[20])
        {
            Caption = 'mc_partner_trxid';
            DataClassification = ToBeClassified;
        }
        field(50005; mc_amount; Text[20])
        {
            Caption = 'mc_amount';
            DataClassification = ToBeClassified;
        }
        field(50006; mc_sn; Text[20])
        {
            Caption = 'mc_sn';
            DataClassification = ToBeClassified;
        }
        field(50007; mc_name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterModify()
    var
        POSTrans: Record "POS Transaction";
    begin
        if xRec."Sales Staff" <> Rec."Sales Staff" then begin
            if POSTrans.Get("Receipt No.") then begin
                POSTrans."Sales Staff" := "Sales Staff";
                POSTrans.Modify();
            end;

        end;
    end;
}
