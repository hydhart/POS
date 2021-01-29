xmlport 50007 "Store Weekly Target"
{
    Caption = 'Store Weekly Target';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "Store Weekly Target" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(WeeklyTarget; "Store Weekly Target")
            {
                UseTemporary = true;
                fieldelement(StoreNo; WeeklyTarget."Store No.") { }
                fieldelement(Year; WeeklyTarget.Year) { }
                fieldelement(Week; WeeklyTarget.Week) { }
                fieldelement(TargetSales; WeeklyTarget."Target Sales") { }

                trigger OnBeforeInsertRecord()
                begin
                    if not DestTable.Get(WeeklyTarget."Store No.", WeeklyTarget.Year, WeeklyTarget.Week) then begin
                        DestTable.Init();
                        DestTable."Store No." := WeeklyTarget."Store No.";
                        DestTable.Year := WeeklyTarget.Year;
                        DestTable.Validate(Week, WeeklyTarget.Week);
                        DestTable."Target Sales" := WeeklyTarget."Target Sales";
                        DestTable.Insert(true);
                    end else begin
                        DestTable."Target Sales" := WeeklyTarget."Target Sales";
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
        DestTable: Record "Store Weekly Target";
}