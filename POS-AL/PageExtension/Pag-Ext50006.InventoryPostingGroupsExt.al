pageextension 50006 "Inventory Posting Groups Ext" extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Comission Group Code"; "Comission Group Code")
            {
                ApplicationArea = All;
            }
        }
    }
}