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
            column(Target; TargetStore.Target) { }
            column(Mode; TargetStore.Mode) { }
            column(Comission; Comission) { }

            trigger OnAfterGetRecord()
            begin
                if not Store.Get("Store Code") then
                    Store.Init();
                if not Staff.Get("SPG Code") then
                    Staff.Init();
                TargetStore.SetRange("Inventory Posting Group", "Inventory Posting Group");
                TargetStore.SetRange("Store Code", "Store Code");
                TargetStore.SetRange("SPG Code", "SPG Code");
                if not Item.Get("Item No") then
                    Item.Init()
                else
                    TargetStore.SetRange("Item Family Code", Item."Item Family Code");
                TargetStore.SetFilter("Start Date", '<=%1', "Order Date");
                if not TargetStore.FindLast() then begin
                    TargetStore.SetRange("Item Family Code");
                    if not TargetStore.FindLast() then
                        TargetStore.Init();
                end;
            end;
        }
    }
    var
        Item: Record Item;
        Store: Record Store;
        Staff: Record Staff;
        TargetStore: Record "SPS Target Store";
}
