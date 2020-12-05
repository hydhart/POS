page 50501 "Data Deletion"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Data Deletion";

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field("Company Name"; CurrCompanyName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Template Name"; TemplateName)
                {
                    ApplicationArea = All;
                    TableRelation = "Data Deletion Template";
                    trigger OnValidate()
                    begin
                        SetRange("Company Name", CurrCompanyName);
                        SetRange("Template Name", TemplateName);
                        if FindSet() then;
                        DataDeletionMgt.UpdateRecCount(CurrCompanyName, TemplateName);
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Tables)
            {
                field("Delete Data"; "Delete Data")
                {
                    ApplicationArea = All;
                }
                field("Table No."; "Table No.")
                {
                    ApplicationArea = All;
                    TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
                    trigger OnValidate()
                    var
                        RecRef: RecordRef;
                    begin
                        RecRef.Open("Table No.");
                        "Company Name" := CurrCompanyName;
                        "Template Name" := TemplateName;
                        "Table Name" := RecRef.Name;
                        "No. of Records" := RecRef.Count;
                        RecRef.Close();
                    end;
                }
                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Records"; "No. of Records")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SuggestDefaultTables)
            {
                ApplicationArea = All;
                Caption = 'Suggest Default Tables';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.SuggestDefaultTables(CurrCompanyName, TemplateName, false);
                    CurrPage.Update();
                end;
            }
            action(SuggestTransTables)
            {
                ApplicationArea = All;
                Caption = 'Suggest Transaction Tables';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.SuggestDefaultTables(CurrCompanyName, TemplateName, true);
                    CurrPage.Update();
                end;
            }
            action(RemoveAllTables)
            {
                ApplicationArea = All;
                Caption = 'Remove All Tables';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.RemoveAllTables(CurrCompanyName, TemplateName);
                    CurrPage.Update();
                end;
            }

            action(SelectAll)
            {
                ApplicationArea = All;
                Caption = 'Mark all tables';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.SelectAllTables(CurrCompanyName, TemplateName);
                end;
            }

            action(ClearSelection)
            {
                ApplicationArea = All;
                Caption = 'Clear all marks';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.ClearSelection(CurrCompanyName, TemplateName);
                end;
            }

            action(ReverseSelection)
            {
                ApplicationArea = All;
                Caption = 'Reverse all marks';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.ReverseSelection(CurrCompanyName, TemplateName);
                end;
            }

            action(DeleteData)
            {
                ApplicationArea = All;
                Caption = 'Delete Data';

                trigger OnAction()
                begin
                    if TemplateName = '' then
                        Error('Please select template');
                    DataDeletionMgt.DeleteData(CurrCompanyName, TemplateName);
                end;
            }
            action(Refresh)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrCompanyName := CompanyName;
        TemplateName := '';
    end;

    trigger OnOpenPage()
    begin
        SetRange("Company Name", CurrCompanyName);
        SetRange("Template Name", TemplateName);
        if FindSet() then;
        CurrPage.Update(false);
    end;

    var
        DataDeletionMgt: Codeunit "Data Deletion Mgt.";
        CurrCompanyName: Code[50];
        TemplateName: Code[20];
}