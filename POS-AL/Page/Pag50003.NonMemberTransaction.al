page 50003 "Non Member Transaction"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Trans. Sales Entry";
    SourceTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field(PhoneNo_Filter; PhoneNo_Filter)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        Rec.RESET;
                        Rec.DELETEALL;
                        CLEAR(TotalAmount);
                        CLEAR(MemberName);

                        IF MembershipCard.GET(PhoneNo_Filter) THEN BEGIN
                            MemberAccount.Get(MembershipCard."Card No.");
                            MemberName := MemberAccount.Description;

                            TransactionHeader.SETCURRENTKEY("Member Card No.");
                            TransactionHeader.SETRANGE("Member Card No.", PhoneNo_Filter);
                            TransactionHeader.SETRANGE("Entry Status", TransactionHeader."Entry Status"::" ");
                            IF TransactionHeader.FINDSET THEN
                                REPEAT
                                    TransSalesEntry.SETRANGE("Store No.", TransactionHeader."Store No.");
                                    TransSalesEntry.SETRANGE("POS Terminal No.", TransactionHeader."POS Terminal No.");
                                    TransSalesEntry.SETRANGE("Transaction No.", TransactionHeader."Transaction No.");
                                    IF TransSalesEntry.FINDSET THEN
                                        REPEAT
                                            Rec.INIT;
                                            Rec.COPY(TransSalesEntry);
                                            Rec.INSERT;
                                            TotalAmount += (TransSalesEntry."Net Amount" + TransSalesEntry."VAT Amount");
                                        UNTIL TransSalesEntry.NEXT = 0;
                                UNTIL TransactionHeader.NEXT = 0;
                            Rec.RESET;
                            Rec.FINDFIRST;
                        END ELSE BEGIN
                            MESSAGE('No data found');
                        END;
                    end;
                }
                field(MemberName; MemberName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
            }
            repeater(PurchasedItem)
            {
                Editable = false;
                field(ReceiptNo; "Receipt No.")
                {
                    ApplicationArea = All;
                }
                field(BarcodeNo; "Barcode No.")
                {
                    ApplicationArea = All;
                }
                field(ItemNo; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(ItemDesc; ItemDesc)
                {
                    ApplicationArea = All;
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
            }
            group(Total)
            {
                field(TotalAmount; TotalAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Item.GET("Item No.") THEN
            ItemDesc := Item.Description
        ELSE
            CLEAR(ItemDesc);
    end;

    var
        TransactionHeader: Record "Transaction Header";
        TransSalesEntry: Record "Trans. Sales Entry";
        Item: Record Item;
        MembershipCard: Record "Membership Card";
        MemberAccount: Record "Member Account";
        PhoneNo_Filter: Code[20];
        MemberName: Text[150];
        ItemDesc: Text;
        TotalAmount: Decimal;
}