report 50009 "Service Invoice"
{
    ApplicationArea = All;
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50009.ServiceInvoice.rdlc';

    dataset
    {
        dataitem(InvHeader; "Service Invoice Header")
        {
            column(No; "No.") { }
            dataitem(InvLine; "Service Invoice Line")
            {
                column(No_; "No.") { }
            }
        }
    }

    var
        myInt: Integer;
}