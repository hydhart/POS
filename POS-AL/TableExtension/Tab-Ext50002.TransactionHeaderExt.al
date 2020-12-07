tableextension 50002 "Transaction Header Ext" extends "Transaction Header"
{
    fields
    {
        // Add changes to table fields here
        field(17; "Sales Staff"; Code[20])
        {
            Caption = 'Sales Staff';
            DataClassification = ToBeClassified;
        }
        field(50000; "Print Counter"; integer)
        {
            Caption = 'Print Counter';
            DataClassification = ToBeClassified;
        }
    }
}