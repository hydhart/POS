pageextension 50001 "Retail Setup Ext" extends "Retail Setup"
{
    layout
    {
        addafter(Posting)
        {
            group("Non Member")
            {
                field(NMPhoneInfo; "NM Phone Info")
                {
                    ApplicationArea = All;
                }
                field(NMNameInfo; "NM Name Info")
                {
                    ApplicationArea = All;
                }
                field(NMClubCode; "NM Club Code")
                {
                    ApplicationArea = All;
                }
                field(NMSchemeCode; "NM Scheme Code")
                {
                    ApplicationArea = All;
                }
            }
            group(PPOB)
            {
                field("PPOB Infocode"; Rec."PPOB Infocode")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}