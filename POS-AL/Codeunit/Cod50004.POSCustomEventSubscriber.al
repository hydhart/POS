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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Post Utility", 'OnAfterInsertTransHeader', '', false, false)]
    local procedure AfterInsertTransHeader(var Transaction: Record "Transaction Header"; var POSTrans: Record "POS Transaction")
    begin
        Transaction."Sales Staff" := POSTrans."Sales Staff";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Post Utility", 'SalesEntryOnBeforeInsert', '', false, false)]
    local procedure BeforeInsertSalesEntry(var pPOSTransLine: Record "POS Trans. Line"; var pTransSalesEntry: Record "Trans. Sales Entry")
    begin
        pTransSalesEntry."Sales Staff" := pPOSTransLine."Sales Staff";
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