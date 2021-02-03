report 50007 "Commision Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50007.CommisionReport.rdlc';

    dataset
    {
        dataitem(HistorySales; "SPS History Sales")
        {
            DataItemTableView = sorting("Store Code", "SPG Code", "Order Date");
            RequestFilterFields = "SPG Code", "Store Code", "Order Date";

            column(Store_Name; Store.Name) { }
            column(SPG_Code; "SPG Code") { }
            column(SPG_Name; Staff."First Name") { }
            column(Inventory_Posting_Group; "Item Category Code") { }
            column(Item_ProdGroup; Item."Retail Product Code") { }
            column(Qty; Qty) { }
            column(Amount; Amount) { }
            column(Target; "Qty Target Store") { }
            column(Comission; Comission) { }

            trigger OnAfterGetRecord()
            begin
                if Item.Get("Item No") then;
                if Store.Get("Store Code") then;
                if Staff.Get("SPG Code") then;
            end;
        }
    }
    var
        Item: Record Item;
        Store: Record Store;
        Staff: Record Staff;
}
