xmlport 50001 "Import Member Contact"
{
    Caption = 'XML Member Contact';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "Member Contact" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MemberContact; "Member Contact")
            {
                UseTemporary = true;
                fieldelement(AccountNo; MemberContact."Account No.") { }
                fieldelement(Name; MemberContact.Name) { }
                fieldelement(ContactNo; MemberContact."Contact No.") { }
                fieldelement(PhoneNo; MemberContact."Phone No.") { }
                fieldelement(MobileNo; MemberContact."Mobile Phone No.") { }
                fieldelement(MainContact; MemberContact."Main Contact") { }
                fieldelement(Email; MemberContact."E-Mail") { }
                fieldelement(ClubCode; MemberContact."Club Code") { }
                fieldelement(SchemeCode; MemberContact."Scheme Code") { }

                trigger OnBeforeInsertRecord()
                begin
                    if not Contact.Get(MemberContact."Account No.", MemberContact."Contact No.") then begin
                        Contact.Init();
                        Contact."Account No." := MemberContact."Account No.";
                        Contact."Contact No." := MemberContact."Contact No.";
                        Contact.Name := MemberContact.Name;
                        Contact."Phone No." := MemberContact."Phone No.";
                        Contact."Mobile Phone No." := MemberContact."Mobile Phone No.";
                        Contact."Main Contact" := MemberContact."Main Contact";
                        Contact."E-Mail" := MemberContact."E-Mail";
                        Contact."Club Code" := MemberContact."Club Code";
                        Contact."Scheme Code" := MemberContact."Scheme Code";
                        Contact.Insert();
                    end else begin
                        Contact.Name := MemberContact.Name;
                        Contact."Phone No." := MemberContact."Phone No.";
                        Contact."Mobile Phone No." := MemberContact."Mobile Phone No.";
                        Contact."Main Contact" := MemberContact."Main Contact";
                        Contact."E-Mail" := MemberContact."E-Mail";
                        Contact."Club Code" := MemberContact."Club Code";
                        Contact."Scheme Code" := MemberContact."Scheme Code";
                        Contact.Modify();
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
        Contact: Record "Member Contact";
}