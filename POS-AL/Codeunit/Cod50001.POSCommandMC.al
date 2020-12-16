codeunit 50001 "POS Command MC"
{
    TableNo = "POS Menu Line";

    trigger OnRun()
    begin
        if Rec."Registration Mode" then
            Register(Rec)
        else
            case Rec.Command of
                GetPingTelCommand():
                    PingTel();

            end;
    end;

    local procedure Register(var POSMenuLine: Record "POS Menu Line")
    var
        POSCommandReg: Codeunit "POS Command Registration";
        ModuleDescription: Label 'PPOB Command';
        PingTelCommandDesc: Label 'Check List Active PPOB';
    begin
        // Register the module:
        POSCommandReg.RegisterModule(GetModuleCode(), ModuleDescription, Codeunit::"POS Command MC");
        // Register the command, as many lines as there are commands in the Codeunit:
        POSCommandReg.RegisterExtCommand(GetPingTelCommand, PingTelCommandDesc, Codeunit::"POS Command MC", 1, GetModuleCode(), true);

        POSMenuLine."Registration Mode" := false;
    end;

    procedure GetModuleCode(): Code[20]
    var
        ModuleCode: Label 'PPOB', Locked = true;
    begin
        exit(ModuleCode);
    end;

    procedure GetPingTelCommand(): Code[20]
    var
        PingTelCommand: Label 'PPOBPingTel', locked = true;
    begin
        exit(PingTelCommand);
    end;

    procedure HelloWorld()
    var
        HelloWorldMsg: Label 'Hello World!';
    begin
        Message(HelloWorldMsg);
    end;

    procedure PingTel()
    var
        POSTrx: Codeunit "POS Transaction";
        POSTransaction: Record "POS Transaction";
    begin
        POSTrx.GetPOSTransaction(POSTransaction);
        Message(POSTransaction."Receipt No.");
    end;

    procedure Inquiry()
    var
        POSTrx: Codeunit "POS Transaction";
        POSTransaction: Record "POS Transaction";
    begin
        POSTrx.GetPOSTransaction(POSTransaction);
        Message(POSTransaction."Receipt No.");
    end;
}
