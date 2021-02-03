report 50005 "History Sales Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50005.HistorySales.rdlc';

    dataset
    {
        dataitem(HistorySales; "SPS History Sales")
        {
            DataItemTableView = sorting("Store Code", "SPG Code", "Order Date");
            RequestFilterFields = "SPG Code", "Store Code", "Order Date";

            column(Order_Date; "Order Date") { }
            column(SPG_Code; "SPG Code") { }
            column(Store_Code; "Store Code") { }
            column(Store_Name; Store.Name) { }
            column(Order_ID; "Order ID") { }
            column(Item_No; "Item No") { }
            column(Item_Desc; Item.Description) { }
            column(Item_ProdGroup; Item."Retail Product Code") { }
            column(Serial_No; "Serial No") { }
            column(Qty; Qty) { }
            column(Amount; Amount) { }
            column(Sub_Total; GrossAmt) { }
            column(Comission; Comission) { }

            trigger OnAfterGetRecord()
            begin
                if Item.Get("Item No") then;
                if Store.Get("Store Code") then;
                if Staff.Get("SPG Code") then;
                GrossAmt := Qty * Amount;
            end;
        }
    }
    var
        Item: Record Item;
        Store: Record Store;
        Staff: Record Staff;
        GrossAmt: Decimal;
}
