codeunit 50002 "POS Custom Functions"
{
    TableNo = "POS Menu Line";

    trigger OnRun()
    begin
        if Rec."Registration Mode" then
            Register(Rec)
        else
            case Rec.Command of
                GetHelloWorldCommand():
                    HelloWorld();
            end;
    end;

    local procedure Register(var POSMenuLine: Record "POS Menu Line")
    var
        POSCommandReg: Codeunit "POS Command Registration";
        ModuleDescription: Label 'Modern Channel for Input Phone No.';
        HelloWorldCommandDesc: Label 'Say hello to the cashier.';
    begin
        // Register the module:
        POSCommandReg.RegisterModule(GetModuleCode(), ModuleDescription, Codeunit::"POS Custom Functions");
        // Register the command, as many lines as there are commands in the Codeunit:
        POSCommandReg.RegisterExtCommand(GetHelloWorldCommand(), HelloWorldCommandDesc, Codeunit::"POS Custom Functions", 0, GetModuleCode(), true);

        POSMenuLine."Registration Mode" := false;
    end;

    procedure GetModuleCode(): Code[20]
    var
        ModuleCode: Label 'DANKINSELLA.BLOG', Locked = true;
    begin
        exit(ModuleCode);
    end;

    procedure GetHelloWorldCommand(): Code[20]
    var
        HelloWorldCommand: Label 'HELLOWORLD', locked = true;
    begin
        exit(HelloWorldCommand);
    end;

    procedure HelloWorld()
    var
        HelloWorldMsg: Label 'Hello World!';
    begin
        Message(HelloWorldMsg);
    end;
}