report 50006 "Summary Sales Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50006.SummarySales.rdlc';

    dataset
    {
        dataitem(HistorySales; "SPS History Sales")
        {
            DataItemTableView = sorting("Store Code", "SPG Code", "Order Date");
            RequestFilterFields = "SPG Code", "Store Code", "Order Date";

            trigger OnAfterGetRecord()
            begin
                HistorySalesTemp.SetCurrentKey("Store Code", "SPG Code", "Order Date");
                HistorySalesTemp.SetRange("Store Code", HistorySales."Store Code");
                HistorySalesTemp.SetRange("SPG Code", HistorySales."SPG Code");
                HistorySalesTemp.SetRange("Inventory Posting Group", HistorySales."Inventory Posting Group");
                if HistorySalesTemp.FindFirst() then begin
                    HistorySalesTemp.Qty += HistorySales.Qty;
                    HistorySalesTemp.Amount += HistorySales.Amount;
                    if "Qty Target Store" <> 0 then
                        HistorySalesTemp.Percentage := (HistorySalesTemp.Amount * 100) / HistorySalesTemp."Qty Target Store"
                    else
                        HistorySalesTemp.Percentage := 0;
                    HistorySalesTemp.Modify();
                end else begin
                    LineNo += 1;
                    HistorySalesTemp.Init();
                    HistorySalesTemp."Store Code" := HistorySales."Store Code";
                    HistorySalesTemp."SPG Code" := HistorySales."SPG Code";
                    HistorySalesTemp."Inventory Posting Group" := HistorySales."Inventory Posting Group";
                    HistorySalesTemp.Qty := HistorySales.Qty;
                    HistorySalesTemp.Amount := HistorySales.Amount;
                    HistorySalesTemp."Qty Target Store" := HistorySales."Qty Target Store";
                    if "Qty Target Store" <> 0 then
                        HistorySalesTemp.Percentage := (HistorySalesTemp.Amount * 100) / HistorySalesTemp."Qty Target Store"
                    else
                        HistorySalesTemp.Percentage := 0;
                    HistorySalesTemp."Line Nbr" := LineNo;
                    HistorySalesTemp.Insert();
                end;
            end;
        }
        dataitem(ReportData; Integer)
        {
            DataItemTableView = sorting(Number);
            column(No; HistorySalesTemp."Line Nbr") { }
            column(SPGCode; HistorySalesTemp."SPG Code") { }
            column(StoreCode; HistorySalesTemp."Store Code") { }
            column(InvPostingGroup; HistorySalesTemp."Inventory Posting Group") { }
            column(TargetStore; HistorySalesTemp."Qty Target Store") { }
            column(Qty; HistorySalesTemp.Qty) { }
            column(Amount; HistorySalesTemp.Amount) { }
            column(PercentageSales; HistorySalesTemp.Percentage) { }

            trigger OnPreDataItem()
            begin
                HistorySalesTemp.Reset();
                if HistorySalesTemp.Count > 0 then
                    ReportData.SetRange(Number, 1, HistorySalesTemp.Count)
                else begin
                    ReportData.SetRange(Number, 1, 1);
                    CurrReport.Break();
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    HistorySalesTemp.FindSet()
                else
                    HistorySalesTemp.Next();
            end;
        }
    }
    var
        HistorySalesTemp: Record "SPS History Sales" temporary;
        LineNo: Integer;
}
