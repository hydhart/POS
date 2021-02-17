report 50008 "Member Detail Transaction"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Layout/Rep50008.MemberDetailTransaction.rdlc';

    dataset
    {
        dataitem(Member; "Membership Card")
        {
            DataItemTableView = sorting("Club Code", "Scheme Code", Status);
            RequestFilterFields = "Club Code", "Scheme Code", "Account No.", "Contact No.", "Card No.";

            dataitem(TransLine; "Trans. Sales Entry")
            {
                DataItemTableView = sorting("Card No.");
                RequestFilterFields = Date;
                DataItemLinkReference = Member;
                DataItemLink = "Card No." = field("Card No.");

                column(TransDate; TransLine.Date) { }
                column(DocNo; TransLine."Receipt No.") { }
                column(AccountNo; Member."Account No.") { }
                column(ContactNo; Member."Contact No.") { }
                column(CardNo; Member."Card No.") { }
                column(ClubCode; Member."Club Code") { }
                column(SchemeCode; Member."Scheme Code") { }
                column(MemberName; MemberAccount.Description) { }
                column(Status; MemberAccount.Status) { }
                column(Email; MemberContact."E-Mail") { }
                column(BirthDate; MemberContact."Date of Birth") { }
                column(ItemNo; TransLine."Item No.") { }
                column(ItemDesc; Item.Description) { }
                column(InvPostGroup; Item."Inventory Posting Group") { }
                column(ProductGroup; Item."Retail Product Code") { }
                column(Quantity; TransLine.Quantity) { }
                column(NetAmount; TransLine."Net Amount") { }
                column(GrossAmount; TransLine."Net Amount" + TransLine."VAT Amount") { }
                column(DiscAmount; TransLine."Discount Amount") { }
                column(CostAmount; TransLine."Cost Amount") { }
                column(PointType; MemberEntry."Point Type") { }
                column(Points; MemberEntry.Points) { }

                trigger OnAfterGetRecord()
                begin
                    MemberEntry.SetCurrentKey("Store No.", "POS Terminal No.", "Transaction No.");
                    MemberEntry.SetRange("Store No.", TransLine."Store No.");
                    MemberEntry.SetRange("POS Terminal No.", TransLine."POS Terminal No.");
                    MemberEntry.SetRange("Transaction No.", TransLine."Transaction No.");
                    if not MemberEntry.FindFirst() then
                        MemberEntry.Init();
                    if not Item.Get(TransLine."Item No.") then
                        Item.Init();
                end;
            }
            trigger OnAfterGetRecord()
            var
            begin
                if not MemberAccount.Get(Member."Account No.") then
                    MemberAccount.Init();
                if not MemberContact.Get(Member."Contact No.") then
                    MemberContact.Init();
            end;
        }
    }

    var
        MemberAccount: Record "Member Account";
        MemberContact: Record "Member Contact";
        Item: Record Item;
        MemberEntry: Record "Member Point Entry";
}