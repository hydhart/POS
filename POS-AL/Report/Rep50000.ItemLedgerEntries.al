report 50000 "Item Ledger Entries"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = 'Report/Layout/ItemLedgerEntries.rdlc';

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Posting Date", "Source Type", "Source No.", "Document Type", "Document No.";

            column(Entry_No_; "Entry No.") { }
            column(PostingDate; "Posting Date") { }
            column(EntryType; "Entry Type") { }
            column(DocumentNo; "Document No.") { }
            column(DocumentType; "Document Type") { }
            column(ItemNo; "Item No.") { }
            column(SerialNo; "Serial No.") { }
            column(InvoicedQuantity; "Invoiced Quantity") { }
            column(Quantity; Quantity) { }
            column(RemainingQuantity; "Remaining Quantity") { }
            column(SalesAmountActual; "Sales Amount (Actual)") { }
            column(CostAmountActual; "Cost Amount (Actual)") { }
            column(LocationCode; "Location Code") { }
            column(EntryNo; "Entry No.") { }
            column(VendorNo; VendorNo) { }
            column(VendorName; VendorName) { }
            column(InvPostingGroup; InvPostingGroup) { }
            column(ItemDescription; ItemDescription) { }
            column(StoreNo; StoreNo) { }
            column(ProductGroup; ProductGroup) { }

            trigger OnAfterGetRecord()
            begin
                if Item.Get("Item No.") then begin
                    ItemDescription := Item.Description;
                    InvPostingGroup := Item."Inventory Posting Group";
                    ProductGroup := Item."Retail Product Code";
                end
                else begin
                    Clear(ItemDescription);
                    Clear(InvPostingGroup);
                end;

                if Vendor.Get("Source No.") then begin
                    VendorNo := Vendor."No.";
                    VendorName := Vendor.Name;
                end
                else begin
                    Clear(VendorNo);
                    Clear(VendorName);
                end;
            end;
        }
    }
    var
        Item: Record Item;
        Vendor: Record Vendor;
        VendorNo: Code[20];
        VendorName: Text;
        InvPostingGroup: Code[20];
        ItemDescription: Text;
        StoreNo: Code[20];
        ProductGroup: Code[20];
}
