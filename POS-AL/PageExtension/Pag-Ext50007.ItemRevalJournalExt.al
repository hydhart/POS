pageextension 50007 "Item Revaluation Journal" extends "Revaluation Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Gen. Bus. Posting Group")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}