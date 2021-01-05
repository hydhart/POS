xmlport 50003 "Member Point Journal Line"
{
    Caption = 'XML Member Point Journal Line';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "Member Point Jnl. Line" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MemberJnlLine; "Member Point Jnl. Line")
            {
                UseTemporary = true;
                fieldelement(TemplateName; MemberJnlLine."Journal Template Name") { }
                fieldelement(BatchName; MemberJnlLine."Journal Batch Name") { }
                fieldelement(LineNo; MemberJnlLine."Line No.") { }
                fieldelement(EntryType; MemberJnlLine.Type) { }
                fieldelement(EntryDate; MemberJnlLine.Date) { }
                fieldelement(AccountNo; MemberJnlLine."Account No.") { }
                fieldelement(Description; MemberJnlLine.Description) { }
                fieldelement(PointType; MemberJnlLine."Point Type") { }
                fieldelement(Points; MemberJnlLine.Points) { }

                trigger OnBeforeInsertRecord()
                begin
                    JnlLine.Init();
                    JnlLine."Journal Template Name" := MemberJnlLine."Journal Template Name";
                    JnlLine."Journal Batch Name" := MemberJnlLine."Journal Batch Name";
                    JnlLine."Line No." := MemberJnlLine."Line No.";
                    JnlLine.Type := MemberJnlLine.Type;
                    JnlLine.Date := MemberJnlLine.Date;
                    JnlLine."Account No." := MemberJnlLine."Account No.";
                    JnlLine.Description := MemberJnlLine.Description;
                    JnlLine."Point Type" := MemberJnlLine."Point Type";
                    JnlLine.Points := MemberJnlLine.Points;
                    JnlLine.Insert();
                end;
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        Message('Done');
    end;

    var
        JnlLine: Record "Member Point Jnl. Line";
}