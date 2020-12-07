tableextension 50005 "Member Account Ext" extends "Member Account"
{
    trigger OnAfterInsert()
    var
        MemberContact: Record "Member Contact";
    begin
        MemberContact.SetRange("Account No.", "No.");
        MemberContact.SetRange("Contact No.", "No.");
        if MemberContact.FindFirst() then begin
            MemberContact.Name := Description;
            MemberContact."Search Name" := UpperCase(Description);
            MemberContact."Phone No." := "No.";
            MemberContact.Modify();
        end;

    end;
}