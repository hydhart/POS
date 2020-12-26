codeunit 50004 "POS Custom Event Subscriber"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnBeforeTotalExecuted', '', false, false)]
    local procedure OnBeforeTotalExecuted(var POSTransaction: Record "POS Transaction")
    var
        POSTransLine: Record "POS Trans. Line";
        InfocodeEntry: Record "POS Trans. Infocode Entry";
        Item: Record Item;
        RetailSetup: Record "Retail Setup";
        InfoCode: Record Infocode;
        POSTrx: Codeunit "POS Transaction";
        ModernChannelMgt: Codeunit "Modern Channel Mgt";
        MCEvent: Codeunit "MC Event Subscriber";
    begin
        ErrorSalesStaff := false;
        if POSTransaction."Sales Staff" = '' then begin
            ErrorSalesStaff := true;
            Message('Please assign SPG for this transaction to continue...');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnAfterTotalExecuted', '', false, false)]
    local procedure OnAfterTotalExecuted()
    begin
        if ErrorSalesStaff then begin
            CodPOSTrans.SetPOSState('SALES');
            CodPOSTrans.SetFunctionMode('ITEM');
            CodPOSTrans.SelectDefaultMenu;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnBeforeProcessInfoCode', '', false, false)]
    local procedure BeforeProcessInfocode(var POSTransaction: Record "POS Transaction"; var Infocode: Record Infocode)
    var
        RetailSetup: Record "Retail Setup";
        Input: text;
    begin
        RetailSetup.Get();
        if (RetailSetup."NM Name Info" = Infocode.Code) or (RetailSetup."NM Phone Info" = Infocode.Code) then begin
            if POSTransaction."Member Card No." <> '' then begin
                if RetailSetup."NM Phone Info" = Infocode.Code then begin
                    CodPOSTrans.CancelPressed(true, 0);
                    CodPOSTrans.MessageBeep(STRSUBSTNO('Membership card %1 already applied', POSTransaction."Member Card No."));
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnAfterCheckInfoCode', '', false, false)]
    local procedure AfterCheckInfocode(var POSTransaction: Record "POS Transaction"; var Infocode: Record Infocode)
    var
        RetailSetup: Record "Retail Setup";
        InfoEntry: Record "POS Trans. Infocode Entry";
        NameInfoEntry: Record "POS Trans. Infocode Entry";
        MembershipCard: Record "Membership Card";
        MemberAccount: Record "Member Account";
        Input: text;
    begin
        RetailSetup.Get();
        if RetailSetup."NM Phone Info" = Infocode.Code then begin
            if POSTransaction."Member Card No." = '' then begin
                InfoEntry.SetRange("Receipt No.", POSTransaction."Receipt No.");
                InfoEntry.SetRange(Infocode, Infocode.Code);
                if InfoEntry.FindFirst() then begin
                    Input := InfoEntry.Information;
                    if MembershipCard.Get(Input) then begin
                        POSTransaction.Validate("Member Card No.", Input);
                        POSTransaction.Modify();

                        MemberAccount.Get(Input);
                        NameInfoEntry.Init();
                        NameInfoEntry.Copy(InfoEntry);
                        NameInfoEntry."Line No." += 10000;
                        NameInfoEntry.Infocode := RetailSetup."NM Name Info";
                        NameInfoEntry.Information := MemberAccount.Description;
                        if InfoEntry.Insert() then;

                        CodPOSTrans.CancelPressed(true, 0);
                        Message(STRSUBSTNO('Membership card %1 found and applied', Input));
                    end else begin
                        Message(STRSUBSTNO('Membership card %1 will be registered once transaction finished.\Press NON MEMBER again to input name', Input));
                    end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Post Utility", 'OnAfterInsertTransHeader', '', false, false)]
    local procedure AfterInsertTransHeader(var Transaction: Record "Transaction Header"; var POSTrans: Record "POS Transaction")
    var
        RetailSetup: Record "Retail Setup";
        POSInfoEntry: Record "POS Trans. Infocode Entry";
        MemberAccount: Record "Member Account";
        MembershipCard: Record "Membership Card";
    begin
        Transaction."Sales Staff" := POSTrans."Sales Staff";
        RetailSetup.Get();
        if POSTrans."Member Card No." <> '' then begin
            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Phone Info");
            if POSInfoEntry.FINDFIRST then
                POSInfoEntry.DELETE;

            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Name Info");
            if POSInfoEntry.FINDFIRST then
                POSInfoEntry.DELETE;
        end else begin
            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Phone Info");
            if POSInfoEntry.FINDFIRST then begin
                if not MemberAccount.Get(POSInfoEntry.Information) then begin
                    MemberAccount.Init();
                    MemberAccount."No." := POSInfoEntry.Information;
                    POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Name Info");
                    if POSInfoEntry.FINDFIRST then
                        MemberAccount.Description := POSInfoEntry.Information;
                    MemberAccount."Club Code" := RetailSetup."NM Club Code";
                    MemberAccount."Scheme Code" := RetailSetup."NM Scheme Code";
                    MemberAccount.Status := MemberAccount.Status::Active;
                    MemberAccount."Date Activated" := TODAY;
                    MemberAccount."Activated By" := USERID;
                    MemberAccount.Blocked := FALSE;
                    MemberAccount.INSERT(TRUE);

                    MembershipCard.INIT;
                    MembershipCard."Card No." := MemberAccount."No.";
                    MembershipCard.Status := MembershipCard.Status::Active;
                    MembershipCard."Account No." := MemberAccount."No.";
                    MembershipCard."Contact No." := MemberAccount."No.";
                    MembershipCard."Club Code" := MemberAccount."Club Code";
                    MembershipCard."Scheme Code" := MemberAccount."Scheme Code";
                    MembershipCard.INSERT(TRUE);
                end;
                Transaction."Member Card No." := MembershipCard."Card No.";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Post Utility", 'SalesEntryOnBeforeInsert', '', false, false)]
    local procedure BeforeInsertSalesEntry(var pPOSTransLine: Record "POS Trans. Line"; var pTransSalesEntry: Record "Trans. Sales Entry")
    var
        POSTrans: Record "POS Transaction";
    begin
        pTransSalesEntry."Sales Staff" := pPOSTransLine."Sales Staff";
        if POSTrans.Get(pPOSTransLine."Receipt No.") then
            pTransSalesEntry."Card No." := POSTrans."Member Card No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintSlips', '', false, false)]
    local procedure BeforePrintSlips(var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var MsgTxt: Text[50]; var IsHandled: Boolean; var ReturnValue: Boolean)
    var
        POSFuncProfile: Record "POS Functionality Profile";
        Store: Record Store;
        Terminal: Record "POS Terminal";
        Staff: Record Staff;
    begin
        POSFuncProfile.Get(Globals.FunctionalityProfileID());
        Transaction."Print Counter" += 1;
        Transaction.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintVoidSlip', '', false, false)]
    local procedure BeforePrintVoidSlip(var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; var IsHandled: Boolean; var ReturnValue: Boolean)
    var
        POSFuncProfile: Record "POS Functionality Profile";
    begin
        POSFuncProfile.Get(Globals.FunctionalityProfileID());
        if not POSFuncProfile."Print Void Slip" then begin
            IsHandled := true;
            ReturnValue := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintCardSlipFromEFT', '', false, false)]
    local procedure BeforePrintCardSlipFromEFT(var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; var IsHandled: Boolean; var ReturnValue: Boolean)
    var
        POSFuncProfile: Record "POS Functionality Profile";
    begin
        POSFuncProfile.Get(Globals.FunctionalityProfileID());
        if not POSFuncProfile."Print Card Slip" then begin
            IsHandled := true;
            ReturnValue := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintSuspendSlip', '', false, false)]
    local procedure BeforePrintSuspendSlip(var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; var IsHandled: Boolean; var ReturnValue: Boolean)
    var
        POSFuncProfile: Record "POS Functionality Profile";
    begin
        POSFuncProfile.Get(Globals.FunctionalityProfileID());
        if not POSFuncProfile."Print Suspend Slip" then begin
            IsHandled := true;
            ReturnValue := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintSubHeader', '', false, false)]
    local procedure BeforePrintSubHeader(Sender: Codeunit "POS Print Utility"; var TransactionHeader: Record "Transaction Header"; Tray: Integer; var POSPrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var IsHandled: Boolean)
    var
        Staff: Record Staff;
        Store: Record Store;
        MemberCard: Record "Membership Card";
        MemberAccount: Record "Member Account";
        StaffName: Text[30];
        blankStr: Text[30];
        StoreName: Text[30];
        CardHolderName: Text[30];
        DSTR1: Text[100];
        NodeName: array[32] of Text[50];
        Value: array[10] of Text[80];
        LineLen: Integer;
        InvLineLen: Integer;
    begin
        LineLen := 40;
        InvLineLen := 44;
        IF Tray = 2 THEN
            blankStr := Sender.StringPad(' ', LineLen - 38)
        ELSE
            IF Tray = 4 THEN
                blankStr := Sender.StringPad(' ', InvLineLen - 38);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        Value[1] := TextNoInvoice;
        NodeName[1] := 'x';
        Value[2] := TransactionHeader."Receipt No.";
        NodeName[2] := 'Receipt No.';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 2, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        Value[1] := TextTanggal;
        NodeName[1] := 'x';
        Value[2] := FORMAT(TransactionHeader.Date, 0, '<Day,2>-<Month,2>-<Year>');
        NodeName[2] := 'Trans. Date';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 3, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        StoreName := TransactionHeader."Store No.";
        IF Store.GET(StoreName) THEN
            StoreName := COPYSTR(Store.Name, 1, 30);
        Value[1] := TextOutlet;
        NodeName[1] := 'x';
        Value[2] := StoreName;
        NodeName[2] := 'Trans. Date';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 3, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        Value[1] := TextNoCashier;
        NodeName[1] := 'x';
        Value[2] := TransactionHeader."Staff ID";
        NodeName[2] := 'No. Cashier';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        StaffName := TransactionHeader."Staff ID";
        IF Staff.GET(TransactionHeader."Staff ID") THEN
            StaffName := Staff."Name on Receipt";
        Value[1] := TextCashier;
        NodeName[1] := 'x';
        Value[2] := StaffName;
        NodeName[2] := 'Cashier';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        StaffName := TransactionHeader."Sales Staff";
        IF Staff.GET(TransactionHeader."Sales Staff") THEN
            StaffName := Staff."Name on Receipt";
        Value[1] := TextSales;
        NodeName[1] := 'x';
        Value[2] := StaffName;
        NodeName[2] := 'Sales Person';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        DSTR1 := '#L################## #L#################';
        CardHolderName := TransactionHeader."Member Card No.";
        IF MemberCard.GET(CardHolderName) THEN BEGIN
            MemberAccount.Get(MemberCard."Account No.");
            CardHolderName := MemberAccount.Description;
        END;
        Value[1] := TextCustomer;
        NodeName[1] := 'x';
        Value[2] := CardHolderName;
        NodeName[2] := 'Customer';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        PrintSeperator2(Sender, Tray, '=');

        CLEAR(Value);
        DSTR1 := '#L######################################';
        Value[1] := TextFieldName1;
        NodeName[1] := 'x';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        CLEAR(Value);
        Value[1] := TextFieldName2;
        NodeName[1] := 'x';
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        Sender.AddPrintLine(200, 5, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, Tray);

        PrintSeperator2(Sender, Tray, '=');

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintSalesInfo', '', false, false)]
    local procedure BeforePrintSalesInfo(Sender: Codeunit "POS Print Utility"; var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; Tray: Integer; var IsHandled: Boolean)
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintLoyalty', '', false, false)]
    local procedure BeforePrintLoyalty(Sender: Codeunit "POS Print Utility"; var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; var IsHandled: Boolean)
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Statement-Post", 'OnBeforeProcessTransactionStatus', '', false, false)]
    local procedure BeforeProcessTransactionStatus(var TransactionStatus: Record "Transaction Status"; Statement: Record Statement)
    var
        TransSalesEntry: Record "Trans. Sales Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        TransSalesEntry.SetRange("Store No.", TransactionStatus."Store No.");
        TransSalesEntry.SetRange("POS Terminal No.", TransactionStatus."POS Terminal No.");
        TransSalesEntry.SetRange("Transaction No.", TransactionStatus."Transaction No.");
        if TransSalesEntry.FindSet() then
            repeat
                IF item.GET(TransSalesEntry."Item No.") THEN BEGIN
                    IF itemTrackingCode.GET(item."Item Tracking Code") THEN BEGIN
                        IF (TransSalesEntry.Quantity > 0) AND itemTrackingCode."SN Sales Inbound Tracking" THEN BEGIN
                            ValidateSerialNo(TransSalesEntry."Item No.", TransSalesEntry."Variant Code", TransSalesEntry."Store No.", TransSalesEntry."Serial No.", false);
                        END;
                        IF (TransSalesEntry.Quantity < 0) AND ItemTrackingCode."SN Sales Outbound Tracking" THEN BEGIN
                            ValidateSerialNo(TransSalesEntry."Item No.", TransSalesEntry."Variant Code", TransSalesEntry."Store No.", TransSalesEntry."Serial No.", true);
                        END;
                    END;
                END;
            until TransSalesEntry.Next() = 0;
    end;

    local procedure PrintSeperator2(Var Sender: Codeunit "POS Print Utility"; Tray: Integer; Char: Text)
    var
        LineLength: Integer;
        DSTR1: Text;
        Value: array[10] of Text[80];
        LineLen: Integer;
        InvLineLen: Integer;
    begin
        IF Tray = 2 THEN
            LineLength := LineLen
        ELSE
            IF Tray = 4 THEN
                LineLength := InvLineLen;

        DSTR1 := '#C' + Sender.StringPad('#', LineLength - 2);
        Value[1] := Sender.StringPad(Char, LineLength);
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, FALSE, FALSE, FALSE));
    end;

    local procedure ValidateSerialNo(ItemNo: Code[20]; VariantCode: Code[10]; StoreNo: Code[10]; SerialNo: Code[20]; Out: Boolean)
    var
        Store: Record Store;
        ILE: Record "Item Ledger Entry";
    begin
        Store.Get(StoreNo);
        ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
        ILE.SETRANGE("Item No.", ItemNo);
        ILE.SETRANGE(Open, TRUE);
        ILE.SETRANGE("Variant Code", VariantCode);
        ILE.SETRANGE("Location Code", Store."Location Code");
        ILE.SETRANGE("Serial No.", SerialNo);

        IF Out THEN BEGIN
            IF ile.ISEMPTY THEN
                ERROR('S/N (%1) not available for item no. %2 and location %3', SerialNo, ItemNo, Store."Location Code");
        END ELSE BEGIN
            IF NOT ile.ISEMPTY THEN
                ERROR('S/N (%1) already exist for item no. %2 and Location %3', SerialNo, ItemNo, Store."Location Code");
        END;
    end;

    var
        Globals: Codeunit "POS Session";
        CodPOSTrans: Codeunit "POS Transaction";
        ErrorSalesStaff: Boolean;

        TextNoInvoice: TextConst ENU = 'No.Invoice         :';
        TextTanggal: TextConst ENU = 'Tanggal            :';
        TextOutlet: TextConst ENU = 'Outlet             :';
        TextShift: TextConst ENU = 'Shift              :';
        TextNoCashier: TextConst ENU = 'No. Cashier        :';
        TextCashier: TextConst ENU = 'Cashier            :';
        TextSales: TextConst ENU = 'Sales              :';
        TextCustomer: TextConst ENU = 'Customer           :';
        TextFieldName1: TextConst ENU = 'NAMA BARANG';
        TextFieldName2: TextConst ENU = 'QTY   H. SATUAN     DISC          TOTAL';
}