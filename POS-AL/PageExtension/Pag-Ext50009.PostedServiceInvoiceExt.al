pageextension 50009 "Posted Service Invoice Ext" extends "Posted Service Invoice"
{
    layout
    {
        addafter("Contact No.")
        {
            field(IProtech; IProtech)
            {
                Caption = 'I Pro Tech';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

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