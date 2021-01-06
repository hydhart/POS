tableextension 50009 "Tracking Specification Ext" extends "Tracking Specification"
{
    fields
    {
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            begin
                Validate("Quantity (Base)", 1);
            end;
        }
    }
}