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
        /*ErrorSalesStaff := false;
        if POSTransaction."Sales Staff" = '' then begin
            ErrorSalesStaff := true;
            Message('Please assign SPG for this transaction to continue...');
        end;*/
        //CodPOSTrans.OpenNumericKeyboard('New Input', 0, '', 2);
        //CodPOSTrans.OpenNumericKeyboard('Input', 0, '', 1);
        //InputAltered := true;
        //CodPOSTrans.MessageBeep('test');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Transaction Events", 'OnAfterTotalExecuted', '', false, false)]
    local procedure OnAfterTotalExecuted()
    begin
        /*if ErrorSalesStaff then begin
            CodPOSTrans.SetPOSState('SALES');
            CodPOSTrans.SetFunctionMode('ITEM');
            CodPOSTrans.SelectDefaultMenu;
        end;*/
    end;

    var
        CodPOSTrans: Codeunit "POS Transaction";
        ErrorSalesStaff: Boolean;
        InputAltered: Boolean;
}