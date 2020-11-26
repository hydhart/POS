codeunit 50001 "LS Central Event Subscriber"
{
    //#region Post

    //>> TO01.01
    //HY01
    /* IF (Store."Server Address" <> '') AND (Store."Server Port" <> 0) THEN BEGIN
        IF (Item."Modern Channel Item No." <> '') AND (POSTransLineTmp.Quantity >0) THEN BEGIN
          IF Item."MC Item Type" = Item."MC Item Type"::Telp THEN BEGIN
            IF MCFunction.ConfirmTopup(POSTransLineTmp, XMLDoc) THEN BEGIN
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'server_trxid');
    SalesEntry.mc_confirm_trxid := XMLValue;
    SalesEntry.mc_vtype := POSTransLineTmp.mc_vtype;
    SalesEntry.mc_hp := POSTransLineTmp.mc_hp;

    IF (MCFunction.GetNodeInnerText(XMLDoc, 'rescode')='4') THEN
                SN := MCFunction.GetNodeInnerText(XMLDoc, 'sn');
    //HY01
    SalesEntry.mc_sn := SN;
    //HY01
    ServerTrxID := MCFunction.GetNodeInnerText(XMLDoc, 'server_trxid');
    IF (SN <> '0') AND (SN <> ServerTrxID) THEN
                  SalesEntry.mc_success := TRUE;
            END ELSE BEGIN
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'scrmessage');
              ERROR(STRSUBSTNO('Topup failed/Error message: %1',XMLValue));
            END;
          END ELSE BEGIN
            IF MCFunction.ConfirmOrder(POSTransLineTmp, XMLDoc) THEN BEGIN
              SalesEntry.mc_vtype := POSTransLineTmp.mc_vtype;
              SalesEntry.mc_subscriber_id := POSTransLineTmp.mc_subscriber_id;
              SalesEntry.mc_hp := POSTransLineTmp.mc_hp;
              SalesEntry.mc_subscriber_name := POSTransLineTmp.mc_subscriber_name;
              SalesEntry.mc_alt_id := POSTransLineTmp.mc_alt_id;
              SalesEntry.mc_order_trxid := POSTransLineTmp.mc_order_trxid;
              SalesEntry.mc_confirm_trxid := POSTransLineTmp.mc_confirm_trxid;
              SalesEntry.mc_idpel := POSTransLineTmp.mc_idpel;
              SalesEntry.mc_name := POSTransLineTmp.mc_name;
              SalesEntry.mc_seg := POSTransLineTmp.mc_seg;
              SalesEntry.mc_pcc := POSTransLineTmp.mc_pcc;
              SalesEntry.mc_amount := POSTransLineTmp.mc_amount;
              SalesEntry.mc_adm := POSTransLineTmp.mc_adm;
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'server_trxid');
              SalesEntry.mc_confirm_trxid := XMLValue;
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'ext_data');
              SalesEntry.mc_ext_data := COPYSTR(XMLValue,1, 250);
              SalesEntry.mc_ext_data2 := COPYSTR(XMLValue,251, 250);
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'token');
              SalesEntry.mc_token := XMLValue;
              SalesEntry.mc_success := (MCFunction.GetNodeInnerText(XMLDoc, 'rescode')='4');
            END ELSE BEGIN
              XMLValue := MCFunction.GetNodeInnerText(XMLDoc, 'scrmessage');
              ERROR(STRSUBSTNO('Confim Order failed/Error message: %1',XMLValue));
            END;
          END;
        END;
      END; */
    //HY01
    //<< TO01.01
    //#endregion Post

    /* 
        //#region Print
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"POS Print Utility", 'OnAfterPrintSalesSlip', '', false, false)]
        local procedure OnAfterPrintSalesSlip(var TransactionHeader: Record "Transaction Header"; var PrintBufferIndex: Integer; var POSPrintBuffer: Record "POS Print Buffer"; var LinesPrinted: Integer; sender: Codeunit "POS Print Utility")
        begin

        end;

        local procedure PrintModernChannelSlip(): Boolean
        var
            POSTerminal: Record "POS Terminal";
        begin
            //PrintModernChannelSlip
            IF NOT POSTerminal.GET(Globals.TerminalNo) THEN
                EXIT(TRUE);

            IF NOT OpenReceiptPrinter(2, 'MC', '', Transaction."Transaction No.", Transaction."Receipt No.") THEN
                EXIT(FALSE);
            PrintLine(2, '');
            PrintSeperator(2);  //
            PrintModernChannelInfo(Transaction);

            IF NOT ClosePrinter(2) THEN
                EXIT(FALSE);
            COMMIT;
            EXIT(TRUE);
        end;
        //PrintModernChannelSlip

        local procedure PrintModernChannelInfo(TransHeader: Record "Transaction Header")
        var
            TransSalesEntry: Record "Trans. Sales Entry";
            Item: Record Item;
        begin
            //PrintModernChannelInfo
            TransSalesEntry.SETRANGE("Store No.", TransHeader."Store No.");
            TransSalesEntry.SETRANGE("POS Terminal No.", TransHeader."POS Terminal No.");
            TransSalesEntry.SETRANGE("Transaction No.", TransHeader."Transaction No.");
            TransSalesEntry.SETFILTER(mc_vtype, '<>%1', '');
            IF TransSalesEntry.FINDSET THEN
                REPEAT
                    IF Item.GET(TransSalesEntry."Item No.") THEN BEGIN
                        IF Item."MC Item Type" = Item."MC Item Type"::Telp THEN BEGIN
                            PrintFromData(TransSalesEntry);
                        END ELSE
                            IF Item."MC Item Type" = Item."MC Item Type"::PLN THEN BEGIN
                                PrintFromExtData(TransSalesEntry.mc_ext_data + TransSalesEntry.mc_ext_data2);
                            END ELSE
                                IF Item."MC Item Type" = Item."MC Item Type"::PPOB THEN BEGIN
                                    PrintFromExtData(TransSalesEntry.mc_ext_data + TransSalesEntry.mc_ext_data2);
                                END;
                    END;
                UNTIL TransSalesEntry.NEXT = 0;
            PrintSeperator(2);
        end;

        local procedure PrintFromExtData(ExtData: Text)
        var
            DSTR1: Text;
            LineText: Text;
            Pos: Integer;
        begin
            IF STRLEN(ExtData) > 0 THEN
                REPEAT
                    DSTR1 := '#L######################################';
                    Pos := STRPOS(ExtData, '|');
                    IF Pos > 0 THEN BEGIN
                        LineText := DELCHR(COPYSTR(ExtData, 1, Pos - 1), '<>', ' '); // Delete leading and trailing space character
                        ExtData := COPYSTR(ExtData, Pos + 1);
                    END ELSE BEGIN
                        LineText := DELCHR(ExtData, '<>', ' '); // Delete leading and trailing space character
                        ExtData := '';
                    END;
                    IF LineText = '' THEN
                        PrintLine(2, '')
                    ELSE BEGIN
                        Value[1] := LineText;
                        NodeName[1] := 'MC Desc';
                        PrintLine(2, FormatLine(FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                        AddPrintLine(800, 2, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, 2);
                    END;
                UNTIL (ExtData = '');
        end;

        local procedure PrintFromData(TransSalesEntry: Record "Trans. Sales Entry")
        var
            myInt: Integer;
        begin
            DSTR1 := '#L######################################';

            IF (TransSalesEntry.mc_vtype <> '') THEN BEGIN
                //HY
                PrintLine(2, '');
                //HY
                Value[1] := STRSUBSTNO('VType : %1', TransSalesEntry.mc_vtype);
                NodeName[1] := 'MC Desc';
                PrintLine(2, FormatLine(FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                AddPrintLine(800, 2, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, 2);

                Value[1] := STRSUBSTNO('HP    : %1', TransSalesEntry.mc_hp);
                NodeName[1] := 'MC Desc';
                PrintLine(2, FormatLine(FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                AddPrintLine(800, 2, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, 2);

                Value[1] := STRSUBSTNO('SN    : %1', TransSalesEntry.mc_sn);
                NodeName[1] := 'MC Desc';
                PrintLine(2, FormatLine(FormatStr(Value, DSTR1), FALSE, TRUE, FALSE, FALSE));
                AddPrintLine(800, 2, NodeName, Value, DSTR1, FALSE, TRUE, FALSE, FALSE, 2);
            END;
        end;
        //#endregion Print
     */

}
