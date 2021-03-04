report 50001 "Item-Vendor"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50001.Item-Vendor.rdlc';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number);
            column(No; ItemTemp."No.") { }
            column(Description; ItemTemp.Description) { }
            column(Inventory_Posting_Group; ItemTemp."Inventory Posting Group") { }
            column(Inventory; ItemTemp.Inventory) { }
            column(BeforeCaptionLbl; BeforeCaptionLbl) { }
            column(InvtValue1; ItemTemp."Budget Profit") { }
            column(InvtValue2; ItemTemp."Budget Quantity") { }
            column(InvtValue3; ItemTemp."Budgeted Amount") { }
            column(InvtValue4; ItemTemp."COGS (LCY)") { }
            column(InvtValue5; ItemTemp."Gross Weight") { }
            column(InvtValue6; ItemTemp."Indirect Cost %") { }
            column(PeriodStartDate1; Format(PeriodStartDate[1])) { }
            column(PeriodStartDate2; Format(PeriodStartDate[2])) { }
            column(PeriodStartDate6; Format(PeriodStartDate[6])) { }
            column(PeriodStartDate21; Format(PeriodStartDate[2] + 1)) { }
            column(PeriodStartDate3; Format(PeriodStartDate[3])) { }
            column(PeriodStartDate31; Format(PeriodStartDate[3] + 1)) { }
            column(PeriodStartDate4; Format(PeriodStartDate[4])) { }
            column(PeriodStartDate41; Format(PeriodStartDate[4] + 1)) { }
            column(PeriodStartDate5; Format(PeriodStartDate[5])) { }
            column(ItemFilter; ItemFilter) { }
            column(CompanyName; COMPANYPROPERTY.DisplayName) { }
            column(TodayFormatted; Format(Today, 0, 4)) { }

            trigger OnPreDataItem()
            begin
                Item.Reset();
                Item.SetFilter("No.", ItemFilter);
                Item.SetFilter("Inventory Posting Group", InvPostGrp);
                if Item.FindSet() then begin
                    repeat
                        ItemTemp.Init();
                        ItemTemp.TransferFields(Item);
                        getInventoryValue();
                        ItemTemp."Budget Profit" := InvtValue[1];
                        ItemTemp."Budget Quantity" := InvtValue[2];
                        ItemTemp."Budgeted Amount" := InvtValue[3];
                        ItemTemp."COGS (LCY)" := InvtValue[4];
                        ItemTemp."Gross Weight" := InvtValue[5];
                        ItemTemp."Indirect Cost %" := InvtValue[6];
                        if (InvtValue[1] <> 0) and (InvtValue[2] <> 0) and (InvtValue[3] <> 0)
                        and (InvtValue[4] <> 0) and (InvtValue[5] <> 0) and (InvtValue[6] <> 0) then
                            ItemTemp.Insert();
                    until Item.Next() = 0;
                end;

                SetRange(Number, 1, ItemTemp.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    ItemTemp.FindFirst()
                else
                    ItemTemp.Next();

                ItemTemp.CalcFields(Inventory);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(EndingDate; PeriodStartDate[5])
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the end date of the report. The report calculates backwards from this date and sets up three periods of the length specified in the Period Length field.';

                        trigger OnValidate()
                        begin
                            if PeriodStartDate[5] = 0D then
                                Error(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the length of the three periods in the report.';

                        trigger OnValidate()
                        begin
                            if Format(PeriodLength) = '' then
                                Evaluate(PeriodLength, '<0D>');
                        end;
                    }
                    field(vendorNo; vendorNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor';
                        TableRelation = Vendor."No.";
                    }
                    field(ItemFilter; ItemFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        TableRelation = Item."No.";
                    }
                    field(InvPostGrp; InvPostGrp)
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Posting Group';
                        TableRelation = "Inventory Posting Group".Code;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            if PeriodStartDate[5] = 0D then
                PeriodStartDate[5] := CalcDate('<CM>', WorkDate);
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        PeriodStartDate[6] := DMY2Date(31, 12, 9999);
        Evaluate(NegPeriodLength, StrSubstNo('-%1', Format(PeriodLength)));
        for i := 1 to 3 do
            PeriodStartDate[5 - i] := CalcDate(NegPeriodLength, PeriodStartDate[6 - i]);

        PeriodStartDate[1] := CalcDate('-1D', PeriodStartDate[2]);
    end;

    local procedure getInventoryValue()
    begin
        Clear(InvtValue);
        for i := 1 to 6 do begin
            case i of
                1:
                    begin
                        valueEntry.Reset();
                        valueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                        valueEntry.SetRange("Item No.", Item."No.");
                        valueEntry.SetFilter("Posting Date", '..%1', PeriodStartDate[2]);
                        if vendorNo <> '' then begin
                            valueEntry.SetRange("Source Type", valueEntry."Source Type"::Vendor);
                            valueEntry.SetFilter("Source No.", vendorNo);
                        end;
                        if valueEntry.FindSet() then begin
                            valueEntry.CalcSums("Cost Amount (Actual)");
                            InvtValue[i] := valueEntry."Cost Amount (Actual)";
                        end;
                    end;
                2:
                    begin
                        valueEntry.Reset();
                        valueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                        valueEntry.SetRange("Item No.", Item."No.");
                        valueEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[2] + 1, PeriodStartDate[3]);
                        if vendorNo <> '' then begin
                            valueEntry.SetRange("Source Type", valueEntry."Source Type"::Vendor);
                            valueEntry.SetFilter("Source No.", vendorNo);
                        end;
                        if valueEntry.FindSet() then begin
                            valueEntry.CalcSums("Cost Amount (Actual)");
                            InvtValue[i] := valueEntry."Cost Amount (Actual)";
                        end;

                    end;
                3:
                    begin
                        valueEntry.Reset();
                        valueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                        valueEntry.SetRange("Item No.", Item."No.");
                        valueEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[3] + 1, PeriodStartDate[4]);
                        if vendorNo <> '' then begin
                            valueEntry.SetRange("Source Type", valueEntry."Source Type"::Vendor);
                            valueEntry.SetFilter("Source No.", vendorNo);
                        end;
                        if valueEntry.FindSet() then begin
                            valueEntry.CalcSums("Cost Amount (Actual)");
                            InvtValue[i] := valueEntry."Cost Amount (Actual)";
                        end;

                    end;
                4:
                    begin
                        valueEntry.Reset();
                        valueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                        valueEntry.SetRange("Item No.", Item."No.");
                        valueEntry.SetFilter("Posting Date", '%1..%2', PeriodStartDate[4] + 1, PeriodStartDate[5]);
                        if vendorNo <> '' then begin
                            valueEntry.SetRange("Source Type", valueEntry."Source Type"::Vendor);
                            valueEntry.SetFilter("Source No.", vendorNo);
                        end;
                        if valueEntry.FindSet() then begin
                            valueEntry.CalcSums("Cost Amount (Actual)");
                            InvtValue[i] := valueEntry."Cost Amount (Actual)";
                        end;
                    end;
                6:
                    begin
                        valueEntry.Reset();
                        valueEntry.SetCurrentKey("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
                        valueEntry.SetRange("Item No.", Item."No.");
                        valueEntry.SetFilter("Posting Date", '..%1', PeriodStartDate[5]);
                        if vendorNo <> '' then begin
                            valueEntry.SetRange("Source Type", valueEntry."Source Type"::Vendor);
                            valueEntry.SetFilter("Source No.", vendorNo);
                        end;
                        if valueEntry.FindSet() then begin
                            valueEntry.CalcSums("Cost Amount (Actual)");
                            InvtValue[i] := valueEntry."Cost Amount (Actual)";
                        end;
                    end;
            end;
        end;
    end;

    var
        ItemTemp: Record Item temporary;
        Item: Record Item;
        vendorNo: Code[20];
        InvPostGrp: Code[20];
        valueEntry: Record "Value Entry";
        periodLength: DateFormula;
        PeriodStartDate: array[6] of Date;
        InvtValue: array[6] of Decimal;
        ItemFilter: Text;
        i: Integer;
        BeforeCaptionLbl: Label '...Before';
        Text002: Label 'Enter the ending date';
}
