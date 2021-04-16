tableextension 50012 "Service Invoice Header Ext" extends "Service Invoice Header"
{
    fields
    {
        field(50001; IProtech; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'I Pro Tech';
            Editable = false;
        }
    }
}