pageextension 50004 "Store Card Ext" extends "Store Card"
{
    layout
    {
        addafter(General)
        {
            group("PPOB Setup")
            {

                field("Channel ID"; Rec."Channel ID")
                {
                    ApplicationArea = All;
                }
                field("Store ID"; Rec."Store ID")
                {
                    ApplicationArea = All;
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;
                }
                field("Secret Key"; Rec."Secret Key")
                {
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
