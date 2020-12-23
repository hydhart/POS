pageextension 50003 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter(SalesInvLines)
        {
            part("Tender Type"; "Nominal Payment Method")
            {
                Caption = 'Tender Type';
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Document Type" = const(Invoice), "Document No." = field("No.");
            }
        }
    }
}