page 50000 "Modern Channel Setup"
{
    ApplicationArea = All;
    Caption = 'PPOB Setup';
    PageType = List;
    SourceTable = "Modern Channel Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Channel ID"; Rec."Channel ID")
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
    actions
    {
        area(Processing)
        {
            action("test ping")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MCMgt: Codeunit "Modern Channel Mgt";
                begin
                    MCMgt.testRunPing();
                end;
            }
            action("test denom")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MCMgt: Codeunit "Modern Channel Mgt";
                begin
                    MCMgt.testRunDenom();
                end;
            }
            action("test topup")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MCMgt: Codeunit "Modern Channel Mgt";
                begin
                    MCMgt.testRunTopup();
                end;
            }
            action("test order")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MCMgt: Codeunit "Modern Channel Mgt";
                begin
                    MCMgt.testRunOrder();
                end;
            }
            action("test inquiry")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MCMgt: Codeunit "Modern Channel Mgt";
                begin
                    MCMgt.testRunInquiry();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;
    end;
}
