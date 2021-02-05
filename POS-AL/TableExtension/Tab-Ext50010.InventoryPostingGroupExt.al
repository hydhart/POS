tableextension 50010 "Invetory Posting Group Ext" extends "Inventory Posting Group"
{
    fields
    {
        field(50000; "Comission Group Code"; Code[50])
        {
            Caption = 'Comission Group Code';
            DataClassification = ToBeClassified;
        }
    }
}