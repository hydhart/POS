report 50003 "Sales Analyze"
{
    dataset
    {
        dataitem(Store; Store)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(No_; "No.") { }
            column(Name; Name) { }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
}
