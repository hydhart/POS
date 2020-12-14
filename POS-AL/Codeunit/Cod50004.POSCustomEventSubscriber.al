codeunit 50004 "POS Custom Event Subscriber"
{
    SingleInstance = true;

    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction", 'OnItemNoPressed', '', false, false)]
        local procedure OnItemNoPressed(var Handled: Boolean; REC: Record "POS Transaction"; CurrInput: Text)
        var
            posTransLine: Record "POS Trans. Line";
            Item: Record Item;
            posGUI: Codeunit "EPOS Control Interface";
        begin
            if InputAltered then
                Message(CurrInput);
            InputAltered := false;
        end;
    */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnBeforeTotalExecuted', '', false, false)]
    local procedure OnBeforeTotalExecuted(var POSTransaction: Record "POS Transaction")
    begin
        ErrorSalesStaff := false;
        if POSTransaction."Sales Staff" = '' then begin
            ErrorSalesStaff := true;
            Message('Please assign SPG for this transaction to continue...');
        end;
        //CodPOSTrans.OpenNumericKeyboard('New Input', 0, '', 2);
        //CodPOSTrans.OpenNumericKeyboard('Input', 0, '', 1);
        //InputAltered := true;
        //CodPOSTrans.MessageBeep('test');
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
                //Clear(CurrInput);
                //CodPOSTrans.SetCurrInput(CurrInput);
                if RetailSetup."NM Phone Info" = Infocode.Code then
                    CodPOSTrans.MessageBeep(STRSUBSTNO('Membership card %1 already applied', POSTransaction."Member Card No."));
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnAfterCheckInfoCode', '', false, false)]
    local procedure AfterCheckInfocode(var POSTransaction: Record "POS Transaction"; var Infocode: Record Infocode)
    var
        RetailSetup: Record "Retail Setup";
        InfoEntry: Record "POS Trans. Infocode Entry";
        Input: text;
    begin
        /*
        RetailSetup.Get();
        if RetailSetup."NM Phone Info" = Infocode.Code then begin
            if POSTransaction."Member Card No." = '' then begin
                InfoEntry.SetRange("Receipt No.", POSTransaction."Receipt No.");
                InfoEntry.SetRange("Transaction Type", POSTransaction."Transaction Type");
                InfoEntry.SetRange(Infocode, Infocode.Code);
                if InfoEntry.FindFirst() then begin
                    CurrInput := InfoEntry.Information;
                    POSTransaction.Validate("Member Card No.", CurrInput);
                    POSTransaction.Modify();
                    CodPOSTrans.MessageBeep(STRSUBSTNO('Membership card %1 found and applied', CurrInput));
                end else
                    CodPOSTrans.CancelPressed(false, 0);
            end else
                CodPOSTrans.MessageBeep(STRSUBSTNO('Membership card %1 already applied', POSTransaction."Member Card No."));
        end;
        */
        /*
        Commit();
        RetailSetup.Get();
        if RetailSetup."NM Phone Info" = Infocode.Code then begin
            if POSTransaction."Member Card No." = '' then begin
                InfoEntry.SetRange("Receipt No.", POSTransaction."Receipt No.");
                InfoEntry.SetRange(Infocode, Infocode.Code);
                if InfoEntry.FindFirst() then begin
                    Input := InfoEntry.Information;
                end;
                Message(STRSUBSTNO('Membership card %1 found and applied', Input));
            end;
        end;
        */
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
        RetailSetup.Reset();
        if RetailSetup.FindFirst() then
            RetailSetup.Init();
        Message(RetailSetup."NM Phone Info");
        /*
        RetailSetup.Get();
        if Transaction."Member Card No." <> '' then begin
            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Phone Info");
            if POSInfoEntry.FINDFIRST then
                POSInfoEntry.DELETE;

            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Name Info");
            if POSInfoEntry.FINDFIRST then
                POSInfoEntry.DELETE;
        end else begin
            POSInfoEntry.SETRANGE(Infocode, RetailSetup."NM Phone Info");
            if POSInfoEntry.FINDFIRST then begin
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

                Transaction."Member Card No." := MembershipCard."Card No.";
            end;
        end;
        */
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

    var
        Globals: Codeunit "POS Session";
        CodPOSTrans: Codeunit "POS Transaction";
        ErrorSalesStaff: Boolean;
        InputAltered: Boolean;
}