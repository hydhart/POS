codeunit 50005 "BC Custom Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure BeforeRunWithCheck(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var
        lItem: Record Item;
        itemTrackingCode: Record "Item Tracking Code";
    begin
        /*
        itemTrackingCode.INIT;
        IF lItem.GET(ItemJournalLine."Item No.") THEN
            IF (lItem."Item Tracking Code" <> '') THEN
                IF (NOT itemTrackingCode.GET(lItem."Item Tracking Code")) THEN
                    itemTrackingCode.INIT;

        IF (itemTrackingCode."SN Pos. Adjmt. Inb. Tracking" OR itemTrackingCode."SN Pos. Adjmt. Outb. Tracking") AND (ItemJournalLine."Quantity (Base)" <> 0) THEN BEGIN
            IJValidateSerialNoExist(ItemJournalLine);
        END;
        */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure AfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        NPM: Record "Nominal Payment Method";
        NPMIns: Record "Nominal Payment Method";
    begin
        NPM.RESET;
        NPM.SETRANGE("Document Type", NPM."Document Type"::Invoice);
        NPM.SETRANGE("Document No.", SalesInvHeader."No.");
        IF NOT NPM.FINDFIRST THEN BEGIN
            NPM.RESET;
            NPM.SETRANGE("Document Type", NPM."Document Type"::Order);
            NPM.SETRANGE("Document No.", SalesHeader."No.");
            IF NPM.FINDSET THEN BEGIN
                REPEAT
                    NPMIns.INIT;
                    NPMIns.TRANSFERFIELDS(NPM);
                    NPMIns."Document Type" := NPMIns."Document Type"::Invoice;
                    NPMIns."Document No." := SalesInvHeader."No.";
                    NPMIns.INSERT;
                UNTIL NPM.NEXT = 0;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckTrackingAndWarehouseForReceive', '', false, false)]
    local procedure AfterCheckTrackingAndWarehouseForReceive(var SalesHeader: Record "Sales Header"; var Receive: Boolean; CommitIsSuppressed: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        Item: Record Item;
        SalesLineToCheck: Record "Sales Line";
        ItemTrackingCode: Record "Item Tracking Code";
        ItemJnlLine: Record "Item Journal Line";
        ItemTrackingSetup: Record "Item Tracking Setup";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        Inbound: Boolean;
    begin
        /*
        if SalesHeader."Document Type" in
            [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"] = FALSE
        then
            exit;

        SalesLineToCheck.SetRange(Type, SalesLineToCheck.Type::Item);
        if SalesHeader.Ship then
            SalesLineToCheck.SetFilter("Quantity Shipped", '<>%1', 0)
        else
            SalesLineToCheck.SetFilter("Return Qty. Received", '<>%1', 0);
        SalesLineToCheck.SetRange("Quantity Shipped");
        if SalesLineToCheck.FindSet() then
            repeat
                Item.Get(SalesLineToCheck."No.");
                if Item."Item Tracking Code" <> '' then begin
                    Inbound := true;
                    ItemTrackingCode.Code := Item."Item Tracking Code";
                    ItemTrackingManagement.GetItemTrackingSetup(
                        ItemTrackingCode, ItemJnlLine."Entry Type"::Sale.AsInteger(), Inbound, ItemTrackingSetup);
                end;
                if ItemTrackingSetup."Serial No. Required" then
                    SalesValidateSerialNoExist(SalesLineToCheck);
            until SalesLineToCheck.Next() = 0;
        if SNConflict <> '' then
            Error('S/N (%1) had not been registered or Empty', SNConflict);
        */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckTrackingAndWarehouseForShip', '', false, false)]
    local procedure AfterCheckTrackingAndWarehouseForShip(var SalesHeader: Record "Sales Header"; var Ship: Boolean; CommitIsSuppressed: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; var TempSalesLine: Record "Sales Line")
    var
        Item: Record Item;
        SalesLineToCheck: Record "Sales Line";
        ItemTrackingCode: Record "Item Tracking Code";
        ItemJnlLine: Record "Item Journal Line";
        ItemTrackingSetup: Record "Item Tracking Setup";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        Inbound: Boolean;
    begin
        /*
        if SalesHeader."Document Type" in
            [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"] = FALSE
        then
            exit;

        SalesLineToCheck.SetRange(Type, SalesLineToCheck.Type::Item);
        if SalesHeader.Ship then
            SalesLineToCheck.SetFilter("Quantity Shipped", '<>%1', 0)
        else
            SalesLineToCheck.SetFilter("Return Qty. Received", '<>%1', 0);
        SalesLineToCheck.SetRange("Quantity Shipped");
        if SalesLineToCheck.FindSet() then
            repeat
                Item.Get(SalesLineToCheck."No.");
                if Item."Item Tracking Code" <> '' then begin
                    Inbound := false;
                    ItemTrackingCode.Code := Item."Item Tracking Code";
                    ItemTrackingManagement.GetItemTrackingSetup(
                        ItemTrackingCode, ItemJnlLine."Entry Type"::Sale.AsInteger(), Inbound, ItemTrackingSetup);
                end;
                if ItemTrackingSetup."Serial No. Required" then
                    SalesValidateSerialNoExist(SalesLineToCheck);
            until SalesLineToCheck.Next() = 0;
        if SNConflict <> '' then
            Error('S/N (%1) had not been registered or Empty', SNConflict);
        */
    end;

    local procedure ValidateSerialNo(ItemNo: Code[20]; VariantCode: Code[10]; StoreNo: Code[10]; SerialNo: Code[20]; Out: Boolean)
    var
        Store: Record Store;
        ILE: Record "Item Ledger Entry";
    begin
        Store.Get(StoreNo);
        ILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
        ILE.SetRange("Item No.", ItemNo);
        ILE.SetRange(Open, TRUE);
        ILE.SetRange("Variant Code", VariantCode);
        ILE.SetRange("Location Code", Store."Location Code");
        ILE.SetRange("Serial No.", SerialNo);

        if Out then begin
            IF ile.IsEmpty THEN
                Error('S/N (%1) not available for item no. %2 and location %3', SerialNo, ItemNo, Store."Location Code");
        end else begin
            if NOT ile.IsEmpty then
                Error('S/N (%1) already exist for item no. %2 and Location %3', SerialNo, ItemNo, Store."Location Code");
        end;
    end;

    local procedure IJValidateSerialNoExist(JnlLine: Record "Item Journal Line")
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ILE: Record "Item Ledger Entry";
    begin
        TrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
            "Source Prod. Order Line", "Source Ref. No.");
        TrackingSpecification.SetRange("Source ID", jnlLine."Journal Template Name");
        TrackingSpecification.SetRange("Source Type", DATABASE::"Item Journal Line");
        TrackingSpecification.SetRange("Source Subtype", jnlLine."Entry Type");
        TrackingSpecification.SetRange("Source Batch Name", jnlLine."Journal Batch Name");
        TrackingSpecification.SetRange("Source Prod. Order Line", 0);
        TrackingSpecification.SetRange("Source Ref. No.", jnlLine."Line No.");
        TrackingSpecification.SetRange(Correction, false);
        if TrackingSpecification.FindSet() then
            repeat
                ILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SetRange("Item No.", TrackingSpecification."Item No.");
                ILE.SetRange(Open, TRUE);
                ILE.SetRange("Serial No.", TrackingSpecification."Serial No.");
                ILE.SetRange("Location Code", TrackingSpecification."Location Code");
                if (jnlLine."Entry Type" = jnlLine."Entry Type"::"Positive Adjmt.") then begin
                    if NOT ILE.IsEmpty then
                        Error('S/N (%1) had been registered before', TrackingSpecification."Serial No.");
                end else
                    if (jnlLine."Entry Type" = jnlLine."Entry Type"::"Negative Adjmt.") then begin
                        if ILE.IsEmpty then
                            Error('S/N (%1) had not been registered or Empty', TrackingSpecification."Serial No.");
                    end;
            until TrackingSpecification.Next() = 0;

        ReservEntry.SetCurrentKey(
            "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
            "Source Batch Name", "Source Prod. Order Line");
        ReservEntry.SetRange("Source ID", jnlLine."Journal Template Name");
        ReservEntry.SetRange("Source Ref. No.", jnlLine."Line No.");
        ReservEntry.SetRange("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SetRange("Source Subtype", jnlLine."Entry Type");
        ReservEntry.SetRange("Source Batch Name", jnlLine."Journal Batch Name");
        ReservEntry.SetRange("Source Prod. Order Line", 0);
        ReservEntry.SetFilter("Serial No.", '<>%1', '');
        if ReservEntry.FINDSET then
            repeat
                ILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SetRange("Item No.", ReservEntry."Item No.");
                ILE.SetRange(Open, TRUE);
                ILE.SetRange("Serial No.", ReservEntry."Serial No.");
                ILE.SetRange("Location Code", ReservEntry."Location Code");
                if (jnlLine."Entry Type" = jnlLine."Entry Type"::"Positive Adjmt.") then begin
                    if not ILE.IsEmpty then
                        Error('S/N (%1) had been registered before', ReservEntry."Serial No.");
                end else
                    if (jnlLine."Entry Type" = jnlLine."Entry Type"::"Negative Adjmt.") then begin
                        if ILE.IsEmpty then
                            Error('S/N (%1) had not been registered or Empty', ReservEntry."Serial No.");
                    end;
            until ReservEntry.NEXT = 0;
    end;

    local procedure SalesValidateSerialNoExist(SalesLine: Record "Sales Line")
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ILE: Record "Item Ledger Entry";
    begin
        TrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                "Source Prod. Order Line", "Source Ref. No.");
        TrackingSpecification.SetRange("Source Type", DATABASE::"Sales Line");
        TrackingSpecification.SetRange("Source Subtype", SalesLine."Document Type");
        TrackingSpecification.SetRange("Source ID", SalesLine."Document No.");
        TrackingSpecification.SetRange("Source Batch Name", '');
        TrackingSpecification.SetRange("Source Prod. Order Line", 0);
        TrackingSpecification.SetRange("Source Ref. No.", SalesLine."Line No.");
        TrackingSpecification.SETRANGE(Correction, FALSE);
        if TrackingSpecification.FindSet() then
            repeat
                ILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SetRange("Item No.", TrackingSpecification."Item No.");
                ILE.SetRange(Open, TRUE);
                ILE.SetRange("Serial No.", TrackingSpecification."Serial No.");
                ILE.SetRange("Location Code", TrackingSpecification."Location Code");
                if ILE.IsEmpty then
                    if SNConflict = '' then
                        SNConflict := TrackingSpecification."Serial No."
                    else
                        SNConflict += ', ' + TrackingSpecification."Serial No.";
            until TrackingSpecification.NEXT = 0;

        ReservEntry.SetCurrentKey(
                "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
                "Source Batch Name", "Source Prod. Order Line");
        ReservEntry.SetRange("Source ID", SalesLine."Document No.");
        ReservEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
        ReservEntry.SetRange("Source Type", DATABASE::"Sales Line");
        ReservEntry.SetRange("Source Subtype", SalesLine."Document Type");
        ReservEntry.SetRange("Source Batch Name", '');
        ReservEntry.SetRange("Source Prod. Order Line", 0);
        ReservEntry.SetFilter("Serial No.", '<>%1', '');
        if ReservEntry.FindSet() then
            repeat
                ILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SetRange("Item No.", ReservEntry."Item No.");
                ILE.SetRange(Open, TRUE);
                ILE.SetRange("Serial No.", ReservEntry."Serial No.");
                ILE.SetRange("Location Code", ReservEntry."Location Code");
                if ILE.IsEmpty then
                    if SNConflict = '' then
                        SNConflict := ReservEntry."Serial No."
                    else
                        SNConflict += ', ' + ReservEntry."Serial No.";
            until ReservEntry.NEXT = 0;
    end;

    var
        SNConflict: Text;
}