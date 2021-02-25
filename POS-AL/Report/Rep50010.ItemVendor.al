report 50010 "Item-Vendor"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50010.Item-Vendor.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Inventory Posting Group";
            column(No; "No.") { }
            column(Description; Description) { }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(Inventory; Inventory) { }
            column(BeforeCaptionLbl; BeforeCaptionLbl) { }
            column(InvtValue1; InvtValue[1]) { }
            column(InvtValue2; InvtValue[2]) { }
            column(InvtValue3; InvtValue[3]) { }
            column(InvtValue4; InvtValue[4]) { }
            column(InvtValue5; InvtValue[5]) { }
            column(InvtValue6; InvtValue[6]) { }
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

            trigger OnAfterGetRecord()
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
        ItemFilter := Item.GetFilters;

        PeriodStartDate[6] := DMY2Date(31, 12, 9999);
        Evaluate(NegPeriodLength, StrSubstNo('-%1', Format(PeriodLength)));
        for i := 1 to 3 do
            PeriodStartDate[5 - i] := CalcDate(NegPeriodLength, PeriodStartDate[6 - i]);

        PeriodStartDate[1] := CalcDate('-1D', PeriodStartDate[2]);
    end;

    var
        vendorNo: Code[20];
        valueEntry: Record "Value Entry";
        periodLength: DateFormula;
        PeriodStartDate: array[6] of Date;
        InvtValue: array[6] of Decimal;
        ItemFilter: Text;
        i: Integer;
        BeforeCaptionLbl: Label '...Before';
        Text002: Label 'Enter the ending date';
}
