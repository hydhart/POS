report 50003 "Sales Analyze"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50003.SalesAnalyze.rdlc';
    dataset
    {
        dataitem(Store; "Dimension Value")
        {
            DataItemTableView = sorting(Code) where("Dimension Code" = filter('STORE'));
            RequestFilterFields = Code;

            column(No_Store; Store.Code) { }
            column(Name_Store; Store.Name) { }
            column(SalesWeekly; SalesWeekly) { }
            column(TargetWeekly; TargetWeekly) { }
            column(AchievementWeekly; AchievementWeekly) { }
            column(SalesLastWeek; SalesLastWeek) { }
            column(GrowthWeek; GrowthWeek) { }
            column(SalesMonth; SalesMonth) { }
            column(TargetMonth; TargetMonth) { }
            column(AchievementMonth; AchievementMonth) { }
            column(SalesLastYear; SalesLastYear) { }
            column(GrowthYear; GrowthYear) { }
            column(SalesLastMonth; SalesLastMonth) { }
            column(GrowthMonth; GrowthMonth) { }
            column(SalesYTD; SalesYTD) { }
            column(TargetYTD; TargetYTD) { }
            column(AchievementYTD; AchievementYTD) { }
            column(SalesYTDLastYear; SalesYTDLastYear) { }
            column(GrowthYTDLastYear; GrowthYTDLastYear) { }

            //#region Caption
            column(Caption1; Caption[1]) { }
            column(Caption2; Caption[2]) { }
            column(Caption3; Caption[3]) { }
            column(Caption4; Caption[4]) { }
            column(Caption5; Caption[5]) { }
            //#endregion Caption

            trigger OnAfterGetRecord()
            begin
                CalculateDateFilter();

                Caption[1] := StrSubstNo('(%1 - %2)', Date2DMY(dateFilter, 1), format(endDate, 0, formatDate));
                if Date2DMY(startDateLastWeek, 2) = Date2DMY(endDateLastWeek, 2) then
                    Caption[2] := StrSubstNo('(%1 - %2)', Date2DMY(startDateLastWeek, 1), format(endDateLastWeek, 0, formatDate))
                else
                    Caption[2] := StrSubstNo('(%1 %2 - %3)', Date2DMY(startDateLastWeek, 1), Format(startDateLastWeek, 0, '<Month Text>'), format(endDateLastWeek, 0, formatDate));

                Caption[3] := StrSubstNo('(%1 - %2)', Format(startYTD, 0, '<Month Text>'), Format(endYTD, 0, '<Month Text> <Year4>'));
                Caption[4] := StrSubstNo('(%1 - %2)', Format(startYTDLastYear, 0, '<Month Text>'), Format(endYTDLastYear, 0, '<Month Text> <Year4>'));
                Caption[5] := StrSubstNo('(%1)', Format(dateFilter, 0, '<Month Text>'));
                CalculateValue();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(dateFilter; dateFilter)
                    {
                        Caption = 'Date Filter';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    local procedure TotalSales(pStartDate: Date; pEndDate: Date): Decimal;
    var
        TransSalesEntry: Record "Trans. Sales Entry";
        VE: Record "Value Entry";
    begin
        /*
        TransSalesEntry.Reset();
        TransSalesEntry.SetRange("Store No.", Store."No.");
        TransSalesEntry.SetRange(Date, pStartDate, pEndDate);
        if TransSalesEntry.FindSet() then
            TransSalesEntry.CalcSums("Net Amount");
        */

        VE.Reset();
        VE.SetCurrentKey("Item Ledger Entry Type", "Salespers./Purch. Code", "Location Code", "Posting Date");
        VE.SetRange("Item Ledger Entry Type", VE."Item Ledger Entry Type"::Sale);
        VE.SetRange("Global Dimension 1 Code", Store.Code);
        VE.SetRange("Posting Date", pStartDate, pEndDate);
        if VE.FindSet() then
            VE.CalcSums("Sales Amount (Actual)");

        //exit(Abs(TransSalesEntry."Net Amount"));
        exit(Abs(VE."Sales Amount (Actual)"));
    end;

    local procedure TargetSales(pDateFilter: Date; Month: Boolean): Decimal;
    var
        StoreTarget: Record "Store Weekly Target";
    begin
        StoreTarget.Reset();
        StoreTarget.SetRange("Store No.", Store.Code);
        StoreTarget.SetRange(Year, Date2DMY(pDateFilter, 3));
        if Month then begin
            StoreTarget.SetFilter("Start Date", '>=%1', pDateFilter);
            StoreTarget.SetFilter("End Date", '<=%1', pDateFilter);
        end
        else begin
            StoreTarget.SetFilter("Start Date", '<=%1', pDateFilter);
            StoreTarget.SetFilter("End Date", '>=%1', pDateFilter);
        end;
        if StoreTarget.FindSet() then
            StoreTarget.CalcSums("Target Sales");

        exit(StoreTarget."Target Sales");
    end;

    local procedure TargetSalesYTD(Year: Integer): Decimal;
    var
        StoreTarget: Record "Store Weekly Target";
    begin
        StoreTarget.Reset();
        StoreTarget.SetRange("Store No.", Store.Code);
        StoreTarget.SetRange(Year, Year);
        if StoreTarget.FindSet() then
            StoreTarget.CalcSums("Target Sales");

        exit(StoreTarget."Target Sales");
    end;

    local procedure CalculateDateFilter()
    begin
        GetEndDate();

        endDateLastWeek := dateFilter - 1;
        startDateLastWeek := endDateLastWeek - 6;

        startMonth := CalcDate('-CM', dateFilter);
        endMonth := CalcDate('CM', endDate);

        startLastMonth := CalcDate('-CM-1M', dateFilter);
        endLastMonth := CalcDate('-CM-1D', endDate);

        startLastYear := DMY2Date(Date2DMY(startMonth, 1), Date2DMY(startMonth, 2), Date2DMY(startMonth, 3) - 1);
        endLastYear := DMY2Date(Date2DMY(endMonth, 1), Date2DMY(endMonth, 2), Date2DMY(endMonth, 3) - 1);

        startYTD := DMY2Date(1, 1, Date2DMY(dateFilter, 3));
        endYTD := DMY2Date(Date2DMY(endLastMonth, 1), Date2DMY(endLastMonth, 2), Date2DMY(endLastMonth, 3));
        if endYTD < startYTD then
            endYTD := CalcDate('CM', endDate);

        startYTDLastYear := DMY2Date(Date2DMY(startYTD, 1), Date2DMY(startYTD, 2), Date2DMY(startYTD, 3) - 1);

        endYTDLastYear := DMY2Date(Date2DMY(endYTD, 1), Date2DMY(endYTD, 2), Date2DMY(endYTD, 3) - 1);
    end;

    local procedure GetEndDate()
    var
        StoreTarget: Record "Store Weekly Target";
    begin
        StoreTarget.Reset();
        StoreTarget.SetRange("Store No.", Store.Code);
        StoreTarget.SetRange(Year, Date2DMY(dateFilter, 3));
        StoreTarget.SetFilter("Start Date", '<=%1', DateFilter);
        StoreTarget.SetFilter("End Date", '>=%1', DateFilter);
        if StoreTarget.FindFirst() then
            endDate := StoreTarget."End Date"
        else
            Error('Target Sales tidak ditemukan pada Store %1', Store.Code);
    end;

    local procedure CalculateValue()
    begin
        SalesWeekly := TotalSales(dateFilter, endDate);
        TargetWeekly := TargetSales(dateFilter, false);
        if TargetWeekly > 0 then
            AchievementWeekly := Round((SalesWeekly / TargetWeekly), 0.01, '=');
        SalesLastWeek := TotalSales(startDateLastWeek, endDateLastWeek);
        if SalesWeekly > 0 then
            GrowthWeek := Round(((SalesWeekly - SalesLastWeek) / SalesWeekly), 0.01, '=');
        SalesMonth := TotalSales(startMonth, endMonth);
        TargetMonth := TargetSales(dateFilter, true);
        if TargetMonth > 0 then
            AchievementMonth := Round((SalesMonth / TargetMonth), 0.01, '=');
        SalesLastYear := TotalSales(startLastYear, endLastYear);
        if SalesLastYear > 0 then
            GrowthYear := Round(((SalesMonth - SalesLastYear) / SalesLastYear), 0.01, '=');
        SalesLastMonth := TotalSales(startLastMonth, endLastMonth);
        if SalesLastMonth > 0 then
            GrowthMonth := Round(((SalesMonth - SalesLastMonth) / SalesLastMonth), 0.01, '=');
        SalesYTD := TotalSales(startYTD, endYTD);
        TargetYTD := TargetSalesYTD(Date2DMY(dateFilter, 3));
        if TargetYTD > 0 then
            AchievementYTD := Round((SalesYTD / TargetYTD), 0.01, '=');
        SalesYTDLastYear := TotalSales(startYTDLastYear, endYTDLastYear);
        if SalesYTDLastYear > 0 then
            GrowthYTDLastYear := Round(((SalesYTD - SalesYTDLastYear) / SalesYTDLastYear), 0.01, '=');
    end;

    var
        formatDate: Label '<Day> <Month Text> <Year4>';
        Caption: array[10] of Text;
        StoreFilter: Code[20];
        dateFilter: Date;
        endDate: Date;
        startDateLastWeek: Date;
        endDateLastWeek: Date;
        startMonth: Date;
        endMonth: Date;
        startLastMonth: Date;
        endLastMonth: Date;
        startLastYear: Date;
        endLastYear: Date;
        startYTD: Date;
        endYTD: Date;
        startYTDLastYear: Date;
        endYTDLastYear: Date;
        SalesWeekly: Decimal;
        TargetWeekly: Decimal;
        AchievementWeekly: Decimal;
        SalesLastWeek: Decimal;
        GrowthWeek: Decimal;
        SalesMonth: Decimal;
        TargetMonth: Decimal;
        AchievementMonth: Decimal;
        SalesLastYear: Decimal;
        GrowthYear: Decimal;
        SalesLastMonth: Decimal;
        GrowthMonth: Decimal;
        SalesYTD: Decimal;
        TargetYTD: Decimal;
        AchievementYTD: Decimal;
        SalesYTDLastYear: Decimal;
        GrowthYTDLastYear: Decimal;
}
