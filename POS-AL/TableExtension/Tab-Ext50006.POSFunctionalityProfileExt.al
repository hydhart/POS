tableextension 50006 "POS Functionality Profile Ext" extends "POS Functionality Profile"
{
    fields
    {
        field(50000; "Print Card Slip"; Boolean)
        {
            Caption = 'Print Card Slip';
            DataClassification = ToBeClassified;
        }
        field(50001; "Print Void Slip"; Boolean)
        {
            Caption = 'Print Void Slip';
            DataClassification = ToBeClassified;
        }
        field(50002; "Print Suspend Slip"; Boolean)
        {
            Caption = 'Print Suspend Slip';
            DataClassification = ToBeClassified;
        }
    }
}