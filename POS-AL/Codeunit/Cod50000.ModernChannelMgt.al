codeunit 50000 "Modern Channel Mgt"
{
    #region Test Run
    procedure testRunPing()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        firstHash: Text;
        secondHash: Text;
    begin
        //initializeData('a001', 'pos01', 'csh01', 'HALO', '081312341234', 'p000001');00000P0001000000011
        initializeData('s0001', '10', 'HALO', '081312341234', '00000p0001000000011');
        getSetup();
        requestURL := pingTelURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);
        writeLog(response, requestURL);
    end;

    procedure testRunTopup()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
    begin
        initializeData('pos01', 'csh01', 'PLGS5', '081312341234', 'p000001');
        getSetup();
        requestURL := topUpURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);
        writeLog(response, requestURL);
    end;

    procedure testRunDenom()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
    begin
        initializeData('pos01', 'csh01', 'HALO', '081312341234', 'p000001');
        getSetup();
        requestURL := denomURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);
        writeLog(response, requestURL);
    end;

    procedure testRunOrder()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        JToken: JsonToken;
        JToken1: List of [JsonToken];
        JToken2: JsonToken;
        rescode: Text;
        tagihan: Text;
    begin
        getSetup();
        initializeData('pos01', 'csh01', 'HALO', '081312341234', 'p000001');
        requestURL := orderURL();
        response := httpCall(requestURL);
        writeLog(response, requestURL);

        JObject.ReadFrom(response);
        JObject.Get('server_trxid', JToken);
        JToken.WriteTo(serverTrxID);

        serverTrxID := DelChr(serverTrxID, '=', '"');

        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);

        if (rescode = '4') or (rescode = '0') then begin
            if not Confirm('Total Tagihan yang harus dibayar adalah sebesar %1.\Lanjut Bayar?', true, tagihan) then
                exit;
            requestURL := confirmURL();
            response := httpCall(requestURL);
            writeLog(response, requestURL);
        end;
    end;

    procedure testRunInquiry()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
    begin
        serverTrxID := '97721316';
        initializeData('s0001', '10', 'PLGS5', '081234445555', '00000P0001000000073');
        getSetup();
        requestURL := inquiryURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);
        writeLog(response, requestURL);
    end;
    #endregion Test Run

    procedure RunPing(POSTransaction: Record "POS Transaction")
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        firstHash: Text;
        secondHash: Text;
        JToken: JsonToken;
        status: Text;
    begin
        //initializeData('a001', 'pos01', 'csh01', 'HALO', '081312341234', 'p000001');00000P0001000000011
        initializeData(POSTransaction."Store No.", POSTransaction."Sales Staff", '', '', POSTransaction."Receipt No.");
        getSetup();
        requestURL := pingTelURL();
        response := httpCall(requestURL);
        jObject.ReadFrom(response);

        JObject.Get('scrmessage', JToken);
        JToken.WriteTo(status);
        scrmsg := status;
        writeLog(response, requestURL);
        Message(status);
    end;

    procedure RunTopUp(var POSTransLine: Record "POS Trans. Line"): Text
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        JToken: JsonToken;
        rescode: Text;
        sn: Text;
        amount: Text;
    begin
        requestURL := topUpURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);

        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);

        JObject.Get('server_trxid', JToken);
        JToken.WriteTo(serverTrxID);

        serverTrxID := DelChr(serverTrxID, '=', '"');
        case rescode of
            '4':
                begin
                    POSTransLine.mc_partner_trxid := POSTransLine."Receipt No.";

                    JObject.Get('sn', JToken);
                    JToken.WriteTo(sn);
                    POSTransLine.mc_sn := sn;
                    JObject.Get('harga', JToken);
                    JToken.WriteTo(amount);
                    POSTransLine.mc_amount := amount;
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    POSTransLine."PPOB Status" := rescode;
                    POSTransLine.Modify();
                    writeLog(response, requestURL);
                end;
            '0':
                begin
                    POSTransLine.mc_partner_trxid := POSTransLine."Receipt No.";

                    JObject.Get('harga', JToken);
                    JToken.WriteTo(amount);
                    POSTransLine.mc_amount := amount;
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    POSTransLine."PPOB Status" := rescode;
                    POSTransLine.Modify();
                    writeLog(response, requestURL);
                end;
            else begin
                    JObject.Get('resmessage', JToken);
                    JToken.WriteTo(resmsg);
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    writeLog(response, requestURL);
                    Error(scrmsg + '\' + resmsg);
                end;
        end;
        exit(rescode);
    end;

    procedure RunInquiry(var ppobLog: Record "Modern Channel Log Entry"): Text
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        JToken: JsonToken;
        rescode: Text;
        sn: Text;
        amount: Text;
    begin
        serverTrxID := DelChr(ppobLog."Server Trx ID", '=', '"');
        requestURL := inquiryURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);

        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);/* 
        case rescode of
            '4':
                begin
                    JObject.Get('resmessage', JToken);
                    JToken.WriteTo(scrmsg);
                end;
            '0':
                begin
                    JObject.Get('resmessage', JToken);
                    JToken.WriteTo(scrmsg);
                end;
            else begin
                    JObject.Get('resmessage', JToken);
                    JToken.WriteTo(scrmsg);
                end;
        end; */
        JObject.Get('resmessage', JToken);
        JToken.WriteTo(resmsg);
        JObject.Get('scrmessage', JToken);
        JToken.WriteTo(scrmsg);

        writeLog(response, requestURL);
        Message(resmsg);
        exit(rescode);
    end;

    procedure RunOrder(var POSTransLine: Record "POS Trans. Line")
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        JToken: JsonToken;
        struk: JsonObject;
        rescode: Text;
        sn: Text;
        amount: Decimal;
        operator: Text;
        harga: Text;
        InfocodeEntry: Record "POS Trans. Infocode Entry";
    begin
        requestURL := orderURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);

        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);
        case rescode of
            '4':
                begin
                    POSTransLine.mc_partner_trxid := POSTransLine."Receipt No.";
                    JObject.Get('harga', JToken);
                    JToken.WriteTo(harga);
                    POSTransLine.mc_amount := harga;
                    Evaluate(amount, harga);
                    POSTransLine.Validate(Price, amount);

                    JObject.Get('server_trxid', JToken);
                    JToken.WriteTo(serverTrxID);
                    serverTrxID := DelChr(serverTrxID, '=', '"');
                    POSTransLine.mc_server_trxid := serverTrxID;

                    JObject.Get('struk', JToken);
                    struk := JToken.AsObject();

                    struk.Get('name', JToken);
                    JToken.WriteTo(name);
                    POSTransLine.mc_name := name;
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);

                    Message('Total Tagihan sebesar %1, untuk nomor %2 atas nama %3', posTransLine.mc_amount, posTransLine.mc_hp, posTransLine.mc_name);
                end;
            '0':
                begin
                    POSTransLine.mc_partner_trxid := POSTransLine."Receipt No.";

                    JObject.Get('harga', JToken);
                    JToken.WriteTo(harga);
                    POSTransLine.mc_amount := harga;
                    Evaluate(amount, harga);
                    POSTransLine.Validate(Price, amount);
                    JObject.Get('server_trxid', JToken);
                    JToken.WriteTo(serverTrxID);
                    serverTrxID := DelChr(serverTrxID, '=', '"');
                    POSTransLine.mc_server_trxid := serverTrxID;

                    JObject.Get('struk', JToken);
                    struk := JToken.AsObject();

                    struk.Get('name', JToken);
                    JToken.WriteTo(name);
                    POSTransLine.mc_name := name;
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);

                    Message('Pesanan Dalam Proses. Silahkan lakukan Order ulang.');
                end;
            else begin
                    JObject.Get('resmessage', JToken);
                    JToken.WriteTo(resmsg);
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    POSTransLine.VoidLine();
                    InfocodeEntry.Reset();
                    InfocodeEntry.SetRange("Receipt No.", POSTransLine."Receipt No.");
                    if InfocodeEntry.FindFirst() then
                        InfocodeEntry.DeleteAll();
                    Message(resmsg);
                end;
        end;

        writeLog(response, requestURL);
    end;

    procedure RunConfirm(var POSTransLine: Record "POS Trans. Line")
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
        JToken: JsonToken;
        rescode: Text;
        sn: Text;
        amount: Text;
        operator: Text;
    begin
        serverTrxID := POSTransLine.mc_server_trxid;
        requestURL := confirmURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);

        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);
        case rescode of
            '4':
                begin
                    JObject.Get('sn', JToken);
                    JToken.WriteTo(sn);
                    POSTransLine.mc_sn := sn;
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    name := POSTransLine.mc_name;
                    POSTransLine."PPOB Status" := rescode;
                    writeLog(response, requestURL);
                end;
            else begin
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    JObject.Get('scrmessage', JToken);
                    JToken.WriteTo(scrmsg);
                    name := POSTransLine.mc_name;
                    POSTransLine."PPOB Status" := rescode;
                    writeLog(response, requestURL);
                    Error(scrmsg);
                end;
        end;
    end;

    local procedure getSetup()
    begin
        modernChannelSetup.Get();
    end;

    local procedure getStore(storeNo: Code[20])
    begin
        if not Store.Get(storeNo) then
            Error('Store %1 does not exist.', storeNo);
    end;

    local procedure writeLog(responsMsg: Text; requestURL: Text)
    var
        mcLogEntry: Record "Modern Channel Log Entry";
        entryNo: Integer;
        outStr: OutStream;
        tempBlob: Codeunit "Temp Blob";
    begin
        mcLogEntry.Reset();
        if mcLogEntry.FindLast() then
            entryNo := mcLogEntry."Entry No."
        else
            entryNo := 0;

        entryNo += 1;
        mcLogEntry.Init();
        mcLogEntry."Entry No." := entryNo;
        mcLogEntry."Receipt No." := partnerTrxID;
        mcLogEntry."Transaction Line No." := 0;
        mcLogEntry."Log Date" := Today;
        mcLogEntry."Log Time" := Time;
        mcLogEntry."Transaction Date" := Today;
        mcLogEntry."Transaction Time" := Time;
        mcLogEntry."Channel ID" := channelID;
        mcLogEntry."Store ID" := storeID;
        mcLogEntry."POS ID" := posID;
        mcLogEntry."Cashier ID" := cashierID;
        mcLogEntry.VType := vtype;
        mcLogEntry.Command := command;
        mcLogEntry.Signature := signature;
        mcLogEntry.URL := CopyStr(requestURL, 1, 250);
        mcLogEntry."URL 2" := CopyStr(requestURL, 250);
        mcLogEntry."Nama Pelanggan" := name;
        mcLogEntry."Status Message" := scrmsg;
        mcLogEntry.Handphone := handphone;
        mcLogEntry."Server Trx ID" := serverTrxID;
        mcLogEntry."Response Message".CreateOutStream(outStr);
        outStr.WriteText(responsMsg);
        mcLogEntry.Insert();
    end;

    local procedure getSignature(firstText: Text; secondText: Text): Text
    var
        CryptographyManagement: Codeunit "Cryptography Management";
        HashAlgorithmType: Option MD5,SHA1,SHA256,SHA384,SHA512;
        firstSign: Text;
        secondSign: Text;
        signatureText: Text;
        password: Text;
    begin
        //pin+server_secret_key+server_trxid+partner_trxid
        firstSign := CryptographyManagement.GenerateHash(firstText, HashAlgorithmType::MD5);

        //channel_id+store_id+pos_id+date_and_time
        secondSign := CryptographyManagement.GenerateHash(secondText, HashAlgorithmType::MD5);

        password := LowerCase(firstSign) + LowerCase(secondSign);
        signatureText := CryptographyManagement.GenerateHash(password, HashAlgorithmType::MD5);
        exit(LowerCase(signatureText));
    end;

    procedure httpCall(requestURL: Text): Text
    var
        httpClient: HttpClient;
        httpResponse: HttpResponseMessage;
        httpRequest: HttpRequestMessage;
        response: Text;
    begin
        //GET RESPONSE JSON from API
        httpRequest.Method('GET');
        httpRequest.SetRequestUri(LowerCase(requestURL));
        httpClient.Send(httpRequest, httpResponse);

        if not (httpResponse.HttpStatusCode = 200) then
            Error('Server not Found. URL: %1', requestURL);

        httpResponse.Content.ReadAs(response);

        exit(response);
    end;

    local procedure pingTelURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        //GET REQUEST URL
        command := command::pingtel;
        firstHash := PIN + SKey + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
        '&cmd=' + Format(command) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID +
        '&storeid=' + storeID + '&cashierid=' + cashierID + '&f=json';

        exit(requestURL);
    end;

    local procedure denomURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        //GET REQUEST URL
        command := command::denom;
        firstHash := PIN + SKey + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
        '&cmd=' + Format(command) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID +
        '&storeid=' + storeID + '&cashierid=' + cashierID + '&f=json';

        exit(requestURL);
    end;

    local procedure topUpURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        command := command::topup;
        //GET REQUEST URL        
        firstHash := PIN + SKey + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&storeid=' + storeID + '&posid=' + posID + '&cashierid=' +
           cashierID + '&password=' + signature + '&cmd=' + format(command) + '&hp=' + handphone + '&vtype=' + vtype + '&trxtime=' +
           Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID + '&f=json';

        exit(requestURL);
    end;

    local procedure orderURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        command := command::order;
        //GET REQUEST URL
        firstHash := PIN + SKey + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&storeid=' + storeID + '&posid=' + posID + '&cashierid=' +
                   cashierID + '&password=' + signature + '&cmd=' + format(command) + '&hp=' + handphone + '&vtype=' + vtype + '&trxtime=' +
                   Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID + '&idpel=' + handphone + '&f=json';
        /* requestURL := URL + '?' + 'channelid=' + channelID + '&password=' + signature + '&cmd=' +
        Format(command) + '&hp=' + handphone + '&vtype=' + vtype + '&trxtime=' +
        Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID + '&storeid=' + storeID + '&idpel=' + handphone + '&f=json'; */

        exit(requestURL);
    end;

    local procedure confirmURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        command := command::confirm;
        //GET REQUEST URL
        firstHash := PIN + SKey + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&password=' + signature + '&cmd=' +
        Format(command::confirm) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID +
        '&order_trxid=' + serverTrxID + '&storeid=' + storeID + '&posid=' + posID + '&cashierid=' + cashierID + '&f=json';

        exit(requestURL);
    end;

    local procedure inquiryURL(): Text
    var
        firstHash: Text;
        secondHash: Text;
        requestURL: Text;
    begin
        //GET REQUEST URL
        command := command::inquiry;
        firstHash := PIN + SKey + serverTrxID;
        //firstHash := PIN + SKey + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := URL + '?' + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
        '&cmd=' + Format(command) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&server_trxid=' + serverTrxID +
        '&storeid=' + storeID + '&cashierid=' + cashierID + '&f=json';

        exit(requestURL);
    end;

    procedure initializeData(pPosID: Text; pCashierID: Text; pVtype: Text; pHandphone: Text; pPartnerTrxID: Text)
    begin
        //getSetup();
        getStore(pPosID);
        /* channelID := LowerCase(modernChannelSetup."Channel ID");
        storeID := LowerCase(modernChannelSetup."Store ID");
        PIN := modernChannelSetup.PIN;
        SKey := modernChannelSetup."Secret Key";
        URL := modernChannelSetup.URL; */
        channelID := LowerCase(Store."Channel ID");
        storeID := LowerCase(Store."Store ID");
        PIN := Store.PIN;
        SKey := Store."Secret Key";
        URL := Store.URL;
        posID := LowerCase(pPosID);
        cashierID := LowerCase(pCashierID);
        vtype := pVtype;
        handphone := pHandphone;
        partnerTrxID := LowerCase(pPartnerTrxID);
        subscriberID := '';
    end;

    var
        modernChannelSetup: Record "Modern Channel Setup";
        Store: Record Store;
        formatDate: Label '<Year4><Month,2><Day,2><Hours,2><Minutes,2><Seconds,2>';
        channelID: Text;
        storeID: Text;
        posID: Text;
        cashierID: Text;
        command: Enum "MC Command";
        handphone: Text;
        vtype: Text;
        partnerTrxID: Text;
        serverTrxID: Text;
        subscriberID: Text;
        signature: Text;
        PIN: Text;
        SKey: Text;
        URL: Text;
        scrmsg: Text;
        resmsg: Text;
        name: Text;
}
