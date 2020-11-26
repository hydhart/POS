tableextension 50000 "Item Ext" extends Item
{
    fields
    {
        field(50000; mc_ItemType; Enum "MC Item Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50001; mc_vtype; Code[20])
        {
            Caption = 'vtype';
            DataClassification = ToBeClassified;
            TableRelation = vtype.Code where(Type = field(mc_ItemType));
        }
    }
}
