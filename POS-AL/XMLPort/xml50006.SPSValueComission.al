xmlport 50006 "SPS Value Comission"
{
    Caption = 'SPS Value Comission';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "SPS Value Comission" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ValueComission; "SPS Value Comission")
            {
                UseTemporary = true;
                fieldelement(StartDate; ValueComission."Start Date") { }
                fieldelement(InventoryPostingGroup; ValueComission."Inventory Posting Group") { }
                fieldelement(ItemFamilyCode; ValueComission."Item Family Code") { }
                fieldelement(ItemCategoryCode; ValueComission."Item Category Code") { }
                fieldelement(ItemNo; ValueComission."Item No") { }
                fieldelement(MinVal; ValueComission."Min Val") { }
                fieldelement(MaxVal; ValueComission."Max Val") { }
                fieldelement(Comission; ValueComission.Comission) { }

                trigger OnBeforeInsertRecord()
                begin
                    if not DestTable.Get(ValueComission."Inventory Posting Group", ValueComission."Item Family Code", ValueComission."Item Category Code", ValueComission."Item No", ValueComission."Min Val", ValueComission."Max Val", ValueComission."Start Date") then begin
                        DestTable.Init();
                        DestTable."Start Date" := ValueComission."Start Date";
                        DestTable."Inventory Posting Group" := ValueComission."Inventory Posting Group";
                        DestTable."Item Family Code" := ValueComission."Item Family Code";
                        DestTable."Item Category Code" := ValueComission."Item Category Code";
                        DestTable."Item No" := ValueComission."Item No";
                        DestTable."Min Val" := ValueComission."Min Val";
                        DestTable."Max Val" := ValueComission."Max Val";
                        DestTable.Comission := ValueComission.Comission;
                        DestTable.Insert(true);
                    end else begin
                        DestTable.Comission := ValueComission.Comission;
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
        DestTable: Record "SPS Value Comission";
}