page 50001 "Modern Channel Log Entries"
{

    ApplicationArea = All;
    Caption = 'PPOB Log Entries';
    PageType = List;
    SourceTable = "Modern Channel Log Entry";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Log Date"; Rec."Log Date")
                {
                    ApplicationArea = All;
                }
                field("Log Time"; Rec."Log Time")
                {
                    ApplicationArea = All;
                }
                field("Status Message"; Rec."Status Message")
                {
                    ApplicationArea = All;
                }
                field("Response Message"; responseMsg)
                {
                    ApplicationArea = All;
                }
                field(Handphone; Rec.Handphone)
                {
                    ApplicationArea = All;
                }
                field("Nama Pelanggan"; Rec."Nama Pelanggan")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Line No."; Rec."Transaction Line No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                }
                field(Command; Rec.Command)
                {
                    ApplicationArea = All;
                }
                field(VType; Rec.VType)
                {
                    ApplicationArea = All;
                }
                field("Channel ID"; Rec."Channel ID")
                {
                    ApplicationArea = All;
                }
                field("Store ID"; Rec."Store ID")
                {
                    ApplicationArea = All;
                }
                field("POS ID"; Rec."POS ID")
                {
                    ApplicationArea = All;
                }
                field("Server Trx ID"; Rec."Server Trx ID")
                {
                    ApplicationArea = All;
                }
                field("Cashier ID"; Rec."Cashier ID")
                {
                    ApplicationArea = All;
                }
                field("Subscriber ID"; Rec."Subscriber ID")
                {
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
                field("URL 2"; Rec."URL 2")
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(responseMsg);
        Clear(inStr);
        CalcFields(Rec."Response Message");
        Rec."Response Message".CreateInStream(inStr);
        inStr.Read(responseMsg);
    end;

    var
        responseMsg: Text;
        inStr: InStream;
}
