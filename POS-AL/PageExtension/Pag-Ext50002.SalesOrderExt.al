pageextension 50002 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter(SalesLines)
        {
            part("Tender Type"; "Nominal Payment Method")
            {
                Caption = 'Tender Type';
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
            }
        }
    }
}