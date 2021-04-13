report 50010 "Service Receipt"
{
    ApplicationArea = All;
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50010.ServiceReceipt.rdlc';

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
                DataItemTableView = sorting("Document No.", "Line No.");

                trigger OnPreDataItem()
                begin
                    ServiceInvLineTemp.Reset();
                    ServiceInvLineTemp.DeleteAll();
                end;

                trigger OnAfterGetRecord()
                begin
                    LineCount += 1;
                    LastLineNo := InvLine."Line No.";
                    LastDocNo := InvLine."Document No.";
                    ServiceInvLineTemp.Init();
                    ServiceInvLineTemp.Copy(InvLine);
                    ServiceInvLineTemp.Insert();
                    PriceIncVAT := "Unit Price" + ("Unit Price" * "VAT %" / 100);
                    if Type = Type::Resource then
                        TotalService += PriceIncVAT
                    else
                        if Type = Type::Cost then begin
                            if ServiceCost.Get("No.") then begin
                                if ServiceCost."Cost Type" = ServiceCost."Cost Type"::Travel then
                                    TotalTransport += PriceIncVAT
                                else
                                    if ServiceCost."Cost Type" = ServiceCost."Cost Type"::Other then
                                        TotalPart += PriceIncVAT;
                            end;
                        end;
                end;

                trigger OnPostDataItem()
                begin
                    if LineCount < MaxLine then
                        repeat
                            LineCount += 1;
                            LastLineNo := LineCount * 10000 + 10000;
                            ServiceInvLineTemp.Init();
                            ServiceInvLineTemp."Document No." := LastDocNo;
                            ServiceInvLineTemp."Line No." := LastLineNo;
                            ServiceInvLineTemp.Insert();
                        until LineCount = MaxLine;
                end;
            }
            dataitem(LineData; Integer)
            {
                column(ServiceLine_LineNo; ServiceInvLineTemp."Line No.") { }
                column(ServiceLine_LocationCode; ServiceInvLineTemp."Location Code") { }
                column(ServiceLine_No_; ServiceInvLineTemp."No.") { }
                column(ServiceLine_Fault_Code; ServiceInvLineTemp."Fault Code") { }
                column(ServiceLineFault_Description; Fault.Description) { }
                column(ServiceLineDescription; ServiceInvLineTemp.Description) { }
                column(ServiceLineQuantity; ServiceInvLineTemp.Quantity) { }
                column(ServiceLinePriceIncVAT; PriceIncVAT) { }
                column(TotalPart; TotalPart) { }
                column(TotalService; TotalService) { }
                column(TotalTransport; TotalTransport) { }

                trigger OnPreDataItem()
                begin
                    ServiceInvLineTemp.Reset();
                    if ServiceInvLineTemp.Count < 1 then
                        SetRange(Number, 1, 1)
                    else
                        SetRange(Number, 1, ServiceInvLineTemp.Count);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        ServiceInvLineTemp.FindSet()
                    else
                        ServiceInvLineTemp.Next();
                    if not Fault.Get(ServiceInvLineTemp."Fault Area Code", ServiceInvLineTemp."Symptom Code", ServiceInvLineTemp."Fault Code") then
                        Fault.Init();
                    PriceIncVAT := ServiceInvLineTemp."Unit Price" + (ServiceInvLineTemp."Unit Price" * ServiceInvLineTemp."VAT %" / 100);
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
        MaxLine := 15;
        Clear(LineCount);
        Clear(TotalPart);
        Clear(TotalService);
        Clear(TotalTransport);
        ServiceInvLineTemp.Reset();
        if ServiceInvLineTemp.FindSet() then
            ServiceInvLineTemp.DeleteAll();
    end;

    var
        CompInfo: Record "Company Information";
        ServiceItem: Record "Service Item";
        ServiceCost: Record "Service Cost";
        ServiceInvLineTemp: Record "Service Invoice Line" temporary;
        Fault: Record "Fault Code";
        LastDocNo: Code[20];
        PriceIncVAT: Decimal;
        TotalPart: Decimal;
        TotalService: Decimal;
        TotalTransport: Decimal;
        MaxLine: Integer;
        LineCount: Integer;
        LastLineNo: Integer;
}