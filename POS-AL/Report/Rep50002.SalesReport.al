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
            column(Date; Date) { }
            column(Item_No_; "Item No.") { }
            column(Item_Category_Code; "Item Category Code") { }
            column(Serial_No_; "Serial No.") { }
            column(Quantity; Quantity) { }
            column(Unit_of_Measure; "Unit of Measure") { }
            column(Price; Price) { }
            column(Discount_Amount; "Discount Amount") { }
            column(Net_Amount; "Net Amount") { }
            column(VAT_Amount; "VAT Amount") { }
            column(Cost_Amount; "Cost Amount") { }
            column(Staff_ID; "Staff ID") { }
            column(Time; Time) { }
            column(Periodic_Discount; "Periodic Discount") { }
            column(Sales_Staff; "Sales Staff") { }
            #endregion Columns

            column(Item_InvPosGroup; Item."Inventory Posting Group") { }
            column(Item_Desc; Item.Description) { }
            column(GrossAmt; GrossAmt) { }
            column(Store_Name; Store.Name) { }
            column(Staff; Staff."First Name") { }
            dataitem("Trans. Payment Entry"; "Trans. Payment Entry")
            {
                DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."),
                              "Transaction No." = FIELD("Transaction No.");
                #region Columns
                column(Tender_Type; TenderDesc) { }
                column(TenderCaption; TenderCaption) { }
                column(Amount_Tendered; "Amount Tendered") { }
                #endregion Columns

                trigger OnAfterGetRecord()
                begin
                    TenderType.Reset();
                    TenderType.SetRange(Code, "Tender Type");
                    if TenderType.FindFirst() then begin
                        TenderDesc := TenderType.Description;
                        TenderCaption := TenderDesc;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Item.Get("Item No.") then;

                if Store.Get("Store No.") then;

                if Staff.Get("Sales Staff") then;

                GrossAmt := "Net Amount" * 1.1;
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
        GrossAmt: Decimal;
}
