xmlport 50004 "SPS Target Store"
{
    Caption = 'SPS Target Store';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "SPS Target Store" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(TargetStore; "SPS Target Store")
            {
                UseTemporary = true;
                fieldelement(StartDate; TargetStore."Start Date") { }
                fieldelement(InventoryPostingGroup; TargetStore."Inventory Posting Group") { }
                fieldelement(StoreCode; TargetStore."Store Code") { }
                fieldelement(ItemFamilyCode; TargetStore."Item Family Code") { }
                fieldelement(SPGCode; TargetStore."SPG Code") { }
                fieldelement(Mode; TargetStore.Mode) { }
                fieldelement(Target; TargetStore.Target) { }

                trigger OnBeforeInsertRecord()
                begin
                    if not DestTable.Get(TargetStore."Inventory Posting Group", TargetStore."Store Code", TargetStore."SPG Code", TargetStore."Item Family Code", TargetStore."Start Date") then begin
                        DestTable.Init();
                        DestTable."Start Date" := TargetStore."Start Date";
                        DestTable."Inventory Posting Group" := TargetStore."Inventory Posting Group";
                        DestTable."Store Code" := TargetStore."Store Code";
                        DestTable."Item Family Code" := TargetStore."Item Family Code";
                        DestTable."SPG Code" := TargetStore."SPG Code";
                        DestTable.Mode := TargetStore.Mode;
                        DestTable.Target := TargetStore.Target;
                        DestTable.Insert(true);
                    end else begin
                        DestTable.Mode := TargetStore.Mode;
                        DestTable.Target := TargetStore.Target;
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
        DestTable: Record "SPS Target Store";
}