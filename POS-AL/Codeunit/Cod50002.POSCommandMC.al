codeunit 50002 "POS Command MC"
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
                GetOrderCommand():
                    Orders;
            end;
    end;

    local procedure Register(var POSMenuLine: Record "POS Menu Line")
    var
        POSCommandReg: Codeunit "POS Command Registration";
        ModuleDescription: Label 'PPOB Command';
        PingTelCommandDesc: Label 'Check List Active PPOB';
        OrderCommandDesc: Label 'Re-Order PPOB';
        InquiryCommandDesc: Label 'Inquiry Order PPOB';
    begin
        // Register the module:
        POSCommandReg.RegisterModule(GetModuleCode(), ModuleDescription, Codeunit::"POS Command MC");
        // Register the command, as many lines as there are commands in the Codeunit:
        POSCommandReg.RegisterExtCommand(GetPingTelCommand, PingTelCommandDesc, Codeunit::"POS Command MC", 1, GetModuleCode(), true);
        POSCommandReg.RegisterExtCommand(GetOrderCommand(), OrderCommandDesc, Codeunit::"POS Command MC", 1, GetModuleCode(), true);

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

    procedure GetOrderCommand(): Code[20]
    var
        OrderCommand: Label 'PPOBOrder', locked = true;
    begin
        exit(OrderCommand);
    end;

    procedure PingTel()
    var
        POSTrx: Codeunit "POS Transaction";
        POSTransaction: Record "POS Transaction";
        PPOBMgt: Codeunit "Modern Channel Mgt";
    begin
        POSTrx.GetPOSTransaction(POSTransaction);
        PPOBMgt.RunPing(POSTransaction);
    end;

    procedure Orders()
    var
        POSTrx: Codeunit "POS Transaction";
        POSTransaction: Record "POS Transaction";
        POSTransLine: Record "POS Trans. Line";
        PPOBMgt: Codeunit "Modern Channel Mgt";
    begin
        POSTrx.GetPOSTransaction(POSTransaction);
        posTransLine.Reset();
        posTransLine.SetRange("Receipt No.", POSTransaction."Receipt No.");
        posTransLine.SetRange("Entry Status", posTransLine."Entry Status"::" ");
        if posTransLine.FindFirst() then begin
            if POSTransLine.mc_Itemtype = POSTransLine.mc_Itemtype::"Pulsa PostPaid" then begin
                PPOBMgt.initializeData(posTransLine."Store No.", POSTransaction."Staff ID", posTransLine.mc_vtype, posTransLine.mc_hp, POSTransaction."Receipt No.");
                PPOBMgt.RunOrder(posTransLine);
            end;
        end;
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
