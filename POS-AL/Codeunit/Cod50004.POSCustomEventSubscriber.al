codeunit 50004 "POS Custom Event Subscriber"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Functions", 'OnBeforeSerialNoIsValid', '', false, false)]
    //OnBeforeSerialNoIsValid(pPOSTransLine, pSerialNo, ExitValue, Proceed);
    local procedure BeforeSerialNoIsValid(var pPOSTransLine: Record "POS Trans. Line"; var pSerialNo: Code[50]; var ExitValue: Boolean; var Proceed: Boolean)
    begin
    end;

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
    var
        TransInfoCode: Record "Trans. Infocode Entry";
        Customer: Record Customer;
        SalesEntry: Record "Trans. Sales Entry";
        Item: Record Item;
        VATSetup: Record "POS VAT Code";
        MixMatchEntry: Record "Trans. Mix & Match Entry";
        PeriodicDiscount: Record "Periodic Discount";
        TransInfoEntry: Record "Trans. Infocode Entry";
        POSTerminal: Record "POS Terminal";
        ItemPosTextHeader: Record "Item POS Text Header";
        ItemPosTextLine: Record "Item POS Text Line";
        IncExpEntry: Record "Trans. Income/Expense Entry";
        IncExpAcc: Record "Income/Expense Account";
        CompInfo: Record "Company Information";
        ItemVariant: Record "Item Variant";
        ItemName: Text[40];
        ItemName2: Text[40];
        SalesLineAmount: Decimal;
        SalesAmountVAT: array[5] of Decimal;
        VATPerc: array[5] of Decimal;
        VATAmount: array[5] of Decimal;
        VATCode: array[5] of Code[10];
        TmpVATPerc: Decimal;
        i: Integer;
        j: Integer;
        PrintItemNo: Integer;
        VATPrinted: Boolean;
        discText: Text[30];
        discountSection: Boolean;
        totalCustItemDisc: Decimal;
        maxCounter: Integer;
        PerDiscOffArr: array[250] of Code[20];
        PerDiscOffAmtArr: array[250] of Decimal;
        PerDiscOffArrCount: Integer;
        qtyTxt: Text[15];
        LineArr: Text[50];
        OrderByDepartment: Boolean;
        LastDepartment: Code[10];
        PrintItem: Boolean;
        ItemTranslate: Record "Item Translation";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        SalesEntry2: Record "Trans. Sales Entry";
        LinkedItems: Record "Linked Item";
        GenPosFunc: Record "POS Functionality Profile";
        PosSetup: Record "POS Hardware Profile";
        CountItemOk: Boolean;
        totalNumberOfItems: Decimal;
        totalSavings: Decimal;
        totalReturnItems: Decimal;
        BanyakItem: Integer;
        ItemKembali: Integer;
        Barcode_l: Record Barcodes;
        infocode: Record Infocode;
        tmpDeal: Record Offer;
        glTrans: Record "Transaction Header";
        Store: Record Store;
        POSFunctions: Codeunit "POS Functions";
        DSTR1: Text[100];
        NodeName: array[32] of Text[50];
        Value: array[10] of Text[80];
        LineLen: Integer;
        InvLineLen: Integer;
    begin
        GenPosFunc.Get(Globals.FunctionalityProfileID());
        IF GenPosFunc."Multiple Items Symbol" = '' THEN
            GenPosFunc."Multiple Items Symbol" := ' x ';

        IF Transaction."Sale Is Return Sale" THEN BEGIN
            Value[1] := 'RETURN';
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, '#C##################'), TRUE, TRUE, TRUE, FALSE));
            Sender.PrintSeperator(Tray);
        END;

        IF NOT Sender.GetIsInvoice() THEN BEGIN
            IF Transaction.GetPrintedCounter(1) > 0 THEN
                Sender.PrintCopyText(Tray);
        END;

        IF Transaction."Entry Status" = Transaction."Entry Status"::Training THEN
            Sender.PrintTrainingText(Tray);

        PerDiscOffArrCount := 0;
        totalCustItemDisc := 0;

        CLEAR(totalNumberOfItems);
        CLEAR(totalSavings);

        CLEAR(VATCode);
        CLEAR(VATPerc);
        CLEAR(VATAmount);
        CLEAR(SalesAmountVAT);
        CLEAR(SalesEntry);
        CLEAR(Value);
        tmpDeal.DELETEALL;
        glTrans := Transaction;
        SalesEntry.SETRANGE("Store No.", Transaction."Store No.");
        SalesEntry.SETRANGE("POS Terminal No.", Transaction."POS Terminal No.");
        SalesEntry.SETRANGE("Transaction No.", Transaction."Transaction No.");
        OrderByDepartment := GenPosFunc."Receipt Printing by Category";
        IF OrderByDepartment THEN
            SalesEntry.SETCURRENTKEY("Item Category Code");
        IF SalesEntry.FIND('-') THEN BEGIN
            PrintItemNo := 0;
            IF POSTerminal.GET(SalesEntry."POS Terminal No.") THEN
                IF POSTerminal."Receipt Setup Location" = POSTerminal."Receipt Setup Location"::Store THEN BEGIN
                    CASE Store."Item No. on Receipt" OF
                        Store."Item No. on Receipt"::"Item Number":
                            PrintItemNo := 1;
                        Store."Item No. on Receipt"::"Barcode/Item Number":
                            PrintItemNo := 2;
                    END;
                END ELSE BEGIN
                    CASE POSTerminal."Item No. on Receipt" OF
                        POSTerminal."Item No. on Receipt"::"Item Number":
                            PrintItemNo := 1;
                        POSTerminal."Item No. on Receipt"::"Barcode/Item Number":
                            PrintItemNo := 2;
                    END;
                END;

            LastDepartment := '';

            REPEAT

                IF OrderByDepartment AND (SalesEntry."Item Category Code" <> LastDepartment) THEN BEGIN
                    DSTR1 := '#L######################################';
                    Value[1] := SalesEntry."Item Category Code";
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                    LastDepartment := SalesEntry."Item Category Code";
                END;

                CLEAR(ItemName2);
                IF Item.GET(SalesEntry."Item No.") THEN BEGIN
                    IF (SalesEntry."Variant Code" <> '') AND (ItemVariant.GET(SalesEntry."Item No.", SalesEntry."Variant Code")) THEN BEGIN
                        ItemName := COPYSTR(ItemVariant.Description, 1, 40);
                        ItemName2 := COPYSTR(ItemVariant."Description 2", 1, 40);
                    END ELSE
                        IF (Barcode_l.Description <> '') THEN
                            ItemName := COPYSTR(Barcode_l.Description, 1, 40)
                        ELSE BEGIN
                            ItemName := COPYSTR(Item.Description, 1, 40);
                            ItemName2 := COPYSTR(Item."Description 2", 1, 40);
                        END;
                END;

                POSTerminal.GET(Transaction."POS Terminal No.");
                IF POSTerminal."Print Total Savings" THEN BEGIN
                    totalSavings := totalSavings + (SalesEntry."Discount Amount" + SalesEntry."Total Discount");
                END;

                IF POSTerminal."Print Number of Items" THEN BEGIN
                    IF (SalesEntry.Quantity < 0) THEN BEGIN
                        CountItemOk := TRUE;
                        IF SalesEntry."Linked No. not Orig." THEN BEGIN
                            SalesEntry2.RESET;
                            SalesEntry2.COPYFILTERS(SalesEntry);
                            IF SalesEntry2.FIND('-') THEN BEGIN
                                REPEAT
                                    IF (SalesEntry2."Item No." <> SalesEntry."Item No.") AND SalesEntry2."Orig. of a Linked Item List" THEN BEGIN
                                        LinkedItems.RESET;
                                        LinkedItems.SETRANGE("Item No.", SalesEntry2."Item No.");
                                        LinkedItems.SETRANGE("Linked Item No.", SalesEntry."Item No.");
                                        LinkedItems.SETFILTER("Sales Type", '%1|%2', '', Transaction."Sales Type");
                                        IF LinkedItems.FINDFIRST THEN BEGIN
                                            IF LinkedItems."Deposit Item" THEN
                                                CountItemOk := FALSE;
                                        END;
                                    END;
                                UNTIL (SalesEntry2.NEXT = 0) OR NOT CountItemOk;
                            END;
                        END;

                        IF CountItemOk THEN BEGIN
                            IF ItemUnitOfMeasure.GET(SalesEntry."Item No.", SalesEntry."Unit of Measure") THEN BEGIN
                                IF ItemUnitOfMeasure."Count as 1 on Receipt" THEN
                                    totalNumberOfItems := totalNumberOfItems + 1
                                ELSE
                                    totalNumberOfItems := totalNumberOfItems + ABS(SalesEntry.Quantity);
                            END ELSE
                                totalNumberOfItems := totalNumberOfItems + ABS(SalesEntry.Quantity);
                        END;

                    END ELSE BEGIN
                        IF SalesEntry."Return No Sale" THEN
                            totalReturnItems := totalReturnItems + ABS(SalesEntry.Quantity);
                    END;
                END;

                IF Customer.GET(Transaction."Customer No.") THEN
                    IF Customer."Language Code" <> '' THEN
                        IF ItemTranslate.GET(SalesEntry."Item No.",
                                             SalesEntry."Variant Code",
                                             Customer."Language Code") THEN
                            IF ItemTranslate.Description <> '' THEN BEGIN
                                ItemName := ItemTranslate.Description;
                                ItemName2 := ItemTranslate."Description 2";
                            END;

                IF SalesEntry."Deal Line" THEN
                    Sender.PrintDeal(SalesEntry, Tray, PrintItemNo)
                ELSE BEGIN

                    SalesLineAmount := SalesEntry."Net Amount" + SalesEntry."VAT Amount";
                    DSTR1 := '#L######### #L###################';
                    IF (ABS(SalesEntry.Quantity) <> 1) OR SalesEntry."Scale Item" OR SalesEntry."Price in Barcode" THEN BEGIN
                        DSTR1 := '#L########################### #N########';
                        Value[1] := SalesEntry."Item No." + ' ' + ItemName;
                        Value[2] := POSFunctions.FormatAmount(-SalesLineAmount);
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, FALSE, FALSE, FALSE));

                        CLEAR(Value);
                        DSTR1 := '#R##################### #N######      ';
                        IF SalesEntry."Scale Item" OR SalesEntry."Price in Barcode" THEN BEGIN
                            Value[1] := Value[1] + POSFunctions.FormatWeight(-SalesEntry.Quantity, SalesEntry."Unit of Measure") +
                                        ' ' + GenPosFunc."Multiple Items Symbol";
                            Value[1] := Value[1] + POSFunctions.FormatPricePrUnit(SalesEntry.Price, SalesEntry."Unit of Measure");
                        END ELSE BEGIN
                            IF SalesEntry."Unit of Measure" = '' THEN
                                SalesEntry."Unit of Measure" := 'Pcs';
                            IF (SalesEntry."UOM Quantity" <> 0) THEN BEGIN
                                SalesEntry.Quantity := SalesEntry."UOM Quantity";
                                SalesEntry.Price := SalesEntry."UOM Price";
                            END;
                            Value[1] := POSFunctions.FormatQty(-SalesEntry.Quantity) +
                                        ' ' + GenPosFunc."Multiple Items Symbol" + ' ';
                            Value[2] := POSFunctions.FormatPrice(SalesEntry.Price);
                        END;
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));
                    END ELSE BEGIN
                        DSTR1 := '#L######################################';
                        Value[1] := SalesEntry."Item No.";
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));

                        DSTR1 := '#L######################################';
                        Value[1] := ItemName;
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));

                        IF ItemName2 <> '' THEN BEGIN
                            DSTR1 := '#L######################################';
                            Value[1] := ItemName2;
                            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));
                        END;

                        IF SalesEntry."Serial No." <> '' THEN BEGIN
                            DSTR1 := '#L##############################      ';
                            Value[1] := SalesEntry."Serial No.";
                            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));
                        END;

                        if SalesEntry.mc_hp <> '' then begin
                            DSTR1 := '#L######################################';
                            Value[1] := SalesEntry.mc_name + '(' + SalesEntry.mc_hp + ')';
                            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));
                        end;

                        DSTR1 := '#R## #R######### #R####### #R###########';
                        Value[1] := POSFunctions.FormatAmount(-SalesEntry.Quantity);
                        Value[2] := POSFunctions.FormatAmount(SalesEntry.Price);
                        Value[3] := POSFunctions.FormatAmount(-SalesEntry."Line Discount");
                        Value[4] := POSFunctions.FormatAmount(-SalesLineAmount);
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, (SalesEntry."Periodic Discount" <> 0), FALSE, FALSE));
                    END;
                END;
                totalCustItemDisc := totalCustItemDisc + SalesEntry."Infocode Discount";

                i := 0;
                j := 0;
                IF VATSetup.GET(SalesEntry."VAT Code") THEN BEGIN
                    REPEAT
                        i := i + 1;
                        IF j = 0 THEN
                            IF VATCode[i] = '' THEN
                                j := i;
                    UNTIL (VATCode[i] = VATSetup."VAT Code") OR (i >= 5);
                    IF VATCode[i] <> VATSetup."VAT Code" THEN BEGIN
                        i := j;
                        VATPerc[i] := VATSetup."VAT %";
                        VATCode[i] := VATSetup."VAT Code";
                    END;
                    VATAmount[i] := VATAmount[i] + SalesEntry."VAT Amount";
                    SalesAmountVAT[i] := SalesAmountVAT[i] + SalesEntry."Net Amount" + SalesEntry."VAT Amount";
                END;
            UNTIL SalesEntry.NEXT = 0;
            PrintSeperator2(Sender, Tray, '=');
        END;

        BanyakItem := ROUND(totalNumberOfItems, 1, '>');
        ItemKembali := ROUND(totalReturnItems, 1, '>');

        IF Transaction."Transaction Type" = Transaction."Transaction Type"::Sales THEN
            PrintTotal(Sender, Transaction, Tray, 0, BanyakItem, ItemKembali);

        TransInfoEntry.SETRANGE("Store No.", Transaction."Store No.");
        TransInfoEntry.SETRANGE("POS Terminal No.", Transaction."POS Terminal No.");
        TransInfoEntry.SETRANGE("Transaction No.", Transaction."Transaction No.");
        TransInfoEntry.SETRANGE("Transaction Type", TransInfoEntry."Transaction Type"::"Sales Entry");
        IF TransInfoEntry.FINDSET THEN
            REPEAT
                IF NOT infocode.GET(TransInfoEntry.Infocode) THEN
                    infocode.INIT;

                IF infocode."Print Input on Receipt" THEN BEGIN
                    DSTR1 := '#L##################################';
                    Value[1] := TransInfoEntry.Information;
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, FALSE, FALSE, FALSE));
                END;
            UNTIL TransInfoEntry.NEXT = 0;

        POSTerminal.GET(Transaction."POS Terminal No.");

        IF POSTerminal."Print Total Savings" AND (totalSavings <> 0) THEN BEGIN
            CLEAR(Value);
            DSTR1 := '#L####################### #R#########';
            Value[1] := 'Anda Hemat :';
            Value[2] := POSFunctions.FormatAmount(totalSavings);
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, FALSE, FALSE, FALSE));
            Sender.PrintSeperator(Tray);
        END;

        IF PosSetup."Print Discount Detail" THEN BEGIN
            DSTR1 := '#L################# #R###############   ';
            discountSection := FALSE;
            IF (PerDiscOffArrCount > 0) THEN BEGIN
                Sender.PrintLine(Tray, Sender.FormatLine(COPYSTR('Discount Details', 1, LineLen), FALSE, FALSE, FALSE, FALSE));
                discountSection := TRUE;
            END;

            FOR i := 1 TO PerDiscOffArrCount DO BEGIN
                maxCounter := 0;
                MixMatchEntry.SETRANGE("Store No.", SalesEntry."Store No.");
                MixMatchEntry.SETRANGE("POS Terminal No.", SalesEntry."POS Terminal No.");
                MixMatchEntry.SETRANGE("Transaction No.", SalesEntry."Transaction No.");
                IF MixMatchEntry.FIND('-') THEN
                    REPEAT
                        IF MixMatchEntry."Mix & Match Group" = PerDiscOffArr[i] THEN
                            IF MixMatchEntry.Counter > maxCounter THEN
                                maxCounter := MixMatchEntry.Counter;
                    UNTIL MixMatchEntry.NEXT = 0;

                IF PeriodicDiscount.GET(PerDiscOffArr[i]) THEN BEGIN
                    IF maxCounter = 0 THEN
                        Value[1] := PeriodicDiscount.Description
                    ELSE
                        Value[1] := FORMAT(maxCounter) + 'x ' + PeriodicDiscount.Description;
                END ELSE
                    Value[1] := FORMAT(PeriodicDiscount.Type);
                Value[2] := POSFunctions.FormatAmount(PerDiscOffAmtArr[i]);
                Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, FALSE, FALSE, FALSE));
            END;
        END;

        IF discountSection THEN
            PrintSeperator2(Sender, Tray, '=');

        glTrans.INIT;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnBeforePrintLoyalty', '', false, false)]
    local procedure BeforePrintLoyalty(Sender: Codeunit "POS Print Utility"; var Transaction: Record "Transaction Header"; var PrintBuffer: Record "POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var DSTR1: Text[100]; var IsHandled: Boolean)
    var
        RetailSetup: Record "Retail Setup";
        MemberClubTemp_l: Record "Member Club";
        TransPointEntry: Record "Trans. Point Entry";
        MemberCardTemp_l: Record "Membership Card";
        MemberAccount: Record "Member Account";
        IssuedPoints: Decimal;
        UsedPoints: Decimal;
        MemberText: Text[50];
        MemberNo: Text[50];
        MsgText: Text[250];
        RestponseCode: Code[30];
        ErrorText: Text;
        POSFunctions: Codeunit "POS Functions";
        lText000: Label ' pts';
        lText001: Label 'Issued';
        lText002: Label 'Status ';
        lText010: Label 'Member Account %1.';
        lText011: Label 'Membership Card %1.';
        lText012: Label 'Issued Points: %1';
        lText013: Label 'Used Points..: %1';
        lText014: Label 'Point Balance: %1';
        lText015: Label 'You will receive a new coupon';
        lText016: Label 'You will receive %1 new coupons';
        NodeName: array[32] of Text[50];
        Value: array[10] of Text[80];
        Tray: Integer;
    begin
        Tray := 2;
        IF Transaction."Member Card No." = '' THEN
            exit;
        if not MemberCardTemp_l.Get(Transaction."Member Card No.") then
            exit;
        if not MemberAccount.Get(MemberCardTemp_l."Account No.") then
            exit;
        IF not MemberClubTemp_l.Get(MemberAccount."Club Code") THEN
            EXIT;
        if (MemberClubTemp_l."Show Points on Receipt" = MemberClubTemp_l."Show Points on Receipt"::No) then
            exit;

        RetailSetup.GET;
        IF MemberClubTemp_l.Code = RetailSetup."NM Club Code" THEN BEGIN
            DSTR1 := '#L######################################';
            Value[1] := MemberClubTemp_l.Description;
            NodeName[1] := 'Member Club Name';
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

            DSTR1 := '#L############# #R######################';
            Value[1] := 'Name';
            NodeName[1] := 'name';
            Value[2] := MemberAccount.Description;
            NodeName[2] := 'name';
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

            Value[1] := 'Phone';
            NodeName[1] := 'phone';
            Value[2] := MemberCardTemp_l."Card No.";
            NodeName[2] := 'phone';
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

            PrintSeperator2(Sender, Tray, '=');
        END;

        TransPointEntry.SETRANGE("Store No.", Transaction."Store No.");
        TransPointEntry.SETRANGE("POS Terminal No.", Transaction."POS Terminal No.");
        TransPointEntry.SETRANGE("Transaction No.", Transaction."Transaction No.");
        IF TransPointEntry.FINDSET THEN
            REPEAT
                IF TransPointEntry."Entry Type" = TransPointEntry."Entry Type"::Sale THEN
                    IssuedPoints := IssuedPoints + TransPointEntry.Points
                ELSE
                    UsedPoints := UsedPoints - TransPointEntry.Points;
            UNTIL TransPointEntry.NEXT = 0;

        IF (Transaction."Starting Point Balance" = 0) AND (IssuedPoints = 0) AND (UsedPoints = 0) THEN
            EXIT;

        IF MemberCardTemp_l."Account No." <> '' THEN BEGIN
            MemberText := STRSUBSTNO(lText010, '');
            MemberNo := MemberCardTemp_l."Account No.";
        END ELSE BEGIN
            MemberText := STRSUBSTNO(lText011, '');
            MemberNo := Transaction."Member Card No.";
        END;

        DSTR1 := '#L######################## #R###########';
        CASE MemberClubTemp_l."Show Points on Receipt" OF
            MemberClubTemp_l."Show Points on Receipt"::"Issued Points":
                BEGIN
                    IF (IssuedPoints <> 0) OR (UsedPoints <> 0) THEN BEGIN
                        Value[1] := STRSUBSTNO(lText012, '');
                        NodeName[1] := 'Issued Points';
                        Value[2] := FORMAT(IssuedPoints);
                        NodeName[2] := 'Issued Points';
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

                        Value[1] := STRSUBSTNO(lText013, '');
                        NodeName[1] := 'Used Points';
                        Value[2] := FORMAT(UsedPoints);
                        NodeName[2] := 'Used Points';
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                    END;
                END;
            MemberClubTemp_l."Show Points on Receipt"::"Point Summary":
                BEGIN
                    Value[1] := STRSUBSTNO(lText012, '');
                    NodeName[1] := 'Issued Points';
                    Value[2] := FORMAT(IssuedPoints);
                    NodeName[2] := 'Issued Points';
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

                    Value[1] := STRSUBSTNO(lText013, '');
                    NodeName[1] := 'Used Points';
                    Value[2] := FORMAT(UsedPoints);
                    NodeName[2] := 'Used Points';
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

                    Value[1] := STRSUBSTNO(lText014, '');
                    NodeName[1] := 'Point Balance';
                    Value[2] := FORMAT(Transaction."Starting Point Balance" + IssuedPoints - UsedPoints);
                    NodeName[2] := 'Point Balance';
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                END;
        END;

        PrintSeperator2(Sender, Tray, '=');
        IsHandled := true;
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

    local procedure PrintTotal(Var Sender: Codeunit "POS Print Utility"; Transaction: Record "Transaction Header"; Tray: Integer; RightIndent: Integer; BanyakItem: Integer; ItemKembali: Integer)
    var
        DSTR1: Text[50];
        NodeName: array[32] of Text[50];
        Value: array[10] of Text[80];
        LineLen: Integer;
        InvLineLen: Integer;
        SecTotal: Decimal;
        CurrencyExchRate: Record "Currency Exchange Rate";
        Total: Decimal;
        POSTerminal: Record "POS Terminal";
        Currency: Record Currency;
        POSFunctions: Codeunit "POS Functions";
        GenPosFunc: Record "POS Functionality Profile";
    begin
        CLEAR(Value);
        CLEAR(Currency);

        Total := -Transaction."Gross Amount" - Transaction."Income/Exp. Amount";

        IF GenPosFunc."Display Secondary Total Curr" AND (GenPosFunc."Secondary Total Currency" <> '') THEN BEGIN
            IF NOT Currency.GET(GenPosFunc."Secondary Total Currency") THEN
                CLEAR(Currency);
            SecTotal := ROUND(CurrencyExchRate.ExchangeAmtFCYToFCY(Transaction.Date, Transaction."Trans. Currency", Currency.Code,
                              Total), Currency."Amount Rounding Precision");
        END;

        CLEAR(Value);
        DSTR1 := '#L######################## #R###########';
        DSTR1 := COPYSTR(DSTR1, 1, STRLEN(DSTR1) - RightIndent);
        IF Transaction."Total Discount" <> 0 THEN BEGIN
            Value[1] := 'SUBTOTAL';
            Value[2] := POSFunctions.FormatAmount(-Transaction."Gross Amount" + Transaction."Total Discount");
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
            Value[1] := 'Total disc.';
            Value[2] := POSFunctions.FormatAmount(-Transaction."Total Discount");
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        END;

        CLEAR(Value);
        DSTR1 := '#L######################## #R###########';
        DSTR1 := COPYSTR(DSTR1, 1, STRLEN(DSTR1) - RightIndent);
        Value[1] := 'GRAND TOTAL ' + Globals.GetValue('CURRSYM');
        Value[2] := POSFunctions.FormatAmount(Total);
        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));

        IF NOT Transaction."Post as Shipment" THEN
            PrintPaymentInfo(Sender, Transaction, Tray);

        IF NOT POSTerminal.GET(Transaction."POS Terminal No.") THEN
            POSTerminal.INIT;
        IF POSTerminal."Print Number of Items" THEN BEGIN
            CLEAR(Value);
            DSTR1 := '#L######################## #R###########';
            DSTR1 := COPYSTR(DSTR1, 1, STRLEN(DSTR1) - RightIndent);
            Value[1] := 'TOTAL ITEM';
            IF ItemKembali <> 0 THEN
                Value[2] := '-' + POSFunctions.FormatQty(ItemKembali) + '/';
            IF BanyakItem <> 0 THEN
                Value[2] := Value[2] + POSFunctions.FormatQty(BanyakItem);
            Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
        END;

        DSTR1 := '#L########## #R######### #R#############';
        DSTR1 := COPYSTR(DSTR1, 1, STRLEN(DSTR1) - RightIndent);

        PrintSeperator2(Sender, Tray, '=');
    end;

    local procedure PrintPaymentInfo(Var Sender: Codeunit "POS Print Utility"; Transaction: Record "Transaction Header"; Tray: Integer)
    var
        PaymEntry: Record "Trans. Payment Entry";
        Tendertype: Record "Tender Type";
        Tendercard: Record "Tender Type Card Setup";
        Currency: Record Currency;
        TransInfoCode: Record "Trans. Infocode Entry";
        GenPosFunc: Record "POS Functionality Profile";
        POSFunctions: Codeunit "POS Functions";
        DSTR1: Text[100];
        DSTR2: Text[100];
        Payment: Text[30];
        tmpStr: Text[50];
        i: Integer;
        CouponEntry: Record "Trans. Coupon Entry";
        SkipPrint_l: Boolean;
        Value: array[10] of Text[80];
    begin
        DSTR1 := '#L######## #L############# #R###########';
        CLEAR(PaymEntry);
        PaymEntry.SETRANGE("Store No.", Transaction."Store No.");
        PaymEntry.SETRANGE("POS Terminal No.", Transaction."POS Terminal No.");
        PaymEntry.SETRANGE("Transaction No.", Transaction."Transaction No.");
        IF PaymEntry.FIND('-') THEN BEGIN
            REPEAT
                CLEAR(Value);
                Payment := PaymEntry."Tender Type";
                SkipPrint_l := FALSE;
                IF Tendertype.GET(PaymEntry."Store No.", PaymEntry."Tender Type") THEN BEGIN
                    IF PaymEntry."Change Line" AND (Tendertype."Change Line on Receipt" <> '') THEN
                        Payment := Tendertype."Change Line on Receipt"
                    ELSE
                        Payment := Tendertype.Description;
                END
                ELSE
                    CLEAR(Tendertype);
                IF NOT SkipPrint_l THEN BEGIN
                    IF PaymEntry."Card No." = '' THEN
                        Value[1] := Payment
                    ELSE BEGIN
                        Value[1] := PaymEntry."Card No.";
                    END;
                    Value[2] := PaymEntry."Card or Account";
                    Value[3] := POSFunctions.FormatAmount(-PaymEntry."Amount Tendered");
                    Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                    IF Tendertype."Foreign Currency" THEN BEGIN
                        IF PaymEntry."Amount in Currency" = 0 THEN
                            PaymEntry."Amount in Currency" := 1;
                        Currency.GET(PaymEntry."Currency Code");
                        DSTR2 := '  #L###### #L####################       ';
                        Value[1] := Currency.Code;
                        Value[2] := POSFunctions.FormatCurrency(-PaymEntry."Amount in Currency", PaymEntry."Currency Code") +
                                ' @ ' + POSFunctions.FormatAmount(PaymEntry."Amount Tendered" / PaymEntry."Amount in Currency");
                        Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR2), FALSE, TRUE, FALSE, FALSE));
                    END;
                END;
            UNTIL PaymEntry.NEXT = 0;

            IF Transaction.Rounded <> 0 THEN BEGIN
                Sender.PrintLine(Tray, '');
                DSTR1 := '#L######################## #R###########';
                Value[1] := 'Rounding';
                Value[2] := POSFunctions.FormatAmount(Transaction.Rounded);
                Sender.PrintLine(Tray, Sender.FormatLine(Sender.FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
            END;
        END;
    end;

    local procedure PrintSeperator2(Var Sender: Codeunit "POS Print Utility"; Tray: Integer; SeparatorChar: Text)
    var
        LineLength: Integer;
        DSTR1: Text;
        Value: array[10] of Text[80];
        LineLen: Integer;
        InvLineLen: Integer;
    begin
        LineLen := 40;
        InvLineLen := 44;
        IF Tray = 2 THEN
            LineLength := LineLen
        ELSE
            IF Tray = 4 THEN
                LineLength := InvLineLen;

        DSTR1 := '#C' + Sender.StringPad('#', LineLength - 2);
        Value[1] := Sender.StringPad(SeparatorChar, LineLength);
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