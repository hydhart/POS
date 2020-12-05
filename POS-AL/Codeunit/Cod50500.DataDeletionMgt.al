codeunit 50500 "Data Deletion Mgt."
{
    trigger OnRun()
    begin

    end;


    procedure SuggestDefaultTables(CompName: Code[30]; TemplateName: Code[20]; TransTableOnly: Boolean)
    begin
        dlg.Open(Text100);
        if not TransTableOnly then begin
            //>> Master/Setup ======
            // BC
            AddTable(CompName, TemplateName, 3); //	    Payment Terms
            AddTable(CompName, TemplateName, 4); //	    Currency
            AddTable(CompName, TemplateName, 5); //	    Finance Charge Terms
            AddTable(CompName, TemplateName, 6); //	    Customer Price Group
            AddTable(CompName, TemplateName, 7); //	    Standard Text
            AddTable(CompName, TemplateName, 8); //	    Language
            AddTable(CompName, TemplateName, 9); //	    Country/Region
            AddTable(CompName, TemplateName, 10); //    Shipment Method
            AddTable(CompName, TemplateName, 13); //    Salesperson/Purchaser
            AddTable(CompName, TemplateName, 14); //    Location
            AddTable(CompName, TemplateName, 15); //    G/L Account
            AddTable(CompName, TemplateName, 18); //    Customer
            AddTable(CompName, TemplateName, 19); //    Cust. Invoice Disc.
            AddTable(CompName, TemplateName, 23); //    Vendor
            AddTable(CompName, TemplateName, 24); //    Vendor Invoice Disc.
            AddTable(CompName, TemplateName, 27); //    Item
            AddTable(CompName, TemplateName, 30); //    Item Translation
            AddTable(CompName, TemplateName, 42); //    Rounding Method
            AddTable(CompName, TemplateName, 50); // 	Accounting Period
            AddTable(CompName, TemplateName, 80); // 	Gen. Journal Template
            AddTable(CompName, TemplateName, 82); // 	Item Journal Template
            AddTable(CompName, TemplateName, 90); // 	BOM Component
            AddTable(CompName, TemplateName, 91); // 	User Setup
            AddTable(CompName, TemplateName, 92); // 	Customer Posting Group
            AddTable(CompName, TemplateName, 93); // 	Vendor Posting Group
            AddTable(CompName, TemplateName, 94); // 	Inventory Posting Group
            AddTable(CompName, TemplateName, 95); // 	G/L Budget Name
            AddTable(CompName, TemplateName, 98); // 	General Ledger Setup
            AddTable(CompName, TemplateName, 99); // 	Item Vendor
            AddTable(CompName, TemplateName, 156); // 	Resource
            AddTable(CompName, TemplateName, 167); // 	Job
            AddTable(CompName, TemplateName, 170); // 	Standard Sales Code
            AddTable(CompName, TemplateName, 171); // 	Standard Sales Line
            AddTable(CompName, TemplateName, 172); // 	Standard Customer Sales Code
            AddTable(CompName, TemplateName, 173); // 	Standard Purchase Code
            AddTable(CompName, TemplateName, 174); // 	Standard Purchase Line
            AddTable(CompName, TemplateName, 175); // 	Standard Vendor Purchase Code
            AddTable(CompName, TemplateName, 197); // 	Acc. Sched. KPI Buffer
            AddTable(CompName, TemplateName, 200); // 	Work Type
            AddTable(CompName, TemplateName, 204); // 	Unit of Measure
            AddTable(CompName, TemplateName, 205); // 	Resource Unit of Measure
            AddTable(CompName, TemplateName, 206); // 	Res. Journal Template
            AddTable(CompName, TemplateName, 208); // 	Job Posting Group
            AddTable(CompName, TemplateName, 209); // 	Job Journal Template
            AddTable(CompName, TemplateName, 222); //	Ship-to Address
            AddTable(CompName, TemplateName, 224); //	Order Address
            AddTable(CompName, TemplateName, 225); //	Post Code
            AddTable(CompName, TemplateName, 230); //	Source Code
            AddTable(CompName, TemplateName, 231); //	Reason Code
            AddTable(CompName, TemplateName, 232); //	Gen. Journal Batch
            AddTable(CompName, TemplateName, 233); //	Item Journal Batch
            AddTable(CompName, TemplateName, 236); //	Res. Journal Batch
            AddTable(CompName, TemplateName, 237); //	Job Journal Batch
            AddTable(CompName, TemplateName, 242); //	Source Code Setup
            AddTable(CompName, TemplateName, 244); //	Req. Wksh. Template
            AddTable(CompName, TemplateName, 245); //	Requisition Wksh. Name
            AddTable(CompName, TemplateName, 247); //	Intrastat Setup
            AddTable(CompName, TemplateName, 248); //	VAT Reg. No. Srv Config
            AddTable(CompName, TemplateName, 250); //	Gen. Business Posting Group
            AddTable(CompName, TemplateName, 251); //	Gen. Product Posting Group
            AddTable(CompName, TemplateName, 252); //	General Posting Setup
            AddTable(CompName, TemplateName, 255); //	VAT Statement Template
            AddTable(CompName, TemplateName, 257); //	VAT Statement Name
            AddTable(CompName, TemplateName, 258); //	Transaction Type
            AddTable(CompName, TemplateName, 259); //	Transport Method
            AddTable(CompName, TemplateName, 260); //	Tariff Number
            AddTable(CompName, TemplateName, 261); //	Intrastat Jnl. Template
            AddTable(CompName, TemplateName, 262); //	Intrastat Jnl. Batch
            AddTable(CompName, TemplateName, 266); //	Customer Amount
            AddTable(CompName, TemplateName, 270); //	Bank Account
            AddTable(CompName, TemplateName, 275); //	Bank Account Statement
            AddTable(CompName, TemplateName, 277); //	Bank Account Posting Group
            AddTable(CompName, TemplateName, 279); //	Extended Text Header
            AddTable(CompName, TemplateName, 280); //	Extended Text Line
            AddTable(CompName, TemplateName, 286); //	Territory
            AddTable(CompName, TemplateName, 287); //	Customer Bank Account
            AddTable(CompName, TemplateName, 288); //	Vendor Bank Account
            AddTable(CompName, TemplateName, 289); //	Payment Method
            AddTable(CompName, TemplateName, 291); //	Shipping Agent
            AddTable(CompName, TemplateName, 292); //	Reminder Terms
            AddTable(CompName, TemplateName, 293); //	Reminder Level
            AddTable(CompName, TemplateName, 294); //	Reminder Text
            AddTable(CompName, TemplateName, 301); //	Finance Charge Text
            AddTable(CompName, TemplateName, 308); //	No. Series
            AddTable(CompName, TemplateName, 309); //	No. Series Line
            AddTable(CompName, TemplateName, 310); //	No. Series Relationship
            AddTable(CompName, TemplateName, 311); //	Sales & Receivables Setup
            AddTable(CompName, TemplateName, 312); //	Purchases & Payables Setup
            AddTable(CompName, TemplateName, 313); //	Inventory Setup
            AddTable(CompName, TemplateName, 314); //	Resources Setup
            AddTable(CompName, TemplateName, 315); //	Jobs Setup
            AddTable(CompName, TemplateName, 323); //	VAT Business Posting Group
            AddTable(CompName, TemplateName, 324); //	VAT Product Posting Group
            AddTable(CompName, TemplateName, 325); //	VAT Posting Setup
            AddTable(CompName, TemplateName, 326); //	Tax Setup
            AddTable(CompName, TemplateName, 328); //	Currency for Fin. Charge Terms
            AddTable(CompName, TemplateName, 329); //	Currency for Reminder Level
            AddTable(CompName, TemplateName, 330); //	Currency Exchange Rate
            AddTable(CompName, TemplateName, 333); //	Column Layout Name
            AddTable(CompName, TemplateName, 334); //	Column Layout
            AddTable(CompName, TemplateName, 340); //	Customer Discount Group
            AddTable(CompName, TemplateName, 341); //	Item Discount Group
            AddTable(CompName, TemplateName, 348); //	Dimension
            AddTable(CompName, TemplateName, 349); //	Dimension Value
            AddTable(CompName, TemplateName, 350); //	Dimension Combination
            AddTable(CompName, TemplateName, 351); //	Dimension Value Combination
            AddTable(CompName, TemplateName, 352); //	Default Dimension
            AddTable(CompName, TemplateName, 354); //	Default Dimension Priority
            AddTable(CompName, TemplateName, 363); //	Analysis View
            AddTable(CompName, TemplateName, 365); //	Analysis View Entry
            AddTable(CompName, TemplateName, 366); //	Analysis View Budget Entry
            AddTable(CompName, TemplateName, 379); //	Detailed Cust. Ledg. Entry
            AddTable(CompName, TemplateName, 380); //	Detailed Vendor Ledg. Entry
            AddTable(CompName, TemplateName, 381); //	VAT Registration No. Format
            AddTable(CompName, TemplateName, 388); //	Dimension Translation
            AddTable(CompName, TemplateName, 394); //	XBRL Taxonomy
            AddTable(CompName, TemplateName, 395); //	XBRL Taxonomy Line
            AddTable(CompName, TemplateName, 398); //	XBRL Rollup Line
            AddTable(CompName, TemplateName, 399); //	XBRL Schema
            AddTable(CompName, TemplateName, 400); //	XBRL Linkbase
            AddTable(CompName, TemplateName, 401); //	XBRL Taxonomy Label
            AddTable(CompName, TemplateName, 409); //	SMTP Mail Setup
            AddTable(CompName, TemplateName, 410); //	IC G/L Account
            AddTable(CompName, TemplateName, 411); //	IC Dimension
            AddTable(CompName, TemplateName, 412); //	IC Dimension Value
            AddTable(CompName, TemplateName, 413); //	IC Partner
            AddTable(CompName, TemplateName, 471); //	Job Queue Category
            AddTable(CompName, TemplateName, 480); //	Dimension Set Entry
            AddTable(CompName, TemplateName, 481); //	Dimension Set Tree Node
            AddTable(CompName, TemplateName, 570); //	G/L Account Category
            AddTable(CompName, TemplateName, 743); //	VAT Report Setup
            AddTable(CompName, TemplateName, 746); //	VAT Reports Configuration
            AddTable(CompName, TemplateName, 750); //	Standard General Journal
            AddTable(CompName, TemplateName, 752); //	Standard Item Journal
            AddTable(CompName, TemplateName, 760); //	Trailing Sales Orders Setup
            AddTable(CompName, TemplateName, 762); //	Account Schedules Chart Setup
            AddTable(CompName, TemplateName, 763); //	Acc. Sched. Chart Setup Line
            AddTable(CompName, TemplateName, 770); //	Analysis Report Chart Setup
            AddTable(CompName, TemplateName, 800); //	Online Map Setup
            AddTable(CompName, TemplateName, 801); //	Online Map Parameter Setup
            AddTable(CompName, TemplateName, 823); //	Name/Value Buffer
            AddTable(CompName, TemplateName, 840); //	Cash Flow Forecast
            AddTable(CompName, TemplateName, 841); //	Cash Flow Account
            AddTable(CompName, TemplateName, 843); //	Cash Flow Setup
            AddTable(CompName, TemplateName, 849); //	Cash Flow Manual Revenue
            AddTable(CompName, TemplateName, 850); //	Cash Flow Manual Expense
            AddTable(CompName, TemplateName, 856); //	Cash Flow Report Selection
            AddTable(CompName, TemplateName, 870); //	Social Listening Setup
            AddTable(CompName, TemplateName, 905); //	Assembly Setup
            AddTable(CompName, TemplateName, 980); //	Payment Registration Setup
            AddTable(CompName, TemplateName, 1001); //	Job Task
            AddTable(CompName, TemplateName, 1002); //	Job Task Dimension
            AddTable(CompName, TemplateName, 1003); //	Job Planning Line
            AddTable(CompName, TemplateName, 1006); //	Job WIP Method
            AddTable(CompName, TemplateName, 1012); //	Job Resource Price
            AddTable(CompName, TemplateName, 1013); //	Job Item Price
            AddTable(CompName, TemplateName, 1014); //	Job G/L Account Price
            AddTable(CompName, TemplateName, 1100); //	Cost Journal Template
            AddTable(CompName, TemplateName, 1102); //	Cost Journal Batch
            AddTable(CompName, TemplateName, 1103); //	Cost Type
            AddTable(CompName, TemplateName, 1106); //	Cost Allocation Source
            AddTable(CompName, TemplateName, 1107); //	Cost Allocation Target
            AddTable(CompName, TemplateName, 1108); //	Cost Accounting Setup
            AddTable(CompName, TemplateName, 1110); //	Cost Budget Name
            AddTable(CompName, TemplateName, 1111); //	Cost Budget Register
            AddTable(CompName, TemplateName, 1112); //	Cost Center
            AddTable(CompName, TemplateName, 1113); //	Cost Object
            AddTable(CompName, TemplateName, 1200); //	Bank Export/Import Setup
            AddTable(CompName, TemplateName, 1213); //	Data Exchange Type
            AddTable(CompName, TemplateName, 1222); //	Data Exch. Def
            AddTable(CompName, TemplateName, 1223); //	Data Exch. Column Def
            AddTable(CompName, TemplateName, 1224); //	Data Exch. Mapping
            AddTable(CompName, TemplateName, 1225); //	Data Exch. Field Mapping
            AddTable(CompName, TemplateName, 1227); //	Data Exch. Line Def
            AddTable(CompName, TemplateName, 1237); //	Transformation Rule
            AddTable(CompName, TemplateName, 1251); //	Text-to-Account Mapping
            AddTable(CompName, TemplateName, 1252); //	Bank Pmt. Appl. Rule
            AddTable(CompName, TemplateName, 1260); //	Bank Data Conv. Service Setup
            AddTable(CompName, TemplateName, 1261); //	Service Password
            AddTable(CompName, TemplateName, 1270); //	OCR Service Setup
            AddTable(CompName, TemplateName, 1275); //	Doc. Exch. Service Setup
            AddTable(CompName, TemplateName, 1280); //	Bank Clearing Standard
            AddTable(CompName, TemplateName, 1281); //	Bank Data Conversion Pmt. Type
            AddTable(CompName, TemplateName, 1306); //	User Preference
            AddTable(CompName, TemplateName, 1310); //	Chart Definition
            AddTable(CompName, TemplateName, 1312); //	Trial Balance Setup
            AddTable(CompName, TemplateName, 1431); //	Named Forward Link
            AddTable(CompName, TemplateName, 1458); //	RC Headlines User Data
            AddTable(CompName, TemplateName, 1471); //	Product Video Category
            AddTable(CompName, TemplateName, 1515); //	Dynamic Request Page Entity
            AddTable(CompName, TemplateName, 1516); //	Dynamic Request Page Field
            AddTable(CompName, TemplateName, 1518); //	My Notifications
            AddTable(CompName, TemplateName, 1540); //	Workflow User Group
            AddTable(CompName, TemplateName, 1541); //	Workflow User Group Member
            AddTable(CompName, TemplateName, 1601); //	Office Add-in Setup
            AddTable(CompName, TemplateName, 1750); //	Fields Sync Status
            AddTable(CompName, TemplateName, 1803); //	Assisted Setup
            AddTable(CompName, TemplateName, 1806); //	Data Migration Setup
            AddTable(CompName, TemplateName, 1877); //	VAT Setup Posting Groups
            AddTable(CompName, TemplateName, 1879); //	VAT Assisted Setup Bus. Grp.
            AddTable(CompName, TemplateName, 2160); //	Calendar Event
            AddTable(CompName, TemplateName, 2161); //	Calendar Event User Config.
            AddTable(CompName, TemplateName, 3712); //	Translation
            AddTable(CompName, TemplateName, 5050); //	Contact
            AddTable(CompName, TemplateName, 5051); //	Contact Alt. Address
            AddTable(CompName, TemplateName, 5052); //	Contact Alt. Addr. Date Range
            AddTable(CompName, TemplateName, 5053); //	Business Relation
            AddTable(CompName, TemplateName, 5054); //	Contact Business Relation
            AddTable(CompName, TemplateName, 5055); //	Mailing Group
            AddTable(CompName, TemplateName, 5056); //	Contact Mailing Group
            AddTable(CompName, TemplateName, 5057); //	Industry Group
            AddTable(CompName, TemplateName, 5058); //	Contact Industry Group
            AddTable(CompName, TemplateName, 5059); //	Web Source
            AddTable(CompName, TemplateName, 5060); //	Contact Web Source
            AddTable(CompName, TemplateName, 5061); //	Rlshp. Mgt. Comment Line
            AddTable(CompName, TemplateName, 5062); //	Attachment
            AddTable(CompName, TemplateName, 5063); //	Interaction Group
            AddTable(CompName, TemplateName, 5064); //	Interaction Template
            AddTable(CompName, TemplateName, 5066); //	Job Responsibility
            AddTable(CompName, TemplateName, 5067); //	Contact Job Responsibility
            AddTable(CompName, TemplateName, 5068); //	Salutation
            AddTable(CompName, TemplateName, 5069); //	Salutation Formula
            AddTable(CompName, TemplateName, 5070); //	Organizational Level
            AddTable(CompName, TemplateName, 5071); //	Campaign
            AddTable(CompName, TemplateName, 5073); //	Campaign Status
            AddTable(CompName, TemplateName, 5076); //	Segment Header
            AddTable(CompName, TemplateName, 5077); //	Segment Line
            AddTable(CompName, TemplateName, 5078); //	Segment History
            AddTable(CompName, TemplateName, 5079); //	Marketing Setup
            AddTable(CompName, TemplateName, 5080); //	To-do
            AddTable(CompName, TemplateName, 5081); //	Activity
            AddTable(CompName, TemplateName, 5082); //	Activity Step
            AddTable(CompName, TemplateName, 5083); //	Team
            AddTable(CompName, TemplateName, 5084); //	Team Salesperson
            AddTable(CompName, TemplateName, 5085); //	Contact Duplicate
            AddTable(CompName, TemplateName, 5086); //	Cont. Duplicate Search String
            AddTable(CompName, TemplateName, 5087); //	Profile Questionnaire Header
            AddTable(CompName, TemplateName, 5088); //	Profile Questionnaire Line
            AddTable(CompName, TemplateName, 5089); //	Contact Profile Answer
            AddTable(CompName, TemplateName, 5090); //	Sales Cycle
            AddTable(CompName, TemplateName, 5091); //	Sales Cycle Stage
            AddTable(CompName, TemplateName, 5092); //	Opportunity
            AddTable(CompName, TemplateName, 5094); //	Close Opportunity Code
            AddTable(CompName, TemplateName, 5095); //	Duplicate Search String Setup
            AddTable(CompName, TemplateName, 5097); //	Segment Criteria Line
            AddTable(CompName, TemplateName, 5103); //	Interaction Tmpl. Language
            AddTable(CompName, TemplateName, 5104); //	Segment Interaction Language
            AddTable(CompName, TemplateName, 5105); //	Customer Template
            AddTable(CompName, TemplateName, 5111); //	Rating
            AddTable(CompName, TemplateName, 5122); //	Interaction Template Setup
            AddTable(CompName, TemplateName, 5151); //	Integration Record
            AddTable(CompName, TemplateName, 5152); //	Integration Record Archive
            AddTable(CompName, TemplateName, 5199); //	Attendee
            AddTable(CompName, TemplateName, 5200); //	Employee
            AddTable(CompName, TemplateName, 5201); //	Alternative Address
            AddTable(CompName, TemplateName, 5202); //	Qualification
            AddTable(CompName, TemplateName, 5203); //	Employee Qualification
            AddTable(CompName, TemplateName, 5204); //	Relative
            AddTable(CompName, TemplateName, 5205); //	Employee Relative
            AddTable(CompName, TemplateName, 5206); //	Cause of Absence
            AddTable(CompName, TemplateName, 5207); //	Employee Absence
            AddTable(CompName, TemplateName, 5208); //	Human Resource Comment Line
            AddTable(CompName, TemplateName, 5209); //	Union
            AddTable(CompName, TemplateName, 5210); //	Cause of Inactivity
            AddTable(CompName, TemplateName, 5211); //	Employment Contract
            AddTable(CompName, TemplateName, 5212); //	Employee Statistics Group
            AddTable(CompName, TemplateName, 5213); //	Misc. Article
            AddTable(CompName, TemplateName, 5214); //	Misc. Article Information
            AddTable(CompName, TemplateName, 5215); //	Confidential
            AddTable(CompName, TemplateName, 5216); //	Confidential Information
            AddTable(CompName, TemplateName, 5217); //	Grounds for Termination
            AddTable(CompName, TemplateName, 5218); //	Human Resources Setup
            AddTable(CompName, TemplateName, 5220); //	Human Resource Unit of Measure
            AddTable(CompName, TemplateName, 5221); //	Employee Posting Group
            AddTable(CompName, TemplateName, 5401); //	Item Variant
            AddTable(CompName, TemplateName, 5402); //	Unit of Measure Translation
            AddTable(CompName, TemplateName, 5404); //	Item Unit of Measure
            AddTable(CompName, TemplateName, 5600); //	Fixed Asset
            AddTable(CompName, TemplateName, 5603); //	FA Setup
            AddTable(CompName, TemplateName, 5604); //	FA Posting Type Setup
            AddTable(CompName, TemplateName, 5605); //	FA Journal Setup
            AddTable(CompName, TemplateName, 5606); //	FA Posting Group
            AddTable(CompName, TemplateName, 5607); //	FA Class
            AddTable(CompName, TemplateName, 5608); //	FA Subclass
            AddTable(CompName, TemplateName, 5609); //	FA Location
            AddTable(CompName, TemplateName, 5611); //	Depreciation Book
            AddTable(CompName, TemplateName, 5612); //	FA Depreciation Book
            AddTable(CompName, TemplateName, 5615); //	FA Allocation
            AddTable(CompName, TemplateName, 5616); //	Maintenance Registration
            AddTable(CompName, TemplateName, 5619); //	FA Journal Template
            AddTable(CompName, TemplateName, 5620); //	FA Journal Batch
            AddTable(CompName, TemplateName, 5622); //	FA Reclass. Journal Template
            AddTable(CompName, TemplateName, 5623); //	FA Reclass. Journal Batch
            AddTable(CompName, TemplateName, 5626); //	Maintenance
            AddTable(CompName, TemplateName, 5628); //	Insurance
            AddTable(CompName, TemplateName, 5630); //	Insurance Type
            AddTable(CompName, TemplateName, 5633); //	Insurance Journal Template
            AddTable(CompName, TemplateName, 5634); //	Insurance Journal Batch
            AddTable(CompName, TemplateName, 5640); //	Main Asset Component
            AddTable(CompName, TemplateName, 5700); //	Stockkeeping Unit
            AddTable(CompName, TemplateName, 5714); //	Responsibility Center
            AddTable(CompName, TemplateName, 5715); //	Item Substitution
            AddTable(CompName, TemplateName, 5717); //	Item Cross Reference
            AddTable(CompName, TemplateName, 5718); //	Nonstock Item
            AddTable(CompName, TemplateName, 5719); //	Nonstock Item Setup
            AddTable(CompName, TemplateName, 5720); //	Manufacturer
            AddTable(CompName, TemplateName, 5721); //	Purchasing
            AddTable(CompName, TemplateName, 5722); //	Item Category
            AddTable(CompName, TemplateName, 5723); //	Product Group
            AddTable(CompName, TemplateName, 5769); //	Nonstock Item Setup
            AddTable(CompName, TemplateName, 5720); //	Manufacturer
            AddTable(CompName, TemplateName, 5721); //	Purchasing
            AddTable(CompName, TemplateName, 5722); //	Item Category
            AddTable(CompName, TemplateName, 5723); //	Product Group
            AddTable(CompName, TemplateName, 5769); //	Warehouse Setup
            AddTable(CompName, TemplateName, 5771); //	Warehouse Source Filter
            AddTable(CompName, TemplateName, 5772); //	Registered Whse. Activity Hdr.
            AddTable(CompName, TemplateName, 5773); //	Registered Whse. Activity Line
            AddTable(CompName, TemplateName, 5790); //	Shipping Agent Services
            AddTable(CompName, TemplateName, 5800); //	Item Charge
            AddTable(CompName, TemplateName, 5804); //	Avg. Cost Adjmt. Entry Point
            AddTable(CompName, TemplateName, 5811); //	Post Value Entry to G/L
            AddTable(CompName, TemplateName, 5813); //	Inventory Posting Setup
            AddTable(CompName, TemplateName, 5903); //	Service Order Type
            AddTable(CompName, TemplateName, 5904); //	Service Item Group
            AddTable(CompName, TemplateName, 5905); //	Service Cost
            AddTable(CompName, TemplateName, 5910); //	Service Hour
            AddTable(CompName, TemplateName, 5911); //	Service Mgt. Setup
            AddTable(CompName, TemplateName, 5913); //	Loaner
            AddTable(CompName, TemplateName, 5915); //	Fault Area
            AddTable(CompName, TemplateName, 5916); //	Symptom Code
            AddTable(CompName, TemplateName, 5917); //	Fault Reason Code
            AddTable(CompName, TemplateName, 5918); //	Fault Code
            AddTable(CompName, TemplateName, 5919); //	Resolution Code
            AddTable(CompName, TemplateName, 5927); //	Repair Status
            AddTable(CompName, TemplateName, 5928); //	Service Status Priority Setup
            AddTable(CompName, TemplateName, 5929); //	Service Shelf
            AddTable(CompName, TemplateName, 5940); //	Service Item
            AddTable(CompName, TemplateName, 5941); //	Service Item Component
            AddTable(CompName, TemplateName, 5942); //	Service Item Log
            AddTable(CompName, TemplateName, 5945); //	Troubleshooting Setup
            AddTable(CompName, TemplateName, 5950); //	Service Order Allocation
            AddTable(CompName, TemplateName, 5954); //	Work-Hour Template
            AddTable(CompName, TemplateName, 5955); //	Skill Code
            AddTable(CompName, TemplateName, 5956); //	Resource Skill
            AddTable(CompName, TemplateName, 5957); //	Service Zone
            AddTable(CompName, TemplateName, 5958); //	Resource Service Zone
            AddTable(CompName, TemplateName, 5966); //	Contract Group
            AddTable(CompName, TemplateName, 5967); //	Contract Change Log
            AddTable(CompName, TemplateName, 5968); //	Service Contract Template
            AddTable(CompName, TemplateName, 5973); //	Service Contract Account Group
            AddTable(CompName, TemplateName, 6060); //	Hybrid Deployment Setup
            AddTable(CompName, TemplateName, 6080); //	Service Price Group
            AddTable(CompName, TemplateName, 6081); //	Serv. Price Group Setup
            AddTable(CompName, TemplateName, 6082); //	Service Price Adjustment Group
            AddTable(CompName, TemplateName, 6083); //	Serv. Price Adjustment Detail
            AddTable(CompName, TemplateName, 6303); //	Azure AD Mgt. Setup
            AddTable(CompName, TemplateName, 6304); //	Power BI User Configuration
            AddTable(CompName, TemplateName, 6502); //	Item Tracking Code
            AddTable(CompName, TemplateName, 6635); //	Return Reason
            AddTable(CompName, TemplateName, 7002); //	Sales Price
            AddTable(CompName, TemplateName, 7004); //	Sales Line Discount
            AddTable(CompName, TemplateName, 7012); //	Purchase Price
            AddTable(CompName, TemplateName, 7014); //	Purchase Line Discount
            AddTable(CompName, TemplateName, 7111); //	Analysis Report Name
            AddTable(CompName, TemplateName, 7112); //	Analysis Line Template
            AddTable(CompName, TemplateName, 7113); //	Analysis Type
            AddTable(CompName, TemplateName, 7114); //	Analysis Line
            AddTable(CompName, TemplateName, 7116); //	Analysis Column Template
            AddTable(CompName, TemplateName, 7118); //	Analysis Column
            AddTable(CompName, TemplateName, 7132); //	Item Budget Name
            AddTable(CompName, TemplateName, 7152); //	Item Analysis View
            AddTable(CompName, TemplateName, 7300); //	Zone
            AddTable(CompName, TemplateName, 7302); //	Bin Content
            AddTable(CompName, TemplateName, 7303); //	Bin Type
            AddTable(CompName, TemplateName, 7304); //	Warehouse Class
            AddTable(CompName, TemplateName, 7305); //	Special Equipment
            AddTable(CompName, TemplateName, 7307); //	Put-away Template Header
            AddTable(CompName, TemplateName, 7308); //	Put-away Template Line
            AddTable(CompName, TemplateName, 7309); //	Warehouse Journal Template
            AddTable(CompName, TemplateName, 7310); //	Warehouse Journal Batch
            AddTable(CompName, TemplateName, 7327); //	Whse. Worksheet Name
            AddTable(CompName, TemplateName, 7328); //	Whse. Worksheet Template
            AddTable(CompName, TemplateName, 7336); //	Bin Creation Wksh. Template
            AddTable(CompName, TemplateName, 7337); //	Bin Creation Wksh. Name
            AddTable(CompName, TemplateName, 7354); //	Bin
            AddTable(CompName, TemplateName, 7355); //	Report Selection Warehouse
            AddTable(CompName, TemplateName, 7381); //	Phys. Invt. Counting Period
            AddTable(CompName, TemplateName, 7500); //	Item Attribute
            AddTable(CompName, TemplateName, 7501); //	Item Attribute Value
            AddTable(CompName, TemplateName, 7505); //	Item Attribute Value Mapping
            AddTable(CompName, TemplateName, 7600); //	Base Calendar
            AddTable(CompName, TemplateName, 7601); //	Base Calendar Change
            AddTable(CompName, TemplateName, 7700); //	Miniform Header
            AddTable(CompName, TemplateName, 7701); //	Miniform Line
            AddTable(CompName, TemplateName, 7702); //	Miniform Function Group
            AddTable(CompName, TemplateName, 7703); //	Miniform Function
            AddTable(CompName, TemplateName, 7704); //	Item Identifier
            AddTable(CompName, TemplateName, 8451); //	Intrastat Checklist Setup
            AddTable(CompName, TemplateName, 9008); //	User Login

            // LS
            AddTable(CompName, TemplateName, 10000700); //	Retail Setup
            AddTable(CompName, TemplateName, 10000701); //	Retail Hierarchy
            AddTable(CompName, TemplateName, 10000702); //	Retail Hierarchy Value
            AddTable(CompName, TemplateName, 10000703); //	Retail Hierarchy Defaults
            AddTable(CompName, TemplateName, 10000704); //	Item Distribution
            AddTable(CompName, TemplateName, 10000705); //	Retail Product Group
            AddTable(CompName, TemplateName, 10000709); //	Retail Comment Line
            AddTable(CompName, TemplateName, 10000710); //	Table Lookup Setup
            AddTable(CompName, TemplateName, 10000711); //	Price History
            AddTable(CompName, TemplateName, 10000712); //	Store Location Profiles
            AddTable(CompName, TemplateName, 10000713); //	Stores In Location Profile
            AddTable(CompName, TemplateName, 10000723); //	Attribute Group
            AddTable(CompName, TemplateName, 10000724); //	Attribute Group Attribute
            AddTable(CompName, TemplateName, 10000729); //	MSR Card Link Setup
            AddTable(CompName, TemplateName, 10000730); //	Item Default Settings
            AddTable(CompName, TemplateName, 10000733); //	Periods
            AddTable(CompName, TemplateName, 10000735); //	Item Special Groups
            AddTable(CompName, TemplateName, 10000736); //	Item/Special Group Link
            AddTable(CompName, TemplateName, 10000737); //	Selected Quantity
            AddTable(CompName, TemplateName, 10000739); //	Store Sales
            AddTable(CompName, TemplateName, 10000740); //	Store Messenger Line
            AddTable(CompName, TemplateName, 10000741); //	Reason Code Groups
            AddTable(CompName, TemplateName, 10000742); //	Retail User
            AddTable(CompName, TemplateName, 10000743); //	Store Messenger Header
            AddTable(CompName, TemplateName, 10000746); //	Create New Company Setup
            AddTable(CompName, TemplateName, 10000744); //	Messenger Header
            AddTable(CompName, TemplateName, 10000745); //	Messenger Line
            AddTable(CompName, TemplateName, 10000747); //	Retail Campaign Header
            AddTable(CompName, TemplateName, 10000748); //	Retail Campaign Line
            AddTable(CompName, TemplateName, 10000749); //	BOM Version
            AddTable(CompName, TemplateName, 10000751); //	Dyn. Item Hierarchy
            AddTable(CompName, TemplateName, 10000754); //	Store Viewer
            AddTable(CompName, TemplateName, 10000755); //	Item Hierarchy Viewer
            AddTable(CompName, TemplateName, 10000756); //	Product Group Locator
            AddTable(CompName, TemplateName, 10000757); //	Retail Campaign Page
            AddTable(CompName, TemplateName, 10000758); //	Retail System Log
            AddTable(CompName, TemplateName, 10000759); //	Item Finder Setup
            AddTable(CompName, TemplateName, 10000760); //	Item Finder Setup Line
            AddTable(CompName, TemplateName, 10000766); //	Search Index Table
            AddTable(CompName, TemplateName, 10000767); //	Search Index Field
            AddTable(CompName, TemplateName, 10000769); //	Search Index Action
            AddTable(CompName, TemplateName, 10000770); //	Gift Registration
            AddTable(CompName, TemplateName, 10000771); //	Gift Registration Lines
            AddTable(CompName, TemplateName, 10000772); //	POS Print Buffer
            AddTable(CompName, TemplateName, 10000774); //	Retail ICT Setup
            AddTable(CompName, TemplateName, 10000779); //	Store Group
            AddTable(CompName, TemplateName, 10000782); //	Store Group Setup
            AddTable(CompName, TemplateName, 10000784); //	Attribute
            AddTable(CompName, TemplateName, 10000785); //	Attribute Option Value
            AddTable(CompName, TemplateName, 10000786); //	Attribute Value
            AddTable(CompName, TemplateName, 10000787); //	Division
            AddTable(CompName, TemplateName, 10000788); //	Attribute Setup
            AddTable(CompName, TemplateName, 10000900); //	LS Retail Module Obj. Range
            AddTable(CompName, TemplateName, 10000902); //	LS Retail Modules
            AddTable(CompName, TemplateName, 10000915); //	Hierarchy Relation
            AddTable(CompName, TemplateName, 10000917); //	Hierarchy Relation Entry
            AddTable(CompName, TemplateName, 10000920); //	Hierarchy
            AddTable(CompName, TemplateName, 10000921); //	Hierarchy Nodes
            AddTable(CompName, TemplateName, 10000922); //	Hierarchy Node Link
            AddTable(CompName, TemplateName, 10000927); //	Hierarchy Date
            AddTable(CompName, TemplateName, 10000930); //	Item Link Group
            AddTable(CompName, TemplateName, 10000931); //	Item Link
            AddTable(CompName, TemplateName, 10000933); //	Bing Maps API Setup
            AddTable(CompName, TemplateName, 10000936); //	GS1 DataBar Barcode Setup
            AddTable(CompName, TemplateName, 10000980); //	AggregateGroupItem
            AddTable(CompName, TemplateName, 10000981); //	AggregateGroup
            AddTable(CompName, TemplateName, 10000982); //	AggregateProfileGroup
            AddTable(CompName, TemplateName, 10000983); //	AggregateProfile
            AddTable(CompName, TemplateName, 10000984); //	KDS Field Data
            AddTable(CompName, TemplateName, 10000985); //	KitchenDisplayStation
            AddTable(CompName, TemplateName, 10000996); //	KitchenDisplayProfile
            AddTable(CompName, TemplateName, 10000998); //	KitchenDisplayTimeStyle
            AddTable(CompName, TemplateName, 10001200); //	Delivery Street
            AddTable(CompName, TemplateName, 10001201); //	UIStyles
            AddTable(CompName, TemplateName, 10001202); //	POSMenuHeader
            AddTable(CompName, TemplateName, 10001206); //	Dining Table Property
            AddTable(CompName, TemplateName, 10001209); //	Hospitality Setup
            AddTable(CompName, TemplateName, 10001210); //	KitchenDisplayVisualProfile
            AddTable(CompName, TemplateName, 10001212); //	Hospitality Type
            AddTable(CompName, TemplateName, 10001221); //	Restaurant Menu Type
            AddTable(CompName, TemplateName, 10001222); //	Dining Area Layout
            AddTable(CompName, TemplateName, 10001225); //	KDS Load Configuration
            AddTable(CompName, TemplateName, 10001226); //	Dining Table Design Location
            AddTable(CompName, TemplateName, 10001228); //	KDS Display Station
            AddTable(CompName, TemplateName, 10001234); //	KDS Sect. Displ. Stat. Mapping
            AddTable(CompName, TemplateName, 10001251); //	KOT Order Status Setup
            AddTable(CompName, TemplateName, 10001258); //	KitchenDisplayLine
            AddTable(CompName, TemplateName, 10001259); //	KitchenDisplayLineColumn
            AddTable(CompName, TemplateName, 10001261); //	Dining Duration
            AddTable(CompName, TemplateName, 10001262); //	Dining Duration Line
            AddTable(CompName, TemplateName, 10001263); //	KDS Style Profile
            AddTable(CompName, TemplateName, 10001264); //	KDS State Style
            AddTable(CompName, TemplateName, 10001265); //	KDS Style Type State
            AddTable(CompName, TemplateName, 10001266); //	KDS Display Profile
            AddTable(CompName, TemplateName, 10001267); //	KDS Display Profile Line
            AddTable(CompName, TemplateName, 10001269); //	KDS Visual Profile
            AddTable(CompName, TemplateName, 10001301); //	KDS Functional Profile
            AddTable(CompName, TemplateName, 10001305); //	KDS Button Profile
            AddTable(CompName, TemplateName, 10001307); //	KDS Button Profile Line
            AddTable(CompName, TemplateName, 10001308); //	Time Schedule
            AddTable(CompName, TemplateName, 10001309); //	Handheld User Setup
            AddTable(CompName, TemplateName, 10001310); //	Batch Import Paths
            AddTable(CompName, TemplateName, 10001311); //	Time Schedule Line
            AddTable(CompName, TemplateName, 10001312); //	Store Inventory Worksheet
            AddTable(CompName, TemplateName, 10001314); //	Store Inventory Setup
            AddTable(CompName, TemplateName, 10001316); //	Store Inventory Counting Area
            AddTable(CompName, TemplateName, 10001321); //	Batch Export Paths
            AddTable(CompName, TemplateName, 10001324); //	Inventory Management Setup
            AddTable(CompName, TemplateName, 10001350); //	InStore Setup
            AddTable(CompName, TemplateName, 10001351); //	InStore Dist. Location Setup
            AddTable(CompName, TemplateName, 10001365); //	Kitchen Service Configuration
            AddTable(CompName, TemplateName, 10001368); //	ASN Trust Profile
            AddTable(CompName, TemplateName, 10001399); //	Item Status Link Worktable
            AddTable(CompName, TemplateName, 10001400); //	Season
            AddTable(CompName, TemplateName, 10001401); //	LS Event
            AddTable(CompName, TemplateName, 10001403); //	Item Status
            AddTable(CompName, TemplateName, 10001404); //	Item Status Link
            AddTable(CompName, TemplateName, 10001405); //	Item Error Check
            AddTable(CompName, TemplateName, 10001411); //	Item HTML
            AddTable(CompName, TemplateName, 10001412); //	Extended Variant Dimensions
            AddTable(CompName, TemplateName, 10001413); //	Extended Variant Values
            AddTable(CompName, TemplateName, 10001414); //	Item Variant Registration
            AddTable(CompName, TemplateName, 10001415); //	Variant Framework Temp
            AddTable(CompName, TemplateName, 10001416); //	Store Location
            AddTable(CompName, TemplateName, 10001417); //	Variant Framework Setup
            AddTable(CompName, TemplateName, 10001426); //	POS Search
            AddTable(CompName, TemplateName, 10001430); //	Collection Framework
            AddTable(CompName, TemplateName, 10001432); //	Create Items Header
            AddTable(CompName, TemplateName, 10001433); //	Create Items Lines
            AddTable(CompName, TemplateName, 10001434); //	Loading Card Setup
            AddTable(CompName, TemplateName, 10001435); //	Loading Card
            AddTable(CompName, TemplateName, 10001436); //	Retail Competitors
            AddTable(CompName, TemplateName, 10001439); //	Sales Type
            AddTable(CompName, TemplateName, 10001446); //	Period Group
            AddTable(CompName, TemplateName, 10001451); //	Attribute Linking
            AddTable(CompName, TemplateName, 10001452); //	Retail Charge
            AddTable(CompName, TemplateName, 10001453); //	Retail Charge Line
            AddTable(CompName, TemplateName, 10001456); //	Dining Area Plan Templ. Line
            AddTable(CompName, TemplateName, 10001457); //	Dining Area Plan Template
            AddTable(CompName, TemplateName, 10001458); //	Dining Area Section
            AddTable(CompName, TemplateName, 10001459); //	Dining Area Plan
            AddTable(CompName, TemplateName, 10001462); //	Dining Table Type
            AddTable(CompName, TemplateName, 10001463); //	Combined Dining Table
            AddTable(CompName, TemplateName, 10001464); //	Combined Dining Table Line
            AddTable(CompName, TemplateName, 10001465); //	Dining Table Alloc. Ranking
            AddTable(CompName, TemplateName, 10001466); //	Date Schedule
            AddTable(CompName, TemplateName, 10001469); //	Dining Reserv. History Entry
            AddTable(CompName, TemplateName, 10012100); //	Meal Planning Setup
            AddTable(CompName, TemplateName, 10012101); //	Meal Plan Menu
            AddTable(CompName, TemplateName, 10012102); //	Meal Plan Submenu Code
            AddTable(CompName, TemplateName, 10012104); //	Day Plan
            AddTable(CompName, TemplateName, 10012105); //	Day Plan Line
            AddTable(CompName, TemplateName, 10012106); //	Menu Dish
            AddTable(CompName, TemplateName, 10012107); //	Dish
            AddTable(CompName, TemplateName, 10012108); //	Product Nutrition Category
            AddTable(CompName, TemplateName, 10012109); //	Product Nutrition
            AddTable(CompName, TemplateName, 10012110); //	Product Nutrition Group
            AddTable(CompName, TemplateName, 10012111); //	Recipe Grouping
            AddTable(CompName, TemplateName, 10012112); //	Recipe/Item Nutrition
            AddTable(CompName, TemplateName, 10012113); //	Product Nutrition Value
            AddTable(CompName, TemplateName, 10012114); //	Recipe/Item Nutrition Value
            AddTable(CompName, TemplateName, 10012115); //	Nutrition Nutrient
            AddTable(CompName, TemplateName, 10012117); //	POS Trans. Guest Info
            AddTable(CompName, TemplateName, 10012118); //	Transaction Guest Info
            AddTable(CompName, TemplateName, 10012119); //	POS Terminal Group
            AddTable(CompName, TemplateName, 10012120); //	POS Terminal Group Line
            AddTable(CompName, TemplateName, 10012123); //	Rest. Prod. Timing Scheme
            AddTable(CompName, TemplateName, 10012124); //	Rest. Default Load Schedule
            AddTable(CompName, TemplateName, 10012125); //	KOT Header
            AddTable(CompName, TemplateName, 10012126); //	KOT Line
            AddTable(CompName, TemplateName, 10012127); //	KOT Line Routing
            AddTable(CompName, TemplateName, 10012128); //	KOT Line Modifier/Message
            AddTable(CompName, TemplateName, 10012130); //	KDS Production Section
            AddTable(CompName, TemplateName, 10012131); //	KDS Item Section Routing
            AddTable(CompName, TemplateName, 10012133); //	KOT Header Routing
            AddTable(CompName, TemplateName, 10012142); //	KOT Report Period
            AddTable(CompName, TemplateName, 10012145); //	Hospitality Status Setup
            AddTable(CompName, TemplateName, 10012146); //	Hospitality Service Flow
            AddTable(CompName, TemplateName, 10012147); //	Hosp. Service Flow Line
            AddTable(CompName, TemplateName, 10012148); //	Dining Table Status
            AddTable(CompName, TemplateName, 10012149); //	Dining Area
            AddTable(CompName, TemplateName, 10012151); //	Hosp. Order Trans. Status
            AddTable(CompName, TemplateName, 10012152); //	Default Restaurant Menu Type
            AddTable(CompName, TemplateName, 10012154); //	Pos Tr. Line Displ. Stat. Rout
            AddTable(CompName, TemplateName, 10012155); //	HMP Action
            AddTable(CompName, TemplateName, 10012156); //	HMP Status Action Set
            AddTable(CompName, TemplateName, 10012157); //	HMP Status Action Set Line
            AddTable(CompName, TemplateName, 10012158); //	HMP Status Color Set
            AddTable(CompName, TemplateName, 10012159); //	HMP Status Color Set Line
            AddTable(CompName, TemplateName, 10012160); //	HMP Dining Tbl. Main Status
            AddTable(CompName, TemplateName, 10012161); //	Hosp. Standard Text
            AddTable(CompName, TemplateName, 10012200); //	Replen. Setup
            AddTable(CompName, TemplateName, 10012201); //	Replen. Template
            AddTable(CompName, TemplateName, 10012202); //	Replen. Journal Batch
            AddTable(CompName, TemplateName, 10012203); //	Replen. Journal Lines
            AddTable(CompName, TemplateName, 10012204); //	Replen. Jrnl. Details
            AddTable(CompName, TemplateName, 10012205); //	Replen. Item Quantity
            AddTable(CompName, TemplateName, 10012206); //	Replen. Item Store Rec
            AddTable(CompName, TemplateName, 10012207); //	Replen. Sales Profile
            AddTable(CompName, TemplateName, 10012208); //	Replen. Sales Profile Line
            AddTable(CompName, TemplateName, 10012209); //	Replen. Out of Stock Log
            AddTable(CompName, TemplateName, 10012210); //	Replen. Grade
            AddTable(CompName, TemplateName, 10012211); //	Replen. Loc. Item Grades
            AddTable(CompName, TemplateName, 10012212); //	Replen. Forw Sales Profile
            AddTable(CompName, TemplateName, 10012214); //	Replen. Sales Hist. Adj.
            AddTable(CompName, TemplateName, 10012215); //	Replen. Calendar
            AddTable(CompName, TemplateName, 10012216); //	Replen. Item Profile
            AddTable(CompName, TemplateName, 10012218); //	Buyer Group
            AddTable(CompName, TemplateName, 10012219); //	Purchase Contract
            AddTable(CompName, TemplateName, 10012220); //	Purchase Contract Lines
            AddTable(CompName, TemplateName, 10012221); //	Document Group Setup
            AddTable(CompName, TemplateName, 10012222); //	Document Group Line
            AddTable(CompName, TemplateName, 10012223); //	Replen. From Warehouse
            AddTable(CompName, TemplateName, 10012224); //	Replen. Data Profile
            AddTable(CompName, TemplateName, 10012227); //	Buyer's Push Work Table
            AddTable(CompName, TemplateName, 10012228); //	Replen. Multiple Rounding
            AddTable(CompName, TemplateName, 10012229); //	Dimension Pattern
            AddTable(CompName, TemplateName, 10012230); //	Dimension Pattern Line
            AddTable(CompName, TemplateName, 10012231); //	Item Dimension Pattern Link
            AddTable(CompName, TemplateName, 10012232); //	Variant Dimension Pattern Link
            AddTable(CompName, TemplateName, 10012233); //	Weekly Sales Bucket
            AddTable(CompName, TemplateName, 10012236); //	Weekly Sales Bucket Ln.
            AddTable(CompName, TemplateName, 10012240); //	Retail Budget Distrib. Entry
            AddTable(CompName, TemplateName, 10012241); //	Retail Budget Distribution
            AddTable(CompName, TemplateName, 10012242); //	Retail Budget Store
            AddTable(CompName, TemplateName, 10012243); //	Retail Budget Distrib. Line
            AddTable(CompName, TemplateName, 10012300); //	Replen. Store Group
            AddTable(CompName, TemplateName, 10012301); //	Replen. Transfer Rule Header
            AddTable(CompName, TemplateName, 10012302); //	Replen. Transfer Rule Line
            AddTable(CompName, TemplateName, 10012303); //	Replen. Confidence Factor
            AddTable(CompName, TemplateName, 10012304); //	Replen. Work Table
            AddTable(CompName, TemplateName, 10012305); //	Variant Weight Curve
            AddTable(CompName, TemplateName, 10012306); //	Variant Weight Curve Line
            AddTable(CompName, TemplateName, 10012309); //	Replen. Like-for-Like Stmt
            AddTable(CompName, TemplateName, 10012310); //	Threshold Rule
            AddTable(CompName, TemplateName, 10012311); //	Threshold Rule Value
            AddTable(CompName, TemplateName, 10012312); //	Threshold Rule Value Details
            AddTable(CompName, TemplateName, 10012314); //	Vendor Perf. Header
            AddTable(CompName, TemplateName, 10012317); //	LS Forecast Calculation Log
            AddTable(CompName, TemplateName, 10012318); //	LS Forecast Entry
            AddTable(CompName, TemplateName, 10012319); //	Store Capacity Template
            AddTable(CompName, TemplateName, 10012320); //	Store Capacity
            AddTable(CompName, TemplateName, 10012321); //	Stock Coverage
            AddTable(CompName, TemplateName, 10012322); //	Allocation Plan Header
            AddTable(CompName, TemplateName, 10012323); //	Allocation Plan Lines
            AddTable(CompName, TemplateName, 10012324); //	Allocation Plan Groups
            AddTable(CompName, TemplateName, 10012325); //	Allocation Plan Group Lines
            AddTable(CompName, TemplateName, 10012327); //	Allocation Plan Dim Values
            AddTable(CompName, TemplateName, 10012328); //	Allocation Rule Header
            AddTable(CompName, TemplateName, 10012329); //	Allocation Rule Line
            AddTable(CompName, TemplateName, 10012330); //	Allocation Rule Links
            AddTable(CompName, TemplateName, 10012333); //	Allocation Rule Calculation
            AddTable(CompName, TemplateName, 10012350); //	Item Import Setup
            AddTable(CompName, TemplateName, 10012351); //	Item Import Vendor Setup
            AddTable(CompName, TemplateName, 10012352); //	Item Import Layout Line
            AddTable(CompName, TemplateName, 10012353); //	Vendor Hierarchy
            AddTable(CompName, TemplateName, 10012354); //	Vendor Sales Price
            AddTable(CompName, TemplateName, 10012355); //	Vendor Sales Price Margin
            AddTable(CompName, TemplateName, 10012356); //	Item Import File
            AddTable(CompName, TemplateName, 10012357); //	Item Import File Data
            AddTable(CompName, TemplateName, 10012358); //	Item Import Journal Template
            AddTable(CompName, TemplateName, 10012363); //	Sales Price Point
            AddTable(CompName, TemplateName, 10012364); //	Sales Price Point Line
            AddTable(CompName, TemplateName, 10012365); //	Item Import Layout
            AddTable(CompName, TemplateName, 10012366); //	Item Import Error Check
            AddTable(CompName, TemplateName, 10012367); //	Item Import Error Check Line
            AddTable(CompName, TemplateName, 10012368); //	Vendor Vacation Calendar
            AddTable(CompName, TemplateName, 10012369); //	Replen. Coverage Days Profile
            AddTable(CompName, TemplateName, 10012372); //	Replen. Planned Stock Demand
            AddTable(CompName, TemplateName, 10012374); //	Replen. Planned Sales Demand
            AddTable(CompName, TemplateName, 10012375); //	Replen. Data Prof. Links
            AddTable(CompName, TemplateName, 10012376); //	Replen. Planned Event
            AddTable(CompName, TemplateName, 10012377); //	Item Redist. Matrix
            AddTable(CompName, TemplateName, 10012378); //	Redist. Matrix
            AddTable(CompName, TemplateName, 10012379); //	Lifecycle Curve
            AddTable(CompName, TemplateName, 10012380); //	Lifecycle Curve Line
            AddTable(CompName, TemplateName, 10012381); //	Redist. Journal Trip
            AddTable(CompName, TemplateName, 10012382); //	Redist. Journal Preview
            AddTable(CompName, TemplateName, 10012383); //	Lifecycle Curve Link
            AddTable(CompName, TemplateName, 10012384); //	Redist. Stock Quantity
            AddTable(CompName, TemplateName, 10012385); //	Redist. Journal Preview Line
            AddTable(CompName, TemplateName, 10012386); //	Replen. Control Data Fields
            AddTable(CompName, TemplateName, 10012387); //	Replen. Control Data Filter
            AddTable(CompName, TemplateName, 10012388); //	Sales Hist. Adj. Rule
            AddTable(CompName, TemplateName, 10012389); //	Replen. Batch Calc. Calendar
            AddTable(CompName, TemplateName, 10012390); //	Replen. Batch Calendar Entry
            AddTable(CompName, TemplateName, 10012400); //	Retail Purchase Plan Name
            AddTable(CompName, TemplateName, 10012401); //	Retail Purchase Plan Entry
            AddTable(CompName, TemplateName, 10012402); //	Open-to-Buy Header
            AddTable(CompName, TemplateName, 10012403); //	Open-to-Buy Lines
            AddTable(CompName, TemplateName, 10012404); //	Committed Purchases
            AddTable(CompName, TemplateName, 10012407); //	Open-to-Buy Matrix
            AddTable(CompName, TemplateName, 10012410); //	Dim. Budget Buffer
            AddTable(CompName, TemplateName, 10012414); //	LS Forecast Item Link
            AddTable(CompName, TemplateName, 10012415); //	LS Forecast Setup
            AddTable(CompName, TemplateName, 10012416); //	LS Forecast Item V2
            AddTable(CompName, TemplateName, 10012417); //	LS Forecast Location V2
            AddTable(CompName, TemplateName, 10012418); //	LS Forecast Batch
            AddTable(CompName, TemplateName, 10012600); //	Forecourt Setup
            AddTable(CompName, TemplateName, 10012601); //	Forecourt Grade
            AddTable(CompName, TemplateName, 10012607); //	Forecourt Gauge Transaction
            AddTable(CompName, TemplateName, 10012608); //	Forecourt Tank
            AddTable(CompName, TemplateName, 10012612); //	Forecourt Tank Ledger Entry
            AddTable(CompName, TemplateName, 10012614); //	Forecourt Fuel Point
            AddTable(CompName, TemplateName, 10012615); //	Forecourt Fuel Point Grade
            AddTable(CompName, TemplateName, 10012641); //	Forecourt Tank Jnl. Template
            AddTable(CompName, TemplateName, 10012642); //	Forecourt Tank Jnl. Batch
            AddTable(CompName, TemplateName, 10012700); //	Special Order Setup
            AddTable(CompName, TemplateName, 10012706); //	Vendor Item Library
            AddTable(CompName, TemplateName, 10012708); //	Option Type
            AddTable(CompName, TemplateName, 10012709); //	Option Value
            AddTable(CompName, TemplateName, 10012710); //	Item Option Type
            AddTable(CompName, TemplateName, 10012711); //	Item Option Value
            AddTable(CompName, TemplateName, 10012712); //	Option Type Value Header
            AddTable(CompName, TemplateName, 10012713); //	Option Type Value Entry
            AddTable(CompName, TemplateName, 10012735); //	POS Web Template
            AddTable(CompName, TemplateName, 10012800); //	Inventory Menus
            AddTable(CompName, TemplateName, 10012801); //	Inventory Menu Lines
            AddTable(CompName, TemplateName, 10012802); //	Inventory Codes
            AddTable(CompName, TemplateName, 10012803); //	Inventory Bitmaps
            AddTable(CompName, TemplateName, 10012804); //	Inventory System Setup
            AddTable(CompName, TemplateName, 10012806); //	Inventory Terminal-Store
            AddTable(CompName, TemplateName, 10012807); //	Inventory Card Views
            AddTable(CompName, TemplateName, 10012808); //	Inventory Location List
            AddTable(CompName, TemplateName, 10012810); //	Inventory Item Records
            AddTable(CompName, TemplateName, 10012813); //	Inventory Record Filters
            AddTable(CompName, TemplateName, 10012815); //	Inventory Server Log Entries
            AddTable(CompName, TemplateName, 10012861); //	WI Price
            AddTable(CompName, TemplateName, 10012862); //	WI Discounts
            AddTable(CompName, TemplateName, 10012863); //	WI Mix & Match Offer
            AddTable(CompName, TemplateName, 10012864); //	WI Offer Header
            AddTable(CompName, TemplateName, 10012867); //	WI Item With Daily Updates
            AddTable(CompName, TemplateName, 10012868); //	WI Loyalty Card
            AddTable(CompName, TemplateName, 10012869); //	WI Coupon
            AddTable(CompName, TemplateName, 10014600); //	Franchise Setup
            AddTable(CompName, TemplateName, 10014601); //	Franchise Outbound Buffer Hdr
            AddTable(CompName, TemplateName, 10014605); //	Franchise Outbound Item Maste
            AddTable(CompName, TemplateName, 10014625); //	Franchise Partner Setup
            AddTable(CompName, TemplateName, 10014700); //	Loss Prevention Setup
            AddTable(CompName, TemplateName, 10014701); //	Loss Prevention Trigger
            AddTable(CompName, TemplateName, 10014703); //	Fraud Incident
            AddTable(CompName, TemplateName, 10014704); //	Fraud Trigger Process Counter
            AddTable(CompName, TemplateName, 10014706); //	Event View Header
            AddTable(CompName, TemplateName, 10014707); //	Event View Lines
            AddTable(CompName, TemplateName, 10014708); //	User Defined Trigger
            AddTable(CompName, TemplateName, 10014709); //	Trigger Filters
            AddTable(CompName, TemplateName, 10014711); //	Fraud Elevation Event Buffer
            AddTable(CompName, TemplateName, 10014712); //	Fraud Elevation Sum Buffer
            AddTable(CompName, TemplateName, 10014801); //	Offline Call Center Setup
            AddTable(CompName, TemplateName, 10014802); //	Offline Call Center
            AddTable(CompName, TemplateName, 10015000); //	Work Region
            AddTable(CompName, TemplateName, 10015001); //	Work Codes
            AddTable(CompName, TemplateName, 10015002); //	Work Roles
            AddTable(CompName, TemplateName, 10015003); //	Work Arrangement
            AddTable(CompName, TemplateName, 10015004); //	Work Arrangement Work Codes
            AddTable(CompName, TemplateName, 10015005); //	Employee Roles
            AddTable(CompName, TemplateName, 10015006); //	Employee Salary Rates
            AddTable(CompName, TemplateName, 10015010); //	Staff Management Setup
            AddTable(CompName, TemplateName, 10015011); //	Salary System Codes
            AddTable(CompName, TemplateName, 10015012); //	Salary Code Rates
            AddTable(CompName, TemplateName, 10015014); //	Work Shifts
            AddTable(CompName, TemplateName, 10015015); //	Work Shift Lines
            AddTable(CompName, TemplateName, 10015017); //	Plan Schedule/Role View Table
            AddTable(CompName, TemplateName, 10015019); //	Employee Non Availability
            AddTable(CompName, TemplateName, 10015020); //	Roster Work Table
            AddTable(CompName, TemplateName, 10015021); //	Work Location
            AddTable(CompName, TemplateName, 10015022); //	Staff Schedule
            AddTable(CompName, TemplateName, 10015023); //	Staff Management Users
            AddTable(CompName, TemplateName, 10015024); //	Special Day Settings
            AddTable(CompName, TemplateName, 10015026); //	Unavailability Type
            AddTable(CompName, TemplateName, 10015027); //	Unavailability Calc Settings
            AddTable(CompName, TemplateName, 10015030); //	Publishing Log
            AddTable(CompName, TemplateName, 10015034); //	Shift Exchange Requests
            AddTable(CompName, TemplateName, 10015035); //	Employee Cost Analysis
            AddTable(CompName, TemplateName, 10015041); //	Work Summarize Settings
            AddTable(CompName, TemplateName, 10015043); //	Shift Patterns
            AddTable(CompName, TemplateName, 10015044); //	Shift Pattern Lines
            AddTable(CompName, TemplateName, 10015047); //	External Action Setup
            AddTable(CompName, TemplateName, 10015057); //	Staff Management Employee
            AddTable(CompName, TemplateName, 10015060); //	Staff Mgt. Work Location/Empl.
            AddTable(CompName, TemplateName, 10015061); //	Staff Mgt. Empl. Contract
            AddTable(CompName, TemplateName, 10015800); //	LS Reservation
            AddTable(CompName, TemplateName, 10015801); //	Activity Reservation
            AddTable(CompName, TemplateName, 10015802); //	Activity Product
            AddTable(CompName, TemplateName, 10015803); //	Activity Type
            AddTable(CompName, TemplateName, 10015804); //	Interval Type
            AddTable(CompName, TemplateName, 10015805); //	Activity Resource Group
            AddTable(CompName, TemplateName, 10015806); //	Activity Resource
            AddTable(CompName, TemplateName, 10015807); //	Interval Time
            AddTable(CompName, TemplateName, 10015808); //	LS Resource Reservation
            AddTable(CompName, TemplateName, 10015809); //	Product Resource Requirement
            AddTable(CompName, TemplateName, 10015810); //	Resource Product Capability
            AddTable(CompName, TemplateName, 10015812); //	LS Activity Setup
            AddTable(CompName, TemplateName, 10015813); //	Resource Specific Capacity
            AddTable(CompName, TemplateName, 10015816); //	LS Activity User
            AddTable(CompName, TemplateName, 10015818); //	Activity Summary Setup
            AddTable(CompName, TemplateName, 10015819); //	Reservation Type
            AddTable(CompName, TemplateName, 10015820); //	Reservation Type Actvity
            AddTable(CompName, TemplateName, 10015821); //	Product Additional Item
            AddTable(CompName, TemplateName, 10015828); //	Activity Label Type
            AddTable(CompName, TemplateName, 10015829); //	Activity Label Script Line
            AddTable(CompName, TemplateName, 10015832); //	Activity Location
            AddTable(CompName, TemplateName, 10015833); //	Activity Availability Method
            AddTable(CompName, TemplateName, 10015835); //	Activity Product Price % Disc.
            AddTable(CompName, TemplateName, 10015836); //	Activity Attribute
            AddTable(CompName, TemplateName, 10015838); //	Activity Attribute Value
            AddTable(CompName, TemplateName, 10015839); //	Activity Status
            AddTable(CompName, TemplateName, 10015840); //	Activity Status Log
            AddTable(CompName, TemplateName, 10015843); //	Email Template
            AddTable(CompName, TemplateName, 10015847); //	Activity Task Schedule
            AddTable(CompName, TemplateName, 10015849); //	Activity Task
            AddTable(CompName, TemplateName, 10015850); //	Resource Search Template
            AddTable(CompName, TemplateName, 10015854); //	Issue Admission WorkTable
            AddTable(CompName, TemplateName, 10015855); //	Activity Attribute Assignment
            AddTable(CompName, TemplateName, 10015856); //	Activity Product Component
            AddTable(CompName, TemplateName, 10015864); //	Matrix View Template
            AddTable(CompName, TemplateName, 10015866); //	Activity Rental Unit
            AddTable(CompName, TemplateName, 10015882); //	Activity User Currents
            AddTable(CompName, TemplateName, 10015885); //	Activity User Settings
            AddTable(CompName, TemplateName, 10015889); //	Activity Resource Capacity
            AddTable(CompName, TemplateName, 10015900); //	Membership Type
            AddTable(CompName, TemplateName, 10015905); //	Membership Status Setting
            AddTable(CompName, TemplateName, 10015907); //	Membership Subscription Type
            AddTable(CompName, TemplateName, 10015910); //	Membership Setup
            AddTable(CompName, TemplateName, 10015916); //	Product Membership Option
            AddTable(CompName, TemplateName, 10016250); //	LS Recommends Setup
            AddTable(CompName, TemplateName, 10016251); //	LS Recommends Model Template
            AddTable(CompName, TemplateName, 10016252); //	LS Recommends Model
            AddTable(CompName, TemplateName, 10016253); //	LS Recommends Model Build
            AddTable(CompName, TemplateName, 10016254); //	LS Recommend Error
            AddTable(CompName, TemplateName, 10016255); //	LS Recommends Model Catalog
            AddTable(CompName, TemplateName, 10016256); //	LS Recommends Model Usage File
            AddTable(CompName, TemplateName, 10016257); //	LS Recommend Model Rule
            AddTable(CompName, TemplateName, 10016258); //	LS Recommend Model Rule Line
            AddTable(CompName, TemplateName, 10016260); //	LS Recommends Item Buffer
            AddTable(CompName, TemplateName, 10016261); //	LS Recommends Feature Template
            AddTable(CompName, TemplateName, 10016263); //	LS Recommends Model Feature
            AddTable(CompName, TemplateName, 10016264); //	LS Recommends Feature Value
            AddTable(CompName, TemplateName, 10016267); //	LS Recommends Catalog Hierachy
            AddTable(CompName, TemplateName, 10016268); //	LS Recommend Display Rule
            AddTable(CompName, TemplateName, 10016269); //	LS Recommend Display Rule Line
            AddTable(CompName, TemplateName, 10016302); //	Item Lifecycle Line
            AddTable(CompName, TemplateName, 10016303); //	Lifecycle Worksheet
            AddTable(CompName, TemplateName, 10016603); //	Retail Message Recipient Group
            AddTable(CompName, TemplateName, 10016604); //	Retail Msg Recipient Gr. Line
            AddTable(CompName, TemplateName, 10016605); //	Retail Msg Action Codes
            AddTable(CompName, TemplateName, 10016607); //	Retail Message Setup
            AddTable(CompName, TemplateName, 10016610); //	Sorting Buffer
            AddTable(CompName, TemplateName, 10016613); //	Attribute Type
            AddTable(CompName, TemplateName, 10016614); //	Din. Tbl. Attr. Assignment
            AddTable(CompName, TemplateName, 10016620); //	Prod. Gr. Unit of Measure
            AddTable(CompName, TemplateName, 10016650); //	Customer Order Setup
            AddTable(CompName, TemplateName, 10016664); //	CO Sourcing Locations
            AddTable(CompName, TemplateName, 10016667); //	CO Required Fields
            AddTable(CompName, TemplateName, 10016669); //	CO Status Events
            AddTable(CompName, TemplateName, 10016670); //	CO Line Status Setup
            AddTable(CompName, TemplateName, 10016671); //	CO Status Setup
            AddTable(CompName, TemplateName, 10037002); //	LSC Module
            AddTable(CompName, TemplateName, 99000750); //	Work Shift
            AddTable(CompName, TemplateName, 99000751); //	Shop Calendar
            AddTable(CompName, TemplateName, 99000752); //	Shop Calendar Working Days
            AddTable(CompName, TemplateName, 99000754); //	Work Center
            AddTable(CompName, TemplateName, 99000756); //	Work Center Group
            AddTable(CompName, TemplateName, 99000757); //	Calendar Entry
            AddTable(CompName, TemplateName, 99000758); //	Machine Center
            AddTable(CompName, TemplateName, 99000763); //	Routing Header
            AddTable(CompName, TemplateName, 99000764); //	Routing Line
            AddTable(CompName, TemplateName, 99000765); //	Manufacturing Setup
            AddTable(CompName, TemplateName, 99000771); //	Production BOM Header
            AddTable(CompName, TemplateName, 99000772); //	Production BOM Line
            AddTable(CompName, TemplateName, 99000777); //	Routing Link
            AddTable(CompName, TemplateName, 99000780); //	Capacity Unit of Measure
            AddTable(CompName, TemplateName, 99000850); //	Planning Assignment
            AddTable(CompName, TemplateName, 99000851); //	Production Forecast Name
            AddTable(CompName, TemplateName, 99000852); //	Production Forecast Entry
            AddTable(CompName, TemplateName, 99000866); //	Capacity Constrained Resource
            AddTable(CompName, TemplateName, 99000875); //	Order Promising Setup
            AddTable(CompName, TemplateName, 99001451); //	Barcodes
            AddTable(CompName, TemplateName, 99001452); //	Linked Item
            AddTable(CompName, TemplateName, 99001453); //	Periodic Discount
            AddTable(CompName, TemplateName, 99001454); //	Periodic Discount Line
            AddTable(CompName, TemplateName, 99001459); //	Barcode Mask
            AddTable(CompName, TemplateName, 99001461); //	Staff
            AddTable(CompName, TemplateName, 99001462); //	Tender Type
            AddTable(CompName, TemplateName, 99001464); //	Tender Type Card Setup
            AddTable(CompName, TemplateName, 99001466); //	Tender Type Setup
            AddTable(CompName, TemplateName, 99001467); //	Voucher Entries
            AddTable(CompName, TemplateName, 99001469); //	Initial Entry No. in Loc.
            AddTable(CompName, TemplateName, 99001470); //	Store
            AddTable(CompName, TemplateName, 99001471); //	POS Terminal
            AddTable(CompName, TemplateName, 99001476); //	Income/Expense Account
            AddTable(CompName, TemplateName, 99001479); //	Table Specific Infocode
            AddTable(CompName, TemplateName, 99001480); //	Barcode Mask Segment
            AddTable(CompName, TemplateName, 99001481); //	Validation Period
            AddTable(CompName, TemplateName, 99001482); //	Infocode
            AddTable(CompName, TemplateName, 99001483); //	Information Subcode
            AddTable(CompName, TemplateName, 99001486); //	Scheduler Setup
            AddTable(CompName, TemplateName, 99001492); //	POS Terminal Receipt Text
            AddTable(CompName, TemplateName, 99001497); //	Distribution List
            AddTable(CompName, TemplateName, 99001499); //	Distribution Subgroup
            AddTable(CompName, TemplateName, 99001500); //	Distribution Group
            AddTable(CompName, TemplateName, 99001501); //	Distribution Group Member
            AddTable(CompName, TemplateName, 99001502); //	Offer
            AddTable(CompName, TemplateName, 99001503); //	Offer Line
            AddTable(CompName, TemplateName, 99001504); //	Mix & Match Line Groups
            AddTable(CompName, TemplateName, 99001505); //	Multibuy Discount Line
            AddTable(CompName, TemplateName, 99001506); //	Work Shift Setup
            AddTable(CompName, TemplateName, 99001507); //	Work Shift RBO
            AddTable(CompName, TemplateName, 99001508); //	Work Shift Entry
            AddTable(CompName, TemplateName, 99001512); //	Distribution Location
            AddTable(CompName, TemplateName, 99001515); //	POS Functionality Profile
            AddTable(CompName, TemplateName, 99001517); //	Default Product Group Labels
            AddTable(CompName, TemplateName, 99001518); //	Staff Permission Group
            AddTable(CompName, TemplateName, 99001521); //	Location Table
            AddTable(CompName, TemplateName, 99001522); //	Location Field
            AddTable(CompName, TemplateName, 99001524); //	Object Transfer Header
            AddTable(CompName, TemplateName, 99001525); //	Object Transfer Line
            AddTable(CompName, TemplateName, 99001528); //	Comparison Unit of Measure
            AddTable(CompName, TemplateName, 99001529); //	Conversion Value
            AddTable(CompName, TemplateName, 99001530); //	Store Section
            AddTable(CompName, TemplateName, 99001531); //	Section Shelf
            AddTable(CompName, TemplateName, 99001532); //	Product Group Section Location
            AddTable(CompName, TemplateName, 99001533); //	Item Section Location
            AddTable(CompName, TemplateName, 99001536); //	Barcode Mask Character
            AddTable(CompName, TemplateName, 99001539); //	Archived Transaction Header
            AddTable(CompName, TemplateName, 99001548); //	Item Label
            AddTable(CompName, TemplateName, 99001549); //	Item Label Setup
            AddTable(CompName, TemplateName, 99001550); //	POS Print Setup Header
            AddTable(CompName, TemplateName, 99001551); //	POS Print Setup Line
            AddTable(CompName, TemplateName, 99001552); //	POS Table Spec. Print Setup
            AddTable(CompName, TemplateName, 99001553); //	POS Print Variable
            AddTable(CompName, TemplateName, 99001554); //	Dist. Location Version
            AddTable(CompName, TemplateName, 99001555); //	Retail Sales Budget Name
            AddTable(CompName, TemplateName, 99001556); //	Retail Sales Budget Entry
            AddTable(CompName, TemplateName, 99001557); //	POS Data Entry Type
            AddTable(CompName, TemplateName, 99001558); //	POS Data Entry
            AddTable(CompName, TemplateName, 99001560); //	POS VAT Code
            AddTable(CompName, TemplateName, 99001562); //	Retail Module
            AddTable(CompName, TemplateName, 99001563); //	Table Distribution Setup
            AddTable(CompName, TemplateName, 99001565); //	POS Data Table Columns
            AddTable(CompName, TemplateName, 99001567); //	Retail Zone
            AddTable(CompName, TemplateName, 99001571); //	Statistics Time Setup
            AddTable(CompName, TemplateName, 99001572); //	Shelf Label Setup
            AddTable(CompName, TemplateName, 99001573); //	Shelf Label
            AddTable(CompName, TemplateName, 99001574); //	Label Functions
            AddTable(CompName, TemplateName, 99001575); //	Store Price Group
            AddTable(CompName, TemplateName, 99001576); //	Batch Posting Setup
            AddTable(CompName, TemplateName, 99001577); //	Batch Posting Queue
            AddTable(CompName, TemplateName, 99001578); //	Batch Posting Document Setup
            AddTable(CompName, TemplateName, 99001580); //	Dashboard Alarms
            AddTable(CompName, TemplateName, 99001581); //	Dashboard Store Alarms
            AddTable(CompName, TemplateName, 99001582); //	Dashboard Stores
            AddTable(CompName, TemplateName, 99001583); //	POS Fixed Start Denom.
            AddTable(CompName, TemplateName, 99001585); //	Coupon Issuer
            AddTable(CompName, TemplateName, 99001586); //	Scheduler Job Header
            AddTable(CompName, TemplateName, 99001587); //	Scheduler Job Line
            AddTable(CompName, TemplateName, 99001588); //	Scheduler Subjob
            AddTable(CompName, TemplateName, 99001589); //	Job Receiver Group
            AddTable(CompName, TemplateName, 99001590); //	Scheduler Subjob Filter
            AddTable(CompName, TemplateName, 99001591); //	Scheduler Subjob Field List
            AddTable(CompName, TemplateName, 99001592); //	Scheduler Job Type
            AddTable(CompName, TemplateName, 99001594); //	Distrib. Include/Exclude List
            AddTable(CompName, TemplateName, 99001595); //	Scheduler Subjob Linked Table
            AddTable(CompName, TemplateName, 99001596); //	Scd.Subjob Linked Table Filter
            AddTable(CompName, TemplateName, 99001597); //	Scheduler Log
            AddTable(CompName, TemplateName, 99001599); //	Linked Scheduler Job
            AddTable(CompName, TemplateName, 99001607); //	POS Start Entry Line
            AddTable(CompName, TemplateName, 99001608); //	Inventory Lookup Table
            AddTable(CompName, TemplateName, 99001610); //	Cash Declaration Setup
            AddTable(CompName, TemplateName, 99001612); //	Preaction
            AddTable(CompName, TemplateName, 99001614); //	Action Counters
            AddTable(CompName, TemplateName, 99001616); //	Preaction Setup
            AddTable(CompName, TemplateName, 99001618); //	Table Links
            AddTable(CompName, TemplateName, 99001620); //	POS Actions
            AddTable(CompName, TemplateName, 99001621); //	Coupon Header
            AddTable(CompName, TemplateName, 99001622); //	Coupon Line
            AddTable(CompName, TemplateName, 99001625); //	POS Cash Decl. Line
            AddTable(CompName, TemplateName, 99001627); //	POS Start Status
            AddTable(CompName, TemplateName, 99001628); //	POS Start Entry
            AddTable(CompName, TemplateName, 99001629); //	POS Fixed Start Amount
            AddTable(CompName, TemplateName, 99001631); //	Safe Statement Line
            AddTable(CompName, TemplateName, 99001632); //	Posted Safe Statement Line
            AddTable(CompName, TemplateName, 99001633); //	Staff Store Link
            AddTable(CompName, TemplateName, 99001636); //	Tender Type Currency Setup
            AddTable(CompName, TemplateName, 99001638); //	Dyn. Item Hierarchy Setup
            AddTable(CompName, TemplateName, 99001639); //	Dyn. Item  Hierarchy Level
            AddTable(CompName, TemplateName, 99001641); //	Dyn. Item Hierarchy Field
            AddTable(CompName, TemplateName, 99001643); //	Coupon Entry
            AddTable(CompName, TemplateName, 99001646); //	Retail Customer Group
            AddTable(CompName, TemplateName, 99001647); //	Return Policy
            AddTable(CompName, TemplateName, 99001648); //	Advanced Shift
            AddTable(CompName, TemplateName, 99001650); //	Periodic Discount Benefits
            AddTable(CompName, TemplateName, 99001651); //	Deal Modifier Item
            AddTable(CompName, TemplateName, 99001659); //	Discount Ledger Entry
            AddTable(CompName, TemplateName, 99001660); //	Commission Rule
            AddTable(CompName, TemplateName, 99001661); //	Commission Rule Item
            AddTable(CompName, TemplateName, 99001662); //	Commission Rule Salesperson
            AddTable(CompName, TemplateName, 99001663); //	Commission Salesperson Group
            AddTable(CompName, TemplateName, 99001664); //	Commission Salesp. Grp Member
            AddTable(CompName, TemplateName, 99001665); //	Commission Sales Target
            AddTable(CompName, TemplateName, 99001667); //	Commission Sales Period
            AddTable(CompName, TemplateName, 99001669); //	Commission Document Status
            AddTable(CompName, TemplateName, 99001671); //	Preaction Creation
            AddTable(CompName, TemplateName, 99001672); //	Card Type
            AddTable(CompName, TemplateName, 99001673); //	Line Discount Offer Group
            AddTable(CompName, TemplateName, 99001676); //	Deal Modifier Size Group
            AddTable(CompName, TemplateName, 99001680); //	Store Safe
            AddTable(CompName, TemplateName, 99001681); //	Safe Ledger Entry
            AddTable(CompName, TemplateName, 99001684); //	Posted Safe Transfer
            AddTable(CompName, TemplateName, 99001685); //	Posted Safe Transfer Line
            AddTable(CompName, TemplateName, 99001690); //	Safe Bag
            AddTable(CompName, TemplateName, 99001691); //	Safe Bag Line
            AddTable(CompName, TemplateName, 99001692); //	Bag Change Log
            AddTable(CompName, TemplateName, 99001693); //	Closed Safe Bag
            AddTable(CompName, TemplateName, 99001694); //	Closed Safe Bag Line
            AddTable(CompName, TemplateName, 99001696); //	Store Safe Jnl. Template
            AddTable(CompName, TemplateName, 99001697); //	Store Safe Jnl. Batch
            AddTable(CompName, TemplateName, 99001698); //	Bag Tender Declaration
            AddTable(CompName, TemplateName, 99001699); //	Store Safe Register
            AddTable(CompName, TemplateName, 99001702); //	Joined Safe Bag
            AddTable(CompName, TemplateName, 99001714); //	Current Availability Lock
            AddTable(CompName, TemplateName, 99008800); //	Archived Periodic Discount
            AddTable(CompName, TemplateName, 99008801); //	Archived Periodic Disc. Line
            AddTable(CompName, TemplateName, 99008803); //	Archived Multibuy Disc. Line
            AddTable(CompName, TemplateName, 99008804); //	Archived Period.Disc. Benefits
            AddTable(CompName, TemplateName, 99008940); //	Web Service Setup
            AddTable(CompName, TemplateName, 99008941); //	WS Request
            AddTable(CompName, TemplateName, 99008942); //	WS Request Setup
            AddTable(CompName, TemplateName, 99009000); //	Member Club
            AddTable(CompName, TemplateName, 99009001); //	Member Account
            AddTable(CompName, TemplateName, 99009002); //	Member Contact
            AddTable(CompName, TemplateName, 99009003); //	Membership Card
            AddTable(CompName, TemplateName, 99009007); //	Member Account Upgrade Entry
            AddTable(CompName, TemplateName, 99009008); //	Member Point Jnl. Template
            AddTable(CompName, TemplateName, 99009009); //	Member Point Jnl. Batch
            AddTable(CompName, TemplateName, 99009011); //	Member Point Setup
            AddTable(CompName, TemplateName, 99009012); //	Member Attribute
            AddTable(CompName, TemplateName, 99009013); //	Member Attribute Setup
            AddTable(CompName, TemplateName, 99009014); //	Member Attribute Lookup
            AddTable(CompName, TemplateName, 99009015); //	Member Attribute Value
            AddTable(CompName, TemplateName, 99009016); //	Discount Tracking Header
            AddTable(CompName, TemplateName, 99009017); //	Discount Tracking Line
            AddTable(CompName, TemplateName, 99009018); //	Discount Limitation Setup
            AddTable(CompName, TemplateName, 99009020); //	Member Campaign
            AddTable(CompName, TemplateName, 99009022); //	Member Campaign Query Line
            AddTable(CompName, TemplateName, 99009024); //	Member Scheme
            AddTable(CompName, TemplateName, 99009025); //	Dynamic Lookup Header
            AddTable(CompName, TemplateName, 99009026); //	Dynamic Lookup Line
            AddTable(CompName, TemplateName, 99009029); //	Dynamic Query
            AddTable(CompName, TemplateName, 99009030); //	Dynamic Query Line
            AddTable(CompName, TemplateName, 99009032); //	Member Management Setup
            AddTable(CompName, TemplateName, 99009036); //	Member Point Offer
            AddTable(CompName, TemplateName, 99009037); //	Member Point Offer Line
            AddTable(CompName, TemplateName, 99009041); //	Published Offer
            AddTable(CompName, TemplateName, 99009042); //	Published Offer Detail Line
            AddTable(CompName, TemplateName, 99009043); //	Member Notification
            AddTable(CompName, TemplateName, 99009045); //	Member Login
            AddTable(CompName, TemplateName, 99009047); //	Member Login Device
            AddTable(CompName, TemplateName, 99009048); //	Member Device
            AddTable(CompName, TemplateName, 99009049); //	Member Login Card
            AddTable(CompName, TemplateName, 99009050); //	Retail Calendar Group Linking
            AddTable(CompName, TemplateName, 99009051); //	Retail Calendar
            AddTable(CompName, TemplateName, 99009052); //	Retail Calendar Line
            AddTable(CompName, TemplateName, 99009062); //	Mobile Store Opening Hours
            AddTable(CompName, TemplateName, 99009063); //	Retail Image
            AddTable(CompName, TemplateName, 99009064); //	Retail Image Link
            AddTable(CompName, TemplateName, 99009066); //	Current Availability
            AddTable(CompName, TemplateName, 99009068); //	Feature Flags
            AddTable(CompName, TemplateName, 99009075); //	E-Mail Disclaimers
            AddTable(CompName, TemplateName, 99009200); //	Statistics View
            AddTable(CompName, TemplateName, 99009201); //	Statistics View Lines
            AddTable(CompName, TemplateName, 99009251); //	MobileBarcode
            AddTable(CompName, TemplateName, 99009268); //	MobileTAXSetup
            AddTable(CompName, TemplateName, 99009292); //	POS Terminal In Use
            AddTable(CompName, TemplateName, 99009300); //	Dynamic Content
            AddTable(CompName, TemplateName, 99009301); //	Dynamic Content Line
            AddTable(CompName, TemplateName, 99009303); //	Dynamic Content Group
            AddTable(CompName, TemplateName, 99009330); //	Web Application Type
            AddTable(CompName, TemplateName, 99009334); //	Web Table Group
            AddTable(CompName, TemplateName, 99009600); //	FBP Header
            AddTable(CompName, TemplateName, 99009601); //	FBP Line
            AddTable(CompName, TemplateName, 99009603); //	FBP Ledger Entry
            AddTable(CompName, TemplateName, 99009610); //	KDS Header Profile
            AddTable(CompName, TemplateName, 99009611); //	KDS Header Profile Line
            AddTable(CompName, TemplateName, 99009612); //	KDS Header Prof. Line Column
            AddTable(CompName, TemplateName, 99009640); //	Web Request
            AddTable(CompName, TemplateName, 99009641); //	Web Request Parameter
            //<< Master/Setup ======
        end;

        //>> Trans ======
        // BC
        AddTable(CompName, TemplateName, 17); //    G/L Entry
        AddTable(CompName, TemplateName, 25); //    Vendor Ledger Entry
        AddTable(CompName, TemplateName, 32); //    Item Ledger Entry
        AddTable(CompName, TemplateName, 36); //    Sales Header
        AddTable(CompName, TemplateName, 37); //    Sales Line
        AddTable(CompName, TemplateName, 38); //    Purchase Header
        AddTable(CompName, TemplateName, 39); //    Purchase Line
        AddTable(CompName, TemplateName, 43); //	Purch. Comment Line
        AddTable(CompName, TemplateName, 44); //	Sales Comment Line
        AddTable(CompName, TemplateName, 45); //	G/L Register
        AddTable(CompName, TemplateName, 46); //	Item Register
        AddTable(CompName, TemplateName, 81); //	Gen. Journal Line
        AddTable(CompName, TemplateName, 83); //	Item Journal Line
        AddTable(CompName, TemplateName, 96); //	G/L Budget Entry
        AddTable(CompName, TemplateName, 97); //	Comment Line
        AddTable(CompName, TemplateName, 110); //	Sales Shipment Header
        AddTable(CompName, TemplateName, 111); //	Sales Shipment Line
        AddTable(CompName, TemplateName, 112); //	Sales Invoice Header
        AddTable(CompName, TemplateName, 113); //	Sales Invoice Line
        AddTable(CompName, TemplateName, 114); //	Sales Cr.Memo Header
        AddTable(CompName, TemplateName, 115); //	Sales Cr.Memo Line
        AddTable(CompName, TemplateName, 120); //	Purch. Rcpt. Header
        AddTable(CompName, TemplateName, 121); //	Purch. Rcpt. Line
        AddTable(CompName, TemplateName, 122); //	Purch. Inv. Header
        AddTable(CompName, TemplateName, 123); //	Purch. Inv. Line
        AddTable(CompName, TemplateName, 124); //	Purch. Cr. Memo Hdr.
        AddTable(CompName, TemplateName, 125); //	Purch. Cr. Memo Line
        AddTable(CompName, TemplateName, 160); //	Res. Capacity Entry
        AddTable(CompName, TemplateName, 169); //	Job Ledger Entry
        AddTable(CompName, TemplateName, 179); //	Reversal Entry
        AddTable(CompName, TemplateName, 203); //	Res. Ledger Entry
        AddTable(CompName, TemplateName, 207); //	Res. Journal Line
        AddTable(CompName, TemplateName, 240); //	Resource Register
        AddTable(CompName, TemplateName, 241); //	Job Register
        AddTable(CompName, TemplateName, 246); //	Requisition Line
        AddTable(CompName, TemplateName, 253); //	G/L Entry - VAT Entry Link
        AddTable(CompName, TemplateName, 254); //	VAT Entry
        AddTable(CompName, TemplateName, 256); //	VAT Statement Line
        AddTable(CompName, TemplateName, 271); //	Bank Account Ledger Entry
        AddTable(CompName, TemplateName, 273); //	Bank Acc. Reconciliation
        AddTable(CompName, TemplateName, 274); //	Bank Acc. Reconciliation Line
        AddTable(CompName, TemplateName, 276); //	Bank Account Statement Line
        AddTable(CompName, TemplateName, 281); //	Phys. Inventory Ledger Entry
        AddTable(CompName, TemplateName, 336); //	Tracking Specification
        AddTable(CompName, TemplateName, 337); //	Reservation Entry
        AddTable(CompName, TemplateName, 339); //	Item Application Entry
        AddTable(CompName, TemplateName, 405); //	Change Log Entry
        AddTable(CompName, TemplateName, 472); //	Job Queue Entry
        AddTable(CompName, TemplateName, 474); //	Job Queue Log Entry
        AddTable(CompName, TemplateName, 710); //	Activity Log
        AddTable(CompName, TemplateName, 751); //	Standard General Journal Line
        AddTable(CompName, TemplateName, 753); //	Standard Item Journal Line
        AddTable(CompName, TemplateName, 900); //	Assembly Header
        AddTable(CompName, TemplateName, 901); //	Assembly Line
        AddTable(CompName, TemplateName, 904); //	Assemble-to-Order Link
        AddTable(CompName, TemplateName, 906); //	Assembly Comment Line
        AddTable(CompName, TemplateName, 910); //	Posted Assembly Header
        AddTable(CompName, TemplateName, 911); //	Posted Assembly Line
        AddTable(CompName, TemplateName, 914); //	Posted Assemble-to-Order Link
        AddTable(CompName, TemplateName, 1004); //	Job WIP Entry
        AddTable(CompName, TemplateName, 1005); //	Job WIP G/L Entry
        AddTable(CompName, TemplateName, 1007); //	Job WIP Warning
        AddTable(CompName, TemplateName, 1015); //	Job Entry No.
        AddTable(CompName, TemplateName, 1017); //	Job Buffer
        AddTable(CompName, TemplateName, 1018); //	Job WIP Buffer
        AddTable(CompName, TemplateName, 1019); //	Job Difference Buffer
        AddTable(CompName, TemplateName, 1020); //	Job Usage Link
        AddTable(CompName, TemplateName, 1021); //	Job WIP Total
        AddTable(CompName, TemplateName, 1022); //	Job Planning Line Invoice
        AddTable(CompName, TemplateName, 1034); //	Job Planning Line - Calendar
        AddTable(CompName, TemplateName, 1101); //	Cost Journal Line
        AddTable(CompName, TemplateName, 1104); //	Cost Entry
        AddTable(CompName, TemplateName, 1105); //	Cost Register
        AddTable(CompName, TemplateName, 1109); //	Cost Budget Entry
        AddTable(CompName, TemplateName, 1294); //	Applied Payment Entry
        AddTable(CompName, TemplateName, 1295); //	Posted Payment Recon. Hdr
        AddTable(CompName, TemplateName, 1296); //	Posted Payment Recon. Line
        AddTable(CompName, TemplateName, 1299); //	Payment Matching Details
        AddTable(CompName, TemplateName, 1511); //	Notification Entry
        AddTable(CompName, TemplateName, 1514); //	Sent Notification Entry
        AddTable(CompName, TemplateName, 5065); //	Interaction Log Entry
        AddTable(CompName, TemplateName, 5093); //	Opportunity Entry
        AddTable(CompName, TemplateName, 5107); //	Sales Header Archive
        AddTable(CompName, TemplateName, 5108); //	Sales Line Archive
        AddTable(CompName, TemplateName, 5109); //	Purchase Header Archive
        AddTable(CompName, TemplateName, 5110); //	Purchase Line Archive
        AddTable(CompName, TemplateName, 5125); //	Purch. Comment Line Archive
        AddTable(CompName, TemplateName, 5126); //	Sales Comment Line Archive
        AddTable(CompName, TemplateName, 5405); //	Production Order
        AddTable(CompName, TemplateName, 5406); //	Prod. Order Line
        AddTable(CompName, TemplateName, 5407); //	Prod. Order Component
        AddTable(CompName, TemplateName, 5409); //	Prod. Order Routing Line
        AddTable(CompName, TemplateName, 5410); //	Prod. Order Capacity Need
        AddTable(CompName, TemplateName, 5475); //	Sales Invoice Entity Aggregate
        AddTable(CompName, TemplateName, 5477); //	Purch. Inv. Entity Aggregate
        AddTable(CompName, TemplateName, 5495); //	Sales Order Entity Buffer
        AddTable(CompName, TemplateName, 5507); //	Sales Cr. Memo Entity Buffer
        AddTable(CompName, TemplateName, 5601); //	FA Ledger Entry
        AddTable(CompName, TemplateName, 5617); //	FA Register
        AddTable(CompName, TemplateName, 5621); //	FA Journal Line
        AddTable(CompName, TemplateName, 5624); //	FA Reclass. Journal Line
        AddTable(CompName, TemplateName, 5625); //	Maintenance Ledger Entry
        AddTable(CompName, TemplateName, 5629); //	Ins. Coverage Ledger Entry
        AddTable(CompName, TemplateName, 5635); //	Insurance Journal Line
        AddTable(CompName, TemplateName, 5636); //	Insurance Register
        AddTable(CompName, TemplateName, 5637); //	FA G/L Posting Buffer
        AddTable(CompName, TemplateName, 5740); //	Transfer Header
        AddTable(CompName, TemplateName, 5741); //	Transfer Line
        AddTable(CompName, TemplateName, 5742); //	Transfer Route
        AddTable(CompName, TemplateName, 5744); //	Transfer Shipment Header
        AddTable(CompName, TemplateName, 5745); //	Transfer Shipment Line
        AddTable(CompName, TemplateName, 5746); //	Transfer Receipt Header
        AddTable(CompName, TemplateName, 5747); //	Transfer Receipt Line
        AddTable(CompName, TemplateName, 5765); //	Warehouse Request
        AddTable(CompName, TemplateName, 5766); //	Warehouse Activity Header
        AddTable(CompName, TemplateName, 5767); //	Warehouse Activity Line
        AddTable(CompName, TemplateName, 5802); //	Value Entry
        AddTable(CompName, TemplateName, 5823); //	G/L - Item Ledger Relation
        AddTable(CompName, TemplateName, 5832); //	Capacity Ledger Entry
        AddTable(CompName, TemplateName, 5896); //	Inventory Adjmt. Entry (Order)
        AddTable(CompName, TemplateName, 5900); //	Service Header
        AddTable(CompName, TemplateName, 5901); //	Service Item Line
        AddTable(CompName, TemplateName, 5902); //	Service Line
        AddTable(CompName, TemplateName, 5907); //	Service Ledger Entry
        AddTable(CompName, TemplateName, 5912); //	Service Document Log
        AddTable(CompName, TemplateName, 5934); //	Service Register
        AddTable(CompName, TemplateName, 5936); //	Service Document Register
        AddTable(CompName, TemplateName, 5943); //	Troubleshooting Header
        AddTable(CompName, TemplateName, 5944); //	Troubleshooting Line
        AddTable(CompName, TemplateName, 5964); //	Service Contract Line
        AddTable(CompName, TemplateName, 5965); //	Service Contract Header
        AddTable(CompName, TemplateName, 5969); //	Contract Gain/Loss Entry
        AddTable(CompName, TemplateName, 5970); //	Filed Service Contract Header
        AddTable(CompName, TemplateName, 5971); //	Filed Contract Line
        AddTable(CompName, TemplateName, 5989); //	Service Shipment Item Line
        AddTable(CompName, TemplateName, 5990); //	Service Shipment Header
        AddTable(CompName, TemplateName, 5991); //	Service Shipment Line
        AddTable(CompName, TemplateName, 5992); //	Service Invoice Header
        AddTable(CompName, TemplateName, 5993); //	Service Invoice Line
        AddTable(CompName, TemplateName, 5994); //	Service Cr.Memo Header
        AddTable(CompName, TemplateName, 5995); //	Service Cr.Memo Line
        AddTable(CompName, TemplateName, 6507); //	Item Entry Relation
        AddTable(CompName, TemplateName, 6508); //	Value Entry Relation
        AddTable(CompName, TemplateName, 6650); //	Return Shipment Header
        AddTable(CompName, TemplateName, 6651); //	Return Shipment Line
        AddTable(CompName, TemplateName, 6660); //	Return Receipt Header
        AddTable(CompName, TemplateName, 6661); //	Return Receipt Line
        AddTable(CompName, TemplateName, 7134); //	Item Budget Entry
        AddTable(CompName, TemplateName, 7154); //	Item Analysis View Entry
        AddTable(CompName, TemplateName, 7156); //	Item Analysis View Budg. Entry
        AddTable(CompName, TemplateName, 7312); //	Warehouse Entry
        AddTable(CompName, TemplateName, 7313); //	Warehouse Register
        AddTable(CompName, TemplateName, 7316); //	Warehouse Receipt Header
        AddTable(CompName, TemplateName, 7317); //	Warehouse Receipt Line
        AddTable(CompName, TemplateName, 7318); //	Posted Whse. Receipt Header
        AddTable(CompName, TemplateName, 7319); //	Posted Whse. Receipt Line
        AddTable(CompName, TemplateName, 7320); //	Warehouse Shipment Header
        AddTable(CompName, TemplateName, 7321); //	Warehouse Shipment Line
        AddTable(CompName, TemplateName, 7322); //	Posted Whse. Shipment Header
        AddTable(CompName, TemplateName, 7323); //	Posted Whse. Shipment Line
        AddTable(CompName, TemplateName, 7324); //	Whse. Put-away Request
        AddTable(CompName, TemplateName, 7325); //	Whse. Pick Request
        AddTable(CompName, TemplateName, 7326); //	Whse. Worksheet Line
        AddTable(CompName, TemplateName, 7330); //	Bin Content Buffer
        AddTable(CompName, TemplateName, 7331); //	Whse. Internal Put-away Header
        AddTable(CompName, TemplateName, 7332); //	Whse. Internal Put-away Line
        AddTable(CompName, TemplateName, 7333); //	Whse. Internal Pick Header
        AddTable(CompName, TemplateName, 7334); //	Whse. Internal Pick Line
        AddTable(CompName, TemplateName, 7335); //	Bin Template
        AddTable(CompName, TemplateName, 7338); //	Bin Creation Worksheet Line
        AddTable(CompName, TemplateName, 7340); //	Posted Invt. Put-away Header
        AddTable(CompName, TemplateName, 7341); //	Posted Invt. Put-away Line
        AddTable(CompName, TemplateName, 7342); //	Posted Invt. Pick Header
        AddTable(CompName, TemplateName, 7343); //	Posted Invt. Pick Line

        // LS
        AddTable(CompName, TemplateName, 10000777); //	Retail ICT Header
        AddTable(CompName, TemplateName, 10000778); //	Retail ICT Lines
        AddTable(CompName, TemplateName, 10001204); //	Dining Reservation Entry
        AddTable(CompName, TemplateName, 10001214); //	Transaction in Use on POS
        AddTable(CompName, TemplateName, 10001215); //	Dining Table In Use on POS
        AddTable(CompName, TemplateName, 10001216); //	Posted Delivery Order
        AddTable(CompName, TemplateName, 10001217); //	Delivery Driver Trip
        AddTable(CompName, TemplateName, 10001218); //	Delivery Order
        AddTable(CompName, TemplateName, 10001219); //	Delivery Contact Address
        AddTable(CompName, TemplateName, 10001229); //	Hosp. Order Kitchen Status
        AddTable(CompName, TemplateName, 10001230); //	Hosp. Order KOT Status
        AddTable(CompName, TemplateName, 10001231); //	Queue Counter
        AddTable(CompName, TemplateName, 10001232); //	Store Queue Counter
        AddTable(CompName, TemplateName, 10001235); //	Change on Del/Takeout Orders
        AddTable(CompName, TemplateName, 10001249); //	Call Cent. POS Term. Assignm.
        AddTable(CompName, TemplateName, 10001253); //	Dining Table History Entry
        AddTable(CompName, TemplateName, 10001254); //	Dining Table Receipt Entry
        AddTable(CompName, TemplateName, 10001325); //	P/R Counting Header
        AddTable(CompName, TemplateName, 10001352); //	InStore Header
        AddTable(CompName, TemplateName, 10001353); //	InStore Line
        AddTable(CompName, TemplateName, 10001354); //	InStore Header Status
        AddTable(CompName, TemplateName, 10001355); //	InStore Statistics Line
        AddTable(CompName, TemplateName, 10001356); //	InStore Difference Entry
        AddTable(CompName, TemplateName, 10001357); //	InStore Stock Req. Header
        AddTable(CompName, TemplateName, 10001358); //	InStore Stock Req. Line
        AddTable(CompName, TemplateName, 10001359); //	InStore Setup Verify Log
        AddTable(CompName, TemplateName, 10001360); //	InStore Dist. Location Log
        AddTable(CompName, TemplateName, 10001361); //	InStore Request
        AddTable(CompName, TemplateName, 99001472); //	Transaction Header
        AddTable(CompName, TemplateName, 99001473); //	Trans. Sales Entry
        AddTable(CompName, TemplateName, 99001474); //	Trans. Payment Entry
        AddTable(CompName, TemplateName, 10016651); //	Customer Order Header
        AddTable(CompName, TemplateName, 10016652); //	Customer Order Line
        AddTable(CompName, TemplateName, 10016653); //	Customer Order Discount Line
        AddTable(CompName, TemplateName, 10016654); //	CO Reservation Entry
        AddTable(CompName, TemplateName, 10016655); //	Posted Customer Order Header
        AddTable(CompName, TemplateName, 10016656); //	Posted Customer Order Line
        AddTable(CompName, TemplateName, 10016657); //	Posted CO Discount Line
        AddTable(CompName, TemplateName, 10016658); //	Customer Order Payment
        AddTable(CompName, TemplateName, 10016659); //	Posted Customer Order Payment
        AddTable(CompName, TemplateName, 10016665); //	CO Sourcing Buffer
        AddTable(CompName, TemplateName, 10016668); //	Customer Order Status
        AddTable(CompName, TemplateName, 10016672); //	CO Status
        AddTable(CompName, TemplateName, 10016673); //	Customer Order Status Log
        AddTable(CompName, TemplateName, 99001460); //	Trans. Deal Entry
        AddTable(CompName, TemplateName, 99001465); //	Trans. Tender Declar. Entry
        AddTable(CompName, TemplateName, 99001475); //	Trans. Income/Expense Entry
        AddTable(CompName, TemplateName, 99001477); //	Trans. Coupon Entry
        AddTable(CompName, TemplateName, 99001478); //	Trans. Infocode Entry
        AddTable(CompName, TemplateName, 99001485); //	Posted Statement
        AddTable(CompName, TemplateName, 99001487); //	Statement
        AddTable(CompName, TemplateName, 99001488); //	Statement Line
        AddTable(CompName, TemplateName, 99001489); //	Posted Statement Line
        AddTable(CompName, TemplateName, 99001490); //	Trans. Inventory Entry
        AddTable(CompName, TemplateName, 99001493); //	Transaction Status
        AddTable(CompName, TemplateName, 99001494); //	Trans. Sales Entry Status
        AddTable(CompName, TemplateName, 99001495); //	Trans. Point Entry
        AddTable(CompName, TemplateName, 99001496); //	Trans. Mix & Match Entry
        AddTable(CompName, TemplateName, 99001540); //	Archived Sales Entry
        AddTable(CompName, TemplateName, 99001541); //	Archived Payment Entry
        AddTable(CompName, TemplateName, 99001542); //	Archived Income/Expense Entry
        AddTable(CompName, TemplateName, 99001543); //	Archived Infocode Entry
        AddTable(CompName, TemplateName, 99001544); //	Archived Mix & Match Entry
        AddTable(CompName, TemplateName, 99001545); //	Archived Tender Declar. Entry
        AddTable(CompName, TemplateName, 99001546); //	Archived Trans. Coupon Entry
        AddTable(CompName, TemplateName, 99001609); //	Posted Cash Declaration
        AddTable(CompName, TemplateName, 99001611); //	Cash Declaration
        AddTable(CompName, TemplateName, 99001624); //	POS Cash Declaration
        AddTable(CompName, TemplateName, 99001626); //	Trans. Cash Declaration
        AddTable(CompName, TemplateName, 99001630); //	Trans. Safe Entry
        AddTable(CompName, TemplateName, 99001642); //	Trans. Discount Entry
        AddTable(CompName, TemplateName, 99001655); //	POS Trans. Inv. Header
        AddTable(CompName, TemplateName, 99001656); //	POS Trans. Inv. Lines
        AddTable(CompName, TemplateName, 99001657); //	Trans. Inventory Header
        AddTable(CompName, TemplateName, 99001658); //	Trans. Inventory Lines
        AddTable(CompName, TemplateName, 99008950); //	POS Trans. InfoData
        AddTable(CompName, TemplateName, 99008954); //	POS Card Print Text
        AddTable(CompName, TemplateName, 99008980); //	POS Transaction
        AddTable(CompName, TemplateName, 99008981); //	POS Trans. Line
        AddTable(CompName, TemplateName, 99008985); //	POS Counter
        AddTable(CompName, TemplateName, 99008987); //	POS Card Entry
        AddTable(CompName, TemplateName, 99008990); //	POS Voided Transaction
        AddTable(CompName, TemplateName, 99008991); //	POS Voided Trans. Line
        AddTable(CompName, TemplateName, 99008992); //	POS Voided Infocode Entry
        AddTable(CompName, TemplateName, 99008993); //	POS Media Control
        AddTable(CompName, TemplateName, 99008994); //	POS Media Playlist Header
        AddTable(CompName, TemplateName, 99008995); //	POS Media Playlist Line
        AddTable(CompName, TemplateName, 99009005); //	Member Point Entry
        AddTable(CompName, TemplateName, 99009038); //	Member Process Order Entry
        AddTable(CompName, TemplateName, 99009039); //	Member Point Register
        //<< Trans ======
        dlg.Close();

    end;

    procedure AddTable(CompName: Code[30]; TemplateName: Code[20]; TableID: Integer)
    var
        Tables: Record AllObjWithCaption;
        DataDeletion: Record "Data Deletion";
        RecRef: RecordRef;
        Insert: Boolean;
    begin
        Tables.SetRange("Object Type", Tables."Object Type"::Table);
        Tables.SetRange("Object ID", TableID);
        if Tables.FindFirst() then begin
            dlg.Update(1, Tables."Object Name");
            DataDeletion.SetRange("Company Name", CompName);
            DataDeletion.SetRange("Template Name", TemplateName);
            DataDeletion.SetRange("Table No.", TableID);
            if DataDeletion.FindFirst() then begin
                DataDeletion."Delete Data" := true;
                DataDeletion.Modify();
            end else begin
                DataDeletion.Init();
                DataDeletion."Company Name" := CompName;
                DataDeletion."Template Name" := TemplateName;
                DataDeletion."Table No." := Tables."Object ID";
                DataDeletion."Table Name" := Tables."Object Name";
                DataDeletion."Delete Data" := true;
                Clear(RecRef);
                RecRef.Open(TableID);
                DataDeletion."No. of Records" := RecRef.Count;
                RecRef.Close();
                DataDeletion.Insert();
            end;
        end;
    end;

    procedure LoadTables(CompName: Code[30]; TemplateName: Code[20])
    var
        Tables: Record AllObjWithCaption;
        DataDeletion: Record "Data Deletion";
        RecRef: RecordRef;
        Insert: Boolean;
    begin
        Tables.SetRange("Object Type", Tables."Object Type"::Table);
        if Tables.FindSet() then begin
            dlg.Open(Text100);

            repeat
                Insert := true;
                //if StrPos(Tables."Object Name", 'Graph') > 0 then
                //    Insert := false;
                //if StrPos(Tables."Object Name", 'CRM') > 0 then
                //    Insert := false;
                Clear(RecRef);
                RecRef.Open(Tables."Object ID");
                if RecRef.Find('-') then begin
                    dlg.Update(1, Tables."Object Name");
                    DataDeletion.Init();
                    DataDeletion."Company Name" := CompName;
                    DataDeletion."Template Name" := TemplateName;
                    DataDeletion."Table No." := Tables."Object ID";
                    DataDeletion."Table Name" := Tables."Object Name";
                    DataDeletion."No. of Records" := RecRef.Count;
                    DataDeletion.Insert();
                end;
                RecRef.Close();
            until Tables.Next() = 0;
            dlg.Close();
        end;
    end;

    procedure RemoveAllTables(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        if DataDeletion.FindSet() then
            if Confirm(Text300, false) then
                DataDeletion.DeleteAll();
    end;

    procedure DeleteData(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
        RecRef: RecordRef;
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        DataDeletion.SetRange("Delete Data", true);
        if DataDeletion.FindSet() then begin
            if not Confirm(Text200, false) then
                exit;
            dlg.Open(Text400);
            repeat
                dlg.Update(1, DataDeletion."Table Name");
                Clear(RecRef);
                RecRef.Open(DataDeletion."Table No.");
                if RecRef.Count > 0 then
                    RecRef.DeleteAll();
                DataDeletion."No. of Records" := RecRef.Count;
                DataDeletion.Modify();
            until DataDeletion.Next() = 0;
            dlg.Close();
        end;
    end;

    procedure UpdateRecCount(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
        RecRef: RecordRef;
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        if DataDeletion.FindSet() then begin
            dlg.Open(Text101);
            repeat
                dlg.Update(1, DataDeletion."Table Name");
                Clear(RecRef);
                RecRef.Open(DataDeletion."Table No.");
                DataDeletion."No. of Records" := RecRef.Count;
                DataDeletion.Modify();
            until DataDeletion.Next() = 0;
            dlg.Close();
        end;
    end;

    procedure SelectAllTables(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        if DataDeletion.FindSet() then begin
            repeat
                DataDeletion."Delete Data" := true;
                DataDeletion.Modify();
            until DataDeletion.Next() = 0;
        end;
    end;

    procedure ClearSelection(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        if DataDeletion.FindSet() then begin
            repeat
                DataDeletion."Delete Data" := false;
                DataDeletion.Modify();
            until DataDeletion.Next() = 0;
        end;
    end;

    procedure ReverseSelection(CompName: Code[30]; TemplateName: Code[20])
    var
        DataDeletion: Record "Data Deletion";
    begin
        DataDeletion.SetRange("Company Name", CompName);
        DataDeletion.SetRange("Template Name", TemplateName);
        if DataDeletion.FindSet() then begin
            repeat
                DataDeletion."Delete Data" := not DataDeletion."Delete Data";
                DataDeletion.Modify();
            until DataDeletion.Next() = 0;
        end;
    end;

    var
        dlg: Dialog;
        Text100: TextConst ENU = 'Adding Table: #1######';
        Text101: TextConst ENU = 'Counting record: #1######';
        Text200: TextConst ENU = 'All selected table data will be deleted!\Are you sure?\';
        Text300: TextConst ENU = 'Delete all Data Deletion lines?';
        Text400: TextConst ENU = 'Deleting TableData: #1######';
}