xmlport 50002 "Import Membership Card"
{
    Caption = 'XML Membership Card';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Permissions = tabledata "Membership Card" = rimd;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MembershipCard; "Membership Card")
            {
                UseTemporary = true;
                fieldelement(CardNo; MembershipCard."Card No.") { }
                fieldelement(Status; MembershipCard.Status) { }
                fieldelement(ClubCode; MembershipCard."Club Code") { }
                fieldelement(AccountNo; MembershipCard."Account No.") { }
                fieldelement(ContactNo; MembershipCard."Contact No.") { }
                fieldelement(LastValidDate; MembershipCard."Last Valid Date") { }
                fieldelement(ReasonBlocked; MembershipCard."Reason Blocked") { }
                fieldelement(DateBlocked; MembershipCard."Date Blocked") { }
                fieldelement(BlockedBy; MembershipCard."Blocked by") { }
                fieldelement(AllocatedToStore; MembershipCard."Allocated to Store") { }

                trigger OnBeforeInsertRecord()
                begin
                    if not Card.Get(MembershipCard."Card No.") then begin
                        Card.Init();
                        Card."Card No." := MembershipCard."Card No.";
                        Card.Status := MembershipCard.Status;
                        Card."Club Code" := MembershipCard."Club Code";
                        Card."Account No." := MembershipCard."Account No.";
                        Card."Contact No." := MembershipCard."Contact No.";
                        Card."Last Valid Date" := MembershipCard."Last Valid Date";
                        Card."Reason Blocked" := MembershipCard."Reason Blocked";
                        Card."Date Blocked" := MembershipCard."Date Blocked";
                        Card."Blocked by" := MembershipCard."Blocked by";
                        Card."Allocated to Store" := MembershipCard."Allocated to Store";
                        Card.Insert();
                    end else begin
                        Card.Status := MembershipCard.Status;
                        Card."Club Code" := MembershipCard."Club Code";
                        Card."Account No." := MembershipCard."Account No.";
                        Card."Contact No." := MembershipCard."Contact No.";
                        Card."Last Valid Date" := MembershipCard."Last Valid Date";
                        Card."Reason Blocked" := MembershipCard."Reason Blocked";
                        Card."Date Blocked" := MembershipCard."Date Blocked";
                        Card."Blocked by" := MembershipCard."Blocked by";
                        Card."Allocated to Store" := MembershipCard."Allocated to Store";
                        Card.Modify();
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
        Card: Record "Membership Card";
}