page 50003 "MC Role Center"
{
    Caption = 'MC Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1101214009; "My Items")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control1101214000; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
            part(Control21; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group(MC)
            {
                action(Setup)
                {
                    ApplicationArea = All;
                    RunObject = page "Modern Channel Setup";
                }
                action(Vtype)
                {
                    ApplicationArea = All;
                    RunObject = page "vtype List";
                }
                action(Log)
                {
                    ApplicationArea = All;
                    RunObject = page "Modern Channel Log Entries";
                }
            }
            group(POS)
            {
                action("Run POS")
                {
                    ApplicationArea = All;
                    RunObject = page "POS Client";
                }
            }
        }
    }
}
