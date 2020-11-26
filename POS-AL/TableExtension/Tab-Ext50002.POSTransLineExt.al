tableextension 50002 "POS Trans Line Ext" extends "POS Trans. Line"
{
    fields
    {
        field(50000; mc_ItemType; Enum "MC Item Type")
        {
            Caption = 'mc_ItemType';
            DataClassification = ToBeClassified;
        }
        field(50001; mc_vtype; Code[20])
        {
            Caption = 'mc_vtype';
            DataClassification = ToBeClassified;
        }
    }
}
