tableextension 50001 "Trans Sales Entry Ext" extends "Trans. Sales Entry"
{
    fields
    {
        field(50000; mc_Itemtype; Enum "MC Item Type")
        {
            Caption = 'mc_vtype';
            DataClassification = ToBeClassified;
        }
        field(50001; mc_vtype; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; mc_operator; Text[20])
        {
            Caption = 'mc_operator';
            DataClassification = ToBeClassified;
        }
        field(50003; mc_hp; Text[20])
        {
            Caption = 'mc_hp';
            DataClassification = ToBeClassified;
        }
        field(50004; mc_server_trxid; Text[20])
        {
            Caption = 'mc_server_trxid';
            DataClassification = ToBeClassified;
        }
        field(50005; mc_partner_trxid; Text[20])
        {
            Caption = 'mc_partner_trxid';
            DataClassification = ToBeClassified;
        }
        field(50006; mc_amount; Text[20])
        {
            Caption = 'mc_amount';
            DataClassification = ToBeClassified;
        }
        field(50007; mc_sn; Text[20])
        {
            Caption = 'mc_sn';
            DataClassification = ToBeClassified;
        }
        field(50008; mc_name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Card No."; Code[20])
        {
            Caption = 'Card No.';
            DataClassification = ToBeClassified;
        }
    }
}
