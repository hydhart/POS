report 50002 "Sales Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50002.SalesReport.rdlc';

    dataset
    {
        dataitem(TransSalesEntry; "Trans. Sales Entry")
        {
            DataItemTableView = sorting("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
            RequestFilterFields = "Store No.", "POS Terminal No.", "Staff ID", "Item No.";
            #region Columns
            column(Store_No_; "Store No.") { }
            column(Receipt_No_; "Receipt No.") { }
            column(Line_No_; "Line No.") { }
            column(Date; Date) { }
            column(Item_No_; "Item No.") { }
            column(Item_Category_Code; "Item Category Code") { }
            column(Serial_No_; "Serial No.") { }
            column(Unit_of_Measure; "Unit of Measure") { }
            column(Staff_ID; "Staff ID") { }
            column(Time; Time) { }
            column(Sales_Staff; "Sales Staff") { }
            #endregion Columns
            column(Item_InvPosGroup; Item."Inventory Posting Group") { }
            column(Item_Desc; Item.Description) { }
            column(Store_Name; Store.Name) { }
            column(Staff; Staff."First Name") { }
            dataitem("Trans. Payment Entry"; "Trans. Payment Entry")
            {
                DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."),
                              "Transaction No." = FIELD("Transaction No.");
                #region Columns
                column(Quantity; ItemQty) { }
                column(Price; ItemPrice) { }
                column(Discount_Amount; ItemDiscAmt) { }
                column(Net_Amount; ItemNettAmt) { }
                column(VAT_Amount; ItemVATAmt) { }
                column(Cost_Amount; ItemCostAmt) { }
                column(Periodic_Discount; ItemPeriodicDiscAmt) { }
                column(GrossAmt; ItemGrossAmt) { }
                column(Tender_Type; TenderDesc) { }
                column(TenderCaption; TenderCaption) { }
                column(Amount_Tendered; TenderAmount) { }
                column(TotalQty; TotalQty) { }
                column(TotalGrossAmt; TotalGrossAmt) { }
                column(TotalNettAmt; TotalNettAmt) { }
                column(TotalDiscAmt; TotalDiscAmt) { }
                column(TotalPeriodDiscAmt; TotalPeriodDiscAmt) { }
                column(TotalVATAmt; TotalVATAmt) { }
                column(TotalCostAmt; TotalCostAmt) { }
                #endregion Columns

                trigger OnPreDataItem()
                begin
                    TenderCounter := 1;
                end;

                trigger OnAfterGetRecord()
                begin
                    if TenderCounter > 1 then begin
                        Clear(ItemQty);
                        Clear(ItemPrice);
                        Clear(ItemGrossAmt);
                        Clear(ItemPeriodicDiscAmt);
                        Clear(ItemCostAmt);
                        Clear(ItemNettAmt);
                        Clear(ItemDiscAmt);
                        Clear(ItemVATAmt);
                        Clear(TenderAmount);
                    end;
                    TenderCounter += 1;

                    TenderType.Reset();
                    TenderType.SetRange(Code, "Tender Type");
                    if TenderType.FindFirst() then begin
                        TenderDesc := TenderType.Description;
                        TenderCaption := TenderDesc;
                    end;

                    if ItemCounter = 1 then begin
                        TenderAmount := "Amount Tendered";
                        //TotalTenderAmt += "Amount Tendered";
                    end else begin
                        Clear(TenderAmount);
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                Clear(ItemQty);
                Clear(ItemPrice);
                Clear(ItemGrossAmt);
                Clear(ItemPeriodicDiscAmt);
                Clear(ItemCostAmt);
                Clear(ItemNettAmt);
                Clear(ItemDiscAmt);
                Clear(ItemVATAmt);
                Clear(TenderAmount);

                Clear(TotalQty);
                Clear(TotalGrossAmt);
                Clear(TotalNettAmt);
                Clear(TotalDiscAmt);
                Clear(TotalPeriodDiscAmt);
                Clear(TotalVATAmt);
                Clear(TotalCostAmt);
                Clear(TotalTenderAmt);
            end;

            trigger OnAfterGetRecord()
            begin
                if LastReceiptNo <> "Receipt No." then
                    ItemCounter := 0;

                if Item.Get("Item No.") then;

                if Store.Get("Store No.") then;

                if Staff.Get("Sales Staff") then;

                GrossAmt := "Net Amount" + "VAT Amount";

                ItemQty := Quantity;
                ItemPrice := Price;
                ItemGrossAmt := GrossAmt;
                ItemPeriodicDiscAmt := "Periodic Discount";
                ItemCostAmt := "Cost Amount";
                ItemNettAmt := "Net Amount";
                ItemDiscAmt := "Discount Amount";
                ItemVATAmt := "VAT Amount";

                TotalQty += Quantity;
                TotalGrossAmt += GrossAmt;
                TotalNettAmt += "Net Amount";
                TotalDiscAmt += "Discount Amount";
                TotalPeriodDiscAmt += "Periodic Discount";
                TotalVATAmt += "VAT Amount";
                TotalCostAmt += "Cost Amount";

                ItemCounter += 1;
                LastReceiptNo := "Receipt No.";
            end;
        }
    }
    var
        TenderType: Record "Tender Type";
        Item: Record Item;
        Store: Record Store;
        Staff: Record Staff;
        TenderDesc: Text;
        TenderCaption: Text;
        ItemQty: Decimal;
        ItemPrice: Decimal;
        ItemGrossAmt: Decimal;
        ItemPeriodicDiscAmt: Decimal;
        ItemCostAmt: Decimal;
        ItemNettAmt: Decimal;
        ItemDiscAmt: Decimal;
        ItemVATAmt: Decimal;
        TenderAmount: Decimal;
        GrossAmt: Decimal;
        TotalQty: Decimal;
        TotalGrossAmt: Decimal;
        TotalNettAmt: Decimal;
        TotalDiscAmt: Decimal;
        TotalVATAmt: Decimal;
        TotalCostAmt: Decimal;
        TotalPeriodDiscAmt: Decimal;
        TotalTenderAmt: Decimal;
        TenderCounter: Integer;
        ItemCounter: Integer;
        LastReceiptNo: Code[20];
}
