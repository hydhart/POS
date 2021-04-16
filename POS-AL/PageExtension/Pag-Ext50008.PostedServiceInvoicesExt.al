pageextension 50008 "Posted Service Invoices Ext" extends "Posted Service Invoices"
{
    actions
    {
        addafter("&Print")
        {
            action("Print Service Tax")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = ServiceTax;

                trigger OnAction()
                var
                    ServiceInvTax: Report "Service Invoice";
                    ServiceInv: Record "Service Invoice Header";
                begin
                    ServiceInv.SetRange("No.", Rec."No.");
                    ServiceInvTax.SetTableView(ServiceInv);
                    ServiceInvTax.Run();
                end;
            }
        }
    }
}