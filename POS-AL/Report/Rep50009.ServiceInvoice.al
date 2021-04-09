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
            column(CompInfo_Name; CompInfo.Name) { }
            column(CompInfo_Address; CompInfo.Address) { }
            column(CompInfo_Address2; CompInfo."Address 2") { }
            column(CompInfo_City; CompInfo.City) { }
            column(CompInfo_Pic; CompInfo.Picture) { }
            column(ServiceHeader_No; "No.") { }
            column(ServiceHeader_Posting_Date; "Posting Date") { }
            column(CompInfo_NPWP; CompInfo."VAT Registration No.") { }
            column(ServiceHeader_Name; Name) { }
            column(ServiceHeader_Address; Address) { }
            column(ServiceHeader_Address_2; "Address 2") { }
            column(ServiceHeader_City; City) { }
            column(ServiceHeader_Phone_No_; "Phone No.") { }
            column(ServiceItem_Product; ServiceItem."Service Item Group Code") { }
            column(ServiceItem_Model; ServiceItem.Description) { }
            column(ServiceItem_SerialNo; ServiceItem."Serial No.") { }
            column(ServiceItem_Warranty; ServiceItem."Warranty Starting Date (Parts)") { }
            column(ServiceItem_Status; ServiceItem."Customer No.") { }

            dataitem(InvLine; "Service Invoice Line")
            {
                column(SericeLine_No_; "No.") { }
                column(SericeLine_Fault_Code; "Fault Code") { }
                column(SericeLineFault_Description; Fault.Description) { }
                column(SericeLineDescription; Description) { }
                column(SericeLineQuantity; Quantity) { }
                column(SericeLinePriceIncVAT; PriceIncVAT) { }

                trigger OnAfterGetRecord()
                begin
                    // Fault Area Code,Symptom Code,Code
                    if not Fault.Get("Fault Area Code", "Symptom Code", "Fault Code") then
                        Fault.Init();
                    PriceIncVAT := "Unit Price" + ("Unit Price" * "VAT %" / 100);
                    LineCount += 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                ServiceInvLine: Record "Service Invoice Line";
            begin
                ServiceInvLine.SetRange("Document No.", "No.");
                ServiceInvLine.SetFilter("Service Item No.", '<>%1', '');
                if ServiceInvLine.FindFirst() then begin
                    if not ServiceItem.Get(ServiceInvLine."Service Item No.") then
                        ServiceItem.Init();
                end else
                    ServiceItem.Init();
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
        MaxLine := 10;
        Clear(LineCount);
    end;

    var
        CompInfo: Record "Company Information";
        ServiceItem: Record "Service Item";
        Fault: Record "Fault Code";
        PriceIncVAT: Decimal;
        MaxLine: Integer;
        LineCount: Integer;
}