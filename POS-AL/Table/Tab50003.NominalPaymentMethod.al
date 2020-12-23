table 50003 "Nominal Payment Method"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; enum "NP Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Type';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
            trigger OnValidate()
            var
                PaymentMethod: Record "Payment Method";
            begin
                if PaymentMethod.Get("Payment Method Code") then
                    Description := PaymentMethod.Description
                else
                    Clear(Description);
            end;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; Nominal; Decimal)
        {
            Caption = 'Nominal';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Payment Method Code")
        {
            Clustered = true;
        }
    }
}