xmlport 50005 "SPS Percentage Store"
{
    Caption = 'SPS Percentage Store';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "SPS Percentage Store" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PercentageStore; "SPS Percentage Store")
            {
                UseTemporary = true;
                fieldelement(StartDate; PercentageStore."Start Date") { }
                fieldelement(InventoryPostingGroup; PercentageStore."Inventory Posting Group") { }
                fieldelement(StoreGroup; PercentageStore."Store Code") { }
                fieldelement(MinVal; PercentageStore."Min Val") { }
                fieldelement(MaxVal; PercentageStore."Max Val") { }
                fieldelement(Percentage; PercentageStore.Percentage) { }

                trigger OnBeforeInsertRecord()
                begin
                    if not DestTable.Get(PercentageStore."Start Date", PercentageStore."Inventory Posting Group", PercentageStore."Store Code", PercentageStore."Min Val", PercentageStore."Max Val") then begin
                        DestTable.Init();
                        DestTable."Start Date" := PercentageStore."Start Date";
                        DestTable."Inventory Posting Group" := PercentageStore."Inventory Posting Group";
                        DestTable."Store Code" := PercentageStore."Store Code";
                        DestTable."Min Val" := PercentageStore."Min Val";
                        DestTable."Max Val" := PercentageStore."Max Val";
                        DestTable.Percentage := PercentageStore.Percentage;
                        DestTable.Insert(true);
                    end else begin
                        DestTable.Percentage := PercentageStore.Percentage;
                        DestTable.Modify(true);
                    end;
                end;
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        Message('Done');
    end;

    var
        DestTable: Record "SPS Percentage Store";
}