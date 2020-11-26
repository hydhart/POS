pageextension 50000 "Retail Item Card Ext" extends "Retail Item Card"
{
    layout
    {
        addafter(POS)
        {
            group("Modern Channel")
            {
                field(mc_ItemType; Rec.mc_ItemType)
                {
                    ApplicationArea = All;
                }
                field(mc_vtype; Rec.mc_vtype)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
