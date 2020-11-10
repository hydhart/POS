page 50002 "Vtype List"
{

    ApplicationArea = All;
    Caption = 'Vtype List';
    PageType = List;
    SourceTable = "Item Vtype";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(vtype; Rec.vtype)
                {
                    ApplicationArea = All;
                }
                field("vtype Description"; Rec."vtype Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
