report 50002 test
{
    ProcessingOnly = true;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(nohp; nohp)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    procedure getNoHp(var nomor: Text)
    begin
        nomor := nohp;
    end;

    var
        nohp: Text;
}
