xmlport 50000 "Import Member Account"
{
    Caption = 'XML Member Account';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "Member Account" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MemberAccount; "Member Account")
            {
                UseTemporary = true;
                fieldelement(AccountNo; MemberAccount."No.") { }
                fieldelement(Status; MemberAccount.Status) { }
                fieldelement(AccountType; MemberAccount."Account Type") { }
                fieldelement(Description; MemberAccount.Description) { }
                fieldelement(ClubCode; MemberAccount."Club Code") { }
                fieldelement(SchemeCode; MemberAccount."Scheme Code") { }

                trigger OnBeforeInsertRecord()
                begin
                    if not Account.Get(MemberAccount."No.") then begin
                        Account.Init();
                        Account."No." := MemberAccount."No.";
                        Account.Status := MemberAccount.Status;
                        Account."Account Type" := MemberAccount."Account Type";
                        Account.Description := MemberAccount.Description;
                        Account."Club Code" := MemberAccount."Club Code";
                        Account."Scheme Code" := MemberAccount."Scheme Code";
                        Account.Insert(true);
                    end else begin
                        Account.Status := MemberAccount.Status;
                        Account."Account Type" := MemberAccount."Account Type";
                        Account.Description := MemberAccount.Description;
                        Account."Club Code" := MemberAccount."Club Code";
                        Account."Scheme Code" := MemberAccount."Scheme Code";
                        Account.Modify(true);
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
        Account: Record "Member Account";
}