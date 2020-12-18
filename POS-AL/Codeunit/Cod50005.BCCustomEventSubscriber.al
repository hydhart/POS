codeunit 50005 "BC Custom Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure BeforeRunWithCheck(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var
        lItem: Record Item;
        itemTrackingCode: Record "Item Tracking Code";
    begin
        itemTrackingCode.INIT;
        IF lItem.GET(ItemJournalLine."Item No.") THEN
            IF (lItem."Item Tracking Code" <> '') THEN
                IF (NOT itemTrackingCode.GET(lItem."Item Tracking Code")) THEN
                    itemTrackingCode.INIT;

        IF (itemTrackingCode."SN Pos. Adjmt. Inb. Tracking" OR itemTrackingCode."SN Pos. Adjmt. Outb. Tracking") AND (ItemJournalLine."Quantity (Base)" <> 0) THEN BEGIN
            IJValidateSerialNoExist(ItemJournalLine);
        END;
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

    local procedure IJValidateSerialNoExist(JnlLine: Record "Item Journal Line")
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ILE: Record "Item Ledger Entry";
    begin
        TrackingSpecification.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
            "Source Prod. Order Line", "Source Ref. No.");
        TrackingSpecification.SETRANGE("Source ID", jnlLine."Journal Template Name");
        TrackingSpecification.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        TrackingSpecification.SETRANGE("Source Subtype", jnlLine."Entry Type");
        TrackingSpecification.SETRANGE("Source Batch Name", jnlLine."Journal Batch Name");
        TrackingSpecification.SETRANGE("Source Prod. Order Line", 0);
        TrackingSpecification.SETRANGE("Source Ref. No.", jnlLine."Line No.");
        TrackingSpecification.SETRANGE(Correction, FALSE);
        IF TrackingSpecification.FINDSET THEN
            REPEAT
                ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SETRANGE("Item No.", TrackingSpecification."Item No.");
                ILE.SETRANGE(Open, TRUE);
                ILE.SETRANGE("Serial No.", TrackingSpecification."Serial No.");
                ILE.SETRANGE("Location Code", TrackingSpecification."Location Code");
                IF (jnlLine."Entry Type" = jnlLine."Entry Type"::"Positive Adjmt.") THEN BEGIN
                    IF NOT ILE.ISEMPTY THEN
                        ERROR('S/N (%1) had been registered before', TrackingSpecification."Serial No.");
                END ELSE
                    IF (jnlLine."Entry Type" = jnlLine."Entry Type"::"Negative Adjmt.") THEN BEGIN
                        IF ILE.ISEMPTY THEN
                            ERROR('S/N (%1) had not been registered or Empty', TrackingSpecification."Serial No.");
                    END;
            UNTIL TrackingSpecification.NEXT = 0;

        ReservEntry.SETCURRENTKEY(
            "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
            "Source Batch Name", "Source Prod. Order Line");
        ReservEntry.SETRANGE("Source ID", jnlLine."Journal Template Name");
        ReservEntry.SETRANGE("Source Ref. No.", jnlLine."Line No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SETRANGE("Source Subtype", jnlLine."Entry Type");
        ReservEntry.SETRANGE("Source Batch Name", jnlLine."Journal Batch Name");
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        ReservEntry.SETFILTER("Serial No.", '<>%1', '');
        IF ReservEntry.FINDSET THEN
            REPEAT
                ILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                ILE.SETRANGE("Item No.", ReservEntry."Item No.");
                ILE.SETRANGE(Open, TRUE);
                ILE.SETRANGE("Serial No.", ReservEntry."Serial No.");
                ILE.SETRANGE("Location Code", ReservEntry."Location Code");
                IF (jnlLine."Entry Type" = jnlLine."Entry Type"::"Positive Adjmt.") THEN BEGIN
                    IF NOT ILE.ISEMPTY THEN
                        ERROR('S/N (%1) had been registered before', ReservEntry."Serial No.");
                END ELSE
                    IF (jnlLine."Entry Type" = jnlLine."Entry Type"::"Negative Adjmt.") THEN BEGIN
                        IF ILE.ISEMPTY THEN
                            ERROR('S/N (%1) had not been registered or Empty', ReservEntry."Serial No.");
                    END;
            UNTIL ReservEntry.NEXT = 0;
    end;
}