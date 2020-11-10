codeunit 50000 "Modern Channel Mgt"
{
    procedure testRunPing()
    var
        requestURL: Text;
        response: Text;
        httpResponse: HttpResponseMessage;
        JObject: JsonObject;
    begin
        initializeData;
        getSetup(channelID, storeID);
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
        initializeData;
        getSetup(channelID, storeID);
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
        initializeData;
        getSetup(channelID, storeID);
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
        rescode: Text;
    begin
        initializeData;
        getSetup(channelID, storeID);
        requestURL := orderURL();
        response := httpCall(requestURL);
        writeLog(response, requestURL);

        jObject.ReadFrom(response);
        JObject.Get('rescode', JToken);
        JToken.WriteTo(rescode);
        JObject.Get('server_trxid', JToken);
        JToken.WriteTo(serverTrxID);

        if rescode = '4' then begin
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
        initializeData;
        getSetup(channelID, storeID);
        requestURL := inquiryURL();
        response := httpCall(requestURL);

        jObject.ReadFrom(response);
        writeLog(response, requestURL);
    end;

    local procedure getSetup(channelID: Text; storeID: Text)
    begin
        modernChannelSetup.Get(channelID, storeID);
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
        mcLogEntry."Log Date" := Today;
        mcLogEntry."Log Time" := Time;
        mcLogEntry."Channel ID" := channelID;
        mcLogEntry."Store ID" := storeID;
        mcLogEntry."POS ID" := posID;
        mcLogEntry."Cashier ID" := cashierID;
        mcLogEntry.VType := vtype;
        mcLogEntry.Command := command;
        mcLogEntry.Signature := signature;
        mcLogEntry.URL := CopyStr(requestURL, 1, 250);
        mcLogEntry."URL 2" := CopyStr(requestURL, 250);
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
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
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
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
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
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&storeid=' + storeID + '&posid=' + posID + '&cashierid=' +
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
        partnerTrxID := 'p91';
        //GET REQUEST URL
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&password=' + signature + '&cmd=' +
        Format(command) + '&hp=' + handphone + '&vtype=' + vtype + '&trxtime=' +
        Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID + '&storeid=' + storeID + '&idpel=' + handphone + '&f=json';

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
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&password=' + signature + '&cmd=' +
        Format(command::confirm) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&partner_trxid=' + partnerTrxID +
        '&order_trxid=' + serverTrxID + '&storeid' + storeID + '&f=json';

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
        firstHash := modernChannelSetup.PIN + modernChannelSetup."Secret Key" + serverTrxID + partnerTrxID;
        secondHash := channelID + storeID + posID + Format(CurrentDateTime, 0, formatDate);
        signature := getSignature(firstHash, secondHash);

        requestURL := modernChannelSetup.URL + 'channelid=' + channelID + '&posid=' + posID + '&password=' + signature +
        '&cmd=' + Format(command) + '&trxtime=' + Format(CurrentDateTime, 0, formatDate) + '&server_trxid=' + partnerTrxID +
        '&storeid=' + storeID + '&cashierid=' + cashierID + '&f=json';

        exit(requestURL);
    end;

    local procedure initializeData()
    begin
        channelID := 'planetgadget';
        storeID := 'a001';
        posID := 'pos01';
        cashierID := 'csh01';
        //vtype := 'PLGS5'; pulsa prepaid
        vtype := 'HALO';
        handphone := '081210753300';
        partnerTrxID := 'p000001';
        serverTrxID := '';
        subscriberID := '';
    end;

    var
        modernChannelSetup: Record "Modern Channel Setup";
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
}
