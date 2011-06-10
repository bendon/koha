-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Fri Jun 10 12:39:32 2011
-- 
--
-- Table: accountlines
--
DROP TABLE "accountlines" CASCADE;
CREATE TABLE "accountlines" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "accountno" smallint DEFAULT 0 NOT NULL,
  "itemnumber" integer,
  "date" date,
  "amount" numeric(28,6),
  "description" text,
  "dispute" text,
  "accounttype" character varying(5),
  "amountoutstanding" numeric(28,6),
  "lastincrement" numeric(28,6),
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "notify_id" integer DEFAULT 0 NOT NULL,
  "notify_level" integer DEFAULT 0 NOT NULL,
  "note" text,
  "manager_id" integer
);
CREATE INDEX "accountlines_idx_borrowernumber" on "accountlines" ("borrowernumber");
CREATE INDEX "accountlines_idx_itemnumber" on "accountlines" ("itemnumber");

--
-- Table: accountoffsets
--
DROP TABLE "accountoffsets" CASCADE;
CREATE TABLE "accountoffsets" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "accountno" smallint DEFAULT 0 NOT NULL,
  "offsetaccount" smallint DEFAULT 0 NOT NULL,
  "offsetamount" numeric(28,6),
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL
);
CREATE INDEX "accountoffsets_idx_borrowernumber" on "accountoffsets" ("borrowernumber");

--
-- Table: action_logs
--
DROP TABLE "action_logs" CASCADE;
CREATE TABLE "action_logs" (
  "action_id" serial NOT NULL,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "user" integer DEFAULT 0 NOT NULL,
  "module" text,
  "action" text,
  "object" integer,
  "info" text,
  PRIMARY KEY ("action_id")
);

--
-- Table: alert
--
DROP TABLE "alert" CASCADE;
CREATE TABLE "alert" (
  "alertid" serial NOT NULL,
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "type" character varying(10) DEFAULT '' NOT NULL,
  "externalid" character varying(20) DEFAULT '' NOT NULL,
  PRIMARY KEY ("alertid")
);

--
-- Table: aqbasket
--
DROP TABLE "aqbasket" CASCADE;
CREATE TABLE "aqbasket" (
  "basketno" serial NOT NULL,
  "basketname" character varying(50),
  "note" text,
  "booksellernote" text,
  "contractnumber" integer,
  "creationdate" date,
  "closedate" date,
  "booksellerid" integer DEFAULT 1 NOT NULL,
  "authorisedby" character varying(10),
  "booksellerinvoicenumber" text,
  "basketgroupid" integer,
  PRIMARY KEY ("basketno")
);
CREATE INDEX "aqbasket_idx_basketgroupid" on "aqbasket" ("basketgroupid");
CREATE INDEX "aqbasket_idx_booksellerid" on "aqbasket" ("booksellerid");
CREATE INDEX "aqbasket_idx_contractnumber" on "aqbasket" ("contractnumber");

--
-- Table: aqbasketgroups
--
DROP TABLE "aqbasketgroups" CASCADE;
CREATE TABLE "aqbasketgroups" (
  "id" serial NOT NULL,
  "name" character varying(50),
  "closed" smallint,
  "booksellerid" integer NOT NULL,
  "deliveryplace" character varying(10),
  "freedeliveryplace" text,
  "deliverycomment" character varying(255),
  "billingplace" character varying(10) NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "aqbasketgroups_idx_booksellerid" on "aqbasketgroups" ("booksellerid");

--
-- Table: aqbookfund
--
DROP TABLE "aqbookfund" CASCADE;
CREATE TABLE "aqbookfund" (
  "bookfundid" character varying(10) DEFAULT '' NOT NULL,
  "bookfundname" text,
  "bookfundgroup" character varying(5),
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  PRIMARY KEY ("bookfundid", "branchcode")
);

--
-- Table: aqbooksellers
--
DROP TABLE "aqbooksellers" CASCADE;
CREATE TABLE "aqbooksellers" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "address1" text,
  "address2" text,
  "address3" text,
  "address4" text,
  "phone" character varying(30),
  "accountnumber" text,
  "othersupplier" text,
  "currency" character varying(3) DEFAULT '' NOT NULL,
  "booksellerfax" text,
  "notes" text,
  "bookselleremail" text,
  "booksellerurl" text,
  "contact" character varying(100),
  "postal" text,
  "url" character varying(255),
  "contpos" character varying(100),
  "contphone" character varying(100),
  "contfax" character varying(100),
  "contaltphone" character varying(100),
  "contemail" character varying(100),
  "contnotes" text,
  "active" smallint,
  "listprice" character varying(10),
  "invoiceprice" character varying(10),
  "gstreg" smallint,
  "listincgst" smallint,
  "invoiceincgst" smallint,
  "discount" numeric(6,4),
  "fax" character varying(50),
  "gstrate" numeric(6,4),
  PRIMARY KEY ("id")
);
CREATE INDEX "aqbooksellers_idx_invoiceprice" on "aqbooksellers" ("invoiceprice");
CREATE INDEX "aqbooksellers_idx_listprice" on "aqbooksellers" ("listprice");

--
-- Table: aqbudgetperiods
--
DROP TABLE "aqbudgetperiods" CASCADE;
CREATE TABLE "aqbudgetperiods" (
  "budget_period_id" serial NOT NULL,
  "budget_period_startdate" date NOT NULL,
  "budget_period_enddate" date NOT NULL,
  "budget_period_active" smallint DEFAULT 0,
  "budget_period_description" text,
  "budget_period_locked" smallint,
  "sort1_authcat" character varying(10),
  "sort2_authcat" character varying(10),
  "budget_period_total" numeric(28,6),
  PRIMARY KEY ("budget_period_id")
);

--
-- Table: aqbudgets
--
DROP TABLE "aqbudgets" CASCADE;
CREATE TABLE "aqbudgets" (
  "budget_code" character varying(30),
  "budget_amount" numeric(28,6) DEFAULT 0.000000 NOT NULL,
  "budget_id" serial NOT NULL,
  "budget_branchcode" character varying(10),
  "budget_parent_id" integer,
  "budget_name" character varying(80),
  "budget_encumb" numeric(28,6) DEFAULT 0.000000,
  "budget_expend" numeric(28,6) DEFAULT 0.000000,
  "budget_notes" text,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "budget_period_id" integer,
  "sort1_authcat" character varying(80),
  "sort2_authcat" character varying(80),
  "budget_owner_id" integer,
  "budget_permission" integer DEFAULT 0,
  PRIMARY KEY ("budget_id")
);
CREATE INDEX "aqbudgets_idx_budget_period_id" on "aqbudgets" ("budget_period_id");

--
-- Table: aqbudgets_planning
--
DROP TABLE "aqbudgets_planning" CASCADE;
CREATE TABLE "aqbudgets_planning" (
  "plan_id" serial NOT NULL,
  "budget_id" integer NOT NULL,
  "budget_period_id" integer NOT NULL,
  "estimated_amount" numeric(28,6),
  "authcat" character varying(30) NOT NULL,
  "authvalue" character varying(30) NOT NULL,
  "display" smallint DEFAULT 1,
  PRIMARY KEY ("plan_id")
);
CREATE INDEX "aqbudgets_planning_idx_budget_id" on "aqbudgets_planning" ("budget_id");

--
-- Table: aqcontract
--
DROP TABLE "aqcontract" CASCADE;
CREATE TABLE "aqcontract" (
  "contractnumber" serial NOT NULL,
  "contractstartdate" date,
  "contractenddate" date,
  "contractname" character varying(50),
  "contractdescription" text,
  "booksellerid" integer NOT NULL,
  PRIMARY KEY ("contractnumber")
);
CREATE INDEX "aqcontract_idx_booksellerid" on "aqcontract" ("booksellerid");

--
-- Table: aqorderbreakdown
--
DROP TABLE "aqorderbreakdown" CASCADE;
CREATE TABLE "aqorderbreakdown" (
  "ordernumber" integer,
  "linenumber" integer,
  "branchcode" character varying(10),
  "bookfundid" character varying(10) DEFAULT '' NOT NULL,
  "allocation" smallint
);
CREATE INDEX "aqorderbreakdown_idx_bookfundid" on "aqorderbreakdown" ("bookfundid");
CREATE INDEX "aqorderbreakdown_idx_ordernumber" on "aqorderbreakdown" ("ordernumber");

--
-- Table: aqorderdelivery
--
DROP TABLE "aqorderdelivery" CASCADE;
CREATE TABLE "aqorderdelivery" (
  "ordernumber" date,
  "deliverynumber" smallint DEFAULT 0 NOT NULL,
  "deliverydate" character varying(18),
  "qtydelivered" smallint,
  "deliverycomments" text
);

--
-- Table: aqorders
--
DROP TABLE "aqorders" CASCADE;
CREATE TABLE "aqorders" (
  "ordernumber" serial NOT NULL,
  "biblionumber" integer,
  "entrydate" date,
  "quantity" smallint,
  "currency" character varying(3),
  "listprice" numeric(28,6),
  "totalamount" numeric(28,6),
  "datereceived" date,
  "booksellerinvoicenumber" text,
  "freight" numeric(28,6),
  "unitprice" numeric(28,6),
  "quantityreceived" smallint DEFAULT 0 NOT NULL,
  "cancelledby" character varying(10),
  "datecancellationprinted" date,
  "notes" text,
  "supplierreference" text,
  "purchaseordernumber" text,
  "subscription" smallint,
  "serialid" character varying(30),
  "basketno" integer,
  "biblioitemnumber" integer,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "rrp" numeric(13,2),
  "ecost" numeric(13,2),
  "gst" numeric(13,2),
  "budgetdate" date,
  "sort1" character varying(80),
  "sort2" character varying(80),
  "uncertainprice" smallint,
  "budget_id" integer NOT NULL,
  "budgetgroup_id" integer NOT NULL,
  "sort1_authcat" character varying(10),
  "sort2_authcat" character varying(10),
  PRIMARY KEY ("ordernumber")
);
CREATE INDEX "aqorders_idx_basketno" on "aqorders" ("basketno");
CREATE INDEX "aqorders_idx_biblionumber" on "aqorders" ("biblionumber");

--
-- Table: aqorders_items
--
DROP TABLE "aqorders_items" CASCADE;
CREATE TABLE "aqorders_items" (
  "ordernumber" integer NOT NULL,
  "itemnumber" integer NOT NULL,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("itemnumber")
);

--
-- Table: auth_header
--
DROP TABLE "auth_header" CASCADE;
CREATE TABLE "auth_header" (
  "authid" serial NOT NULL,
  "authtypecode" character varying(10) DEFAULT '' NOT NULL,
  "datecreated" date,
  "datemodified" date,
  "origincode" character varying(20),
  "authtrees" text,
  "marc" bytea,
  "linkid" bigint,
  "marcxml" text NOT NULL,
  PRIMARY KEY ("authid")
);

--
-- Table: auth_subfield_structure
--
DROP TABLE "auth_subfield_structure" CASCADE;
CREATE TABLE "auth_subfield_structure" (
  "authtypecode" character varying(10) DEFAULT '' NOT NULL,
  "tagfield" character varying(3) DEFAULT '' NOT NULL,
  "tagsubfield" character varying(1) DEFAULT '' NOT NULL,
  "liblibrarian" character varying(255) DEFAULT '' NOT NULL,
  "libopac" character varying(255) DEFAULT '' NOT NULL,
  "repeatable" smallint DEFAULT 0 NOT NULL,
  "mandatory" smallint DEFAULT 0 NOT NULL,
  "tab" smallint,
  "authorised_value" character varying(10),
  "value_builder" character varying(80),
  "seealso" character varying(255),
  "isurl" smallint,
  "hidden" smallint DEFAULT 0 NOT NULL,
  "linkid" smallint DEFAULT 0 NOT NULL,
  "kohafield" character varying(45) DEFAULT '',
  "frameworkcode" character varying(10),
  PRIMARY KEY ("authtypecode", "tagfield", "tagsubfield")
);

--
-- Table: auth_tag_structure
--
DROP TABLE "auth_tag_structure" CASCADE;
CREATE TABLE "auth_tag_structure" (
  "authtypecode" character varying(10) DEFAULT '' NOT NULL,
  "tagfield" character varying(3) DEFAULT '' NOT NULL,
  "liblibrarian" character varying(255) DEFAULT '' NOT NULL,
  "libopac" character varying(255) DEFAULT '' NOT NULL,
  "repeatable" smallint DEFAULT 0 NOT NULL,
  "mandatory" smallint DEFAULT 0 NOT NULL,
  "authorised_value" character varying(10),
  PRIMARY KEY ("authtypecode", "tagfield")
);
CREATE INDEX "auth_tag_structure_idx_authtypecode" on "auth_tag_structure" ("authtypecode");

--
-- Table: auth_types
--
DROP TABLE "auth_types" CASCADE;
CREATE TABLE "auth_types" (
  "authtypecode" character varying(10) DEFAULT '' NOT NULL,
  "authtypetext" character varying(255) DEFAULT '' NOT NULL,
  "auth_tag_to_report" character varying(3) DEFAULT '' NOT NULL,
  "summary" text NOT NULL,
  PRIMARY KEY ("authtypecode")
);

--
-- Table: authorised_values
--
DROP TABLE "authorised_values" CASCADE;
CREATE TABLE "authorised_values" (
  "id" serial NOT NULL,
  "category" character varying(10) DEFAULT '' NOT NULL,
  "authorised_value" character varying(80) DEFAULT '' NOT NULL,
  "lib" character varying(80),
  "lib_opac" character varying(80),
  "imageurl" character varying(200),
  PRIMARY KEY ("id")
);

--
-- Table: biblio
--
DROP TABLE "biblio" CASCADE;
CREATE TABLE "biblio" (
  "biblionumber" serial NOT NULL,
  "frameworkcode" character varying(4) DEFAULT '' NOT NULL,
  "author" text,
  "title" text,
  "unititle" text,
  "notes" text,
  "serial" smallint,
  "seriestitle" text,
  "copyrightdate" smallint,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "datecreated" date NOT NULL,
  "abstract" text,
  PRIMARY KEY ("biblionumber")
);

--
-- Table: biblio_framework
--
DROP TABLE "biblio_framework" CASCADE;
CREATE TABLE "biblio_framework" (
  "frameworkcode" character varying(4) DEFAULT '' NOT NULL,
  "frameworktext" character varying(255) DEFAULT '' NOT NULL,
  PRIMARY KEY ("frameworkcode")
);

--
-- Table: biblioitems
--
DROP TABLE "biblioitems" CASCADE;
CREATE TABLE "biblioitems" (
  "biblioitemnumber" serial NOT NULL,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "volume" text,
  "number" text,
  "itemtype" character varying(10),
  "isbn" character varying(30),
  "issn" character varying(9),
  "publicationyear" text,
  "publishercode" character varying(255),
  "volumedate" date,
  "volumedesc" text,
  "collectiontitle" text,
  "collectionissn" text,
  "collectionvolume" text,
  "editionstatement" text,
  "editionresponsibility" text,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "illus" character varying(255),
  "pages" character varying(255),
  "notes" text,
  "size" character varying(255),
  "place" character varying(255),
  "lccn" character varying(25),
  "marc" bytea,
  "url" character varying(255),
  "cn_source" character varying(10),
  "cn_class" character varying(30),
  "cn_item" character varying(10),
  "cn_suffix" character varying(10),
  "cn_sort" character varying(30),
  "totalissues" integer,
  "marcxml" text NOT NULL,
  PRIMARY KEY ("biblioitemnumber")
);
CREATE INDEX "biblioitems_idx_biblionumber" on "biblioitems" ("biblionumber");

--
-- Table: borrower_attribute_types
--
DROP TABLE "borrower_attribute_types" CASCADE;
CREATE TABLE "borrower_attribute_types" (
  "code" character varying(10) NOT NULL,
  "description" character varying(255) NOT NULL,
  "repeatable" smallint DEFAULT 0 NOT NULL,
  "unique_id" smallint DEFAULT 0 NOT NULL,
  "opac_display" smallint DEFAULT 0 NOT NULL,
  "password_allowed" smallint DEFAULT 0 NOT NULL,
  "staff_searchable" smallint DEFAULT 0 NOT NULL,
  "authorised_value_category" character varying(10),
  PRIMARY KEY ("code")
);

--
-- Table: borrower_attributes
--
DROP TABLE "borrower_attributes" CASCADE;
CREATE TABLE "borrower_attributes" (
  "borrowernumber" integer NOT NULL,
  "code" character varying(10) NOT NULL,
  "attribute" character varying(64),
  "password" character varying(64)
);
CREATE INDEX "borrower_attributes_idx_borrowernumber" on "borrower_attributes" ("borrowernumber");
CREATE INDEX "borrower_attributes_idx_code" on "borrower_attributes" ("code");

--
-- Table: borrower_message_preferences
--
DROP TABLE "borrower_message_preferences" CASCADE;
CREATE TABLE "borrower_message_preferences" (
  "borrower_message_preference_id" serial NOT NULL,
  "borrowernumber" integer,
  "categorycode" character varying(10),
  "message_attribute_id" integer DEFAULT 0,
  "days_in_advance" integer DEFAULT 0,
  "wants_digest" smallint DEFAULT 0 NOT NULL,
  PRIMARY KEY ("borrower_message_preference_id")
);
CREATE INDEX "borrower_message_preferences_idx_borrowernumber" on "borrower_message_preferences" ("borrowernumber");
CREATE INDEX "borrower_message_preferences_idx_categorycode" on "borrower_message_preferences" ("categorycode");
CREATE INDEX "borrower_message_preferences_idx_message_attribute_id" on "borrower_message_preferences" ("message_attribute_id");

--
-- Table: borrower_message_transport_preferences
--
DROP TABLE "borrower_message_transport_preferences" CASCADE;
CREATE TABLE "borrower_message_transport_preferences" (
  "borrower_message_preference_id" integer DEFAULT 0 NOT NULL,
  "message_transport_type" character varying(20) DEFAULT '0' NOT NULL,
  PRIMARY KEY ("borrower_message_preference_id", "message_transport_type")
);
CREATE INDEX "borrower_message_transport_preferences_idx_borrower_message_preference_id" on "borrower_message_transport_preferences" ("borrower_message_preference_id");
CREATE INDEX "borrower_message_transport_preferences_idx_message_transport_type" on "borrower_message_transport_preferences" ("message_transport_type");

--
-- Table: borrowers
--
DROP TABLE "borrowers" CASCADE;
CREATE TABLE "borrowers" (
  "borrowernumber" serial NOT NULL,
  "cardnumber" character varying(16),
  "surname" text NOT NULL,
  "firstname" text,
  "title" text,
  "othernames" text,
  "initials" text,
  "streetnumber" character varying(10),
  "streettype" character varying(50),
  "address" text NOT NULL,
  "address2" text,
  "city" text NOT NULL,
  "state" text,
  "zipcode" character varying(25),
  "country" text,
  "email" text,
  "phone" text,
  "mobile" character varying(50),
  "fax" text,
  "emailpro" text,
  "phonepro" text,
  "b_streetnumber" character varying(10),
  "b_streettype" character varying(50),
  "b_address" character varying(100),
  "b_address2" text,
  "b_city" text,
  "b_state" text,
  "b_zipcode" character varying(25),
  "b_country" text,
  "b_email" text,
  "b_phone" text,
  "dateofbirth" date,
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  "dateenrolled" date,
  "dateexpiry" date,
  "gonenoaddress" smallint,
  "lost" smallint,
  "debarred" smallint,
  "contactname" text,
  "contactfirstname" text,
  "contacttitle" text,
  "guarantorid" integer,
  "borrowernotes" text,
  "relationship" character varying(100),
  "ethnicity" character varying(50),
  "ethnotes" character varying(255),
  "sex" character varying(1),
  "password" character varying(30),
  "flags" integer,
  "userid" character varying(30),
  "opacnote" text,
  "contactnote" character varying(255),
  "sort1" character varying(80),
  "sort2" character varying(80),
  "altcontactfirstname" character varying(255),
  "altcontactsurname" character varying(255),
  "altcontactaddress1" character varying(255),
  "altcontactaddress2" character varying(255),
  "altcontactaddress3" character varying(255),
  "altcontactstate" text,
  "altcontactzipcode" character varying(50),
  "altcontactcountry" text,
  "altcontactphone" character varying(50),
  "smsalertnumber" character varying(50),
  "disable_reading_history" smallint,
  "privacy" integer DEFAULT 1 NOT NULL,
  PRIMARY KEY ("borrowernumber"),
  CONSTRAINT "cardnumber" UNIQUE ("cardnumber")
);
CREATE INDEX "borrowers_idx_branchcode" on "borrowers" ("branchcode");
CREATE INDEX "borrowers_idx_categorycode" on "borrowers" ("categorycode");

--
-- Table: branch_borrower_circ_rules
--
DROP TABLE "branch_borrower_circ_rules" CASCADE;
CREATE TABLE "branch_borrower_circ_rules" (
  "branchcode" character varying(10) NOT NULL,
  "categorycode" character varying(10) NOT NULL,
  "maxissueqty" integer,
  PRIMARY KEY ("categorycode", "branchcode")
);
CREATE INDEX "branch_borrower_circ_rules_idx_branchcode" on "branch_borrower_circ_rules" ("branchcode");
CREATE INDEX "branch_borrower_circ_rules_idx_categorycode" on "branch_borrower_circ_rules" ("categorycode");

--
-- Table: branch_item_rules
--
DROP TABLE "branch_item_rules" CASCADE;
CREATE TABLE "branch_item_rules" (
  "branchcode" character varying(10) NOT NULL,
  "itemtype" character varying(10) NOT NULL,
  "holdallowed" smallint,
  PRIMARY KEY ("itemtype", "branchcode")
);
CREATE INDEX "branch_item_rules_idx_branchcode" on "branch_item_rules" ("branchcode");
CREATE INDEX "branch_item_rules_idx_itemtype" on "branch_item_rules" ("itemtype");

--
-- Table: branch_transfer_limits
--
DROP TABLE "branch_transfer_limits" CASCADE;
CREATE TABLE "branch_transfer_limits" (
  "limitid" serial NOT NULL,
  "tobranch" character varying(10) NOT NULL,
  "frombranch" character varying(10) NOT NULL,
  "itemtype" character varying(10),
  "ccode" character varying(10),
  PRIMARY KEY ("limitid")
);

--
-- Table: branchcategories
--
DROP TABLE "branchcategories" CASCADE;
CREATE TABLE "branchcategories" (
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  "categoryname" character varying(32),
  "codedescription" text,
  "categorytype" character varying(16),
  PRIMARY KEY ("categorycode")
);

--
-- Table: branchrelations
--
DROP TABLE "branchrelations" CASCADE;
CREATE TABLE "branchrelations" (
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  PRIMARY KEY ("branchcode", "categorycode")
);
CREATE INDEX "branchrelations_idx_branchcode" on "branchrelations" ("branchcode");
CREATE INDEX "branchrelations_idx_categorycode" on "branchrelations" ("categorycode");

--
-- Table: branchtransfers
--
DROP TABLE "branchtransfers" CASCADE;
CREATE TABLE "branchtransfers" (
  "itemnumber" integer DEFAULT 0 NOT NULL,
  "datesent" timestamp,
  "frombranch" character varying(10) DEFAULT '' NOT NULL,
  "datearrived" timestamp,
  "tobranch" character varying(10) DEFAULT '' NOT NULL,
  "comments" text
);
CREATE INDEX "branchtransfers_idx_frombranch" on "branchtransfers" ("frombranch");
CREATE INDEX "branchtransfers_idx_itemnumber" on "branchtransfers" ("itemnumber");
CREATE INDEX "branchtransfers_idx_tobranch" on "branchtransfers" ("tobranch");

--
-- Table: browser
--
DROP TABLE "browser" CASCADE;
CREATE TABLE "browser" (
  "level" integer NOT NULL,
  "classification" character varying(20) NOT NULL,
  "description" character varying(255) NOT NULL,
  "number" bigint NOT NULL,
  "endnode" smallint NOT NULL
);

--
-- Table: categories
--
DROP TABLE "categories" CASCADE;
CREATE TABLE "categories" (
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  "description" text,
  "enrolmentperiod" smallint,
  "enrolmentperioddate" date,
  "upperagelimit" smallint,
  "dateofbirthrequired" smallint,
  "finetype" character varying(30),
  "bulk" smallint,
  "enrolmentfee" numeric(28,6),
  "overduenoticerequired" smallint,
  "issuelimit" smallint,
  "reservefee" numeric(28,6),
  "hidelostitems" smallint DEFAULT 0 NOT NULL,
  "category_type" character varying(1) DEFAULT 'A' NOT NULL,
  PRIMARY KEY ("categorycode")
);

--
-- Table: cities
--
DROP TABLE "cities" CASCADE;
CREATE TABLE "cities" (
  "cityid" serial NOT NULL,
  "city_name" character varying(100) DEFAULT '' NOT NULL,
  "city_zipcode" character varying(20),
  PRIMARY KEY ("cityid")
);

--
-- Table: class_sort_rules
--
DROP TABLE "class_sort_rules" CASCADE;
CREATE TABLE "class_sort_rules" (
  "class_sort_rule" character varying(10) DEFAULT '' NOT NULL,
  "description" text,
  "sort_routine" character varying(30) DEFAULT '' NOT NULL,
  PRIMARY KEY ("class_sort_rule")
);

--
-- Table: class_sources
--
DROP TABLE "class_sources" CASCADE;
CREATE TABLE "class_sources" (
  "cn_source" character varying(10) DEFAULT '' NOT NULL,
  "description" text,
  "used" smallint DEFAULT 0 NOT NULL,
  "class_sort_rule" character varying(10) DEFAULT '' NOT NULL,
  PRIMARY KEY ("cn_source")
);
CREATE INDEX "class_sources_idx_class_sort_rule" on "class_sources" ("class_sort_rule");

--
-- Table: collections
--
DROP TABLE "collections" CASCADE;
CREATE TABLE "collections" (
  "colid" serial NOT NULL,
  "coltitle" character varying(100) DEFAULT '' NOT NULL,
  "coldesc" text NOT NULL,
  "colbranchcode" character varying(4),
  PRIMARY KEY ("colid")
);

--
-- Table: collections_tracking
--
DROP TABLE "collections_tracking" CASCADE;
CREATE TABLE "collections_tracking" (
  "ctid" serial NOT NULL,
  "colid" integer DEFAULT 0 NOT NULL,
  "itemnumber" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("ctid")
);

--
-- Table: creator_batches
--
DROP TABLE "creator_batches" CASCADE;
CREATE TABLE "creator_batches" (
  "label_id" serial NOT NULL,
  "batch_id" integer DEFAULT 1 NOT NULL,
  "item_number" integer,
  "borrower_number" integer,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "branch_code" character varying(10) DEFAULT 'NB' NOT NULL,
  "creator" character(15) DEFAULT 'Labels' NOT NULL,
  PRIMARY KEY ("label_id")
);
CREATE INDEX "creator_batches_idx_borrower_number" on "creator_batches" ("borrower_number");
CREATE INDEX "creator_batches_idx_branch_code" on "creator_batches" ("branch_code");
CREATE INDEX "creator_batches_idx_item_number" on "creator_batches" ("item_number");

--
-- Table: creator_images
--
DROP TABLE "creator_images" CASCADE;
CREATE TABLE "creator_images" (
  "image_id" serial NOT NULL,
  "imagefile" bytea,
  "image_name" character(20) DEFAULT 'DEFAULT' NOT NULL,
  PRIMARY KEY ("image_id"),
  CONSTRAINT "image_name_index" UNIQUE ("image_name")
);

--
-- Table: creator_layouts
--
DROP TABLE "creator_layouts" CASCADE;
CREATE TABLE "creator_layouts" (
  "layout_id" serial NOT NULL,
  "barcode_type" character(100) DEFAULT 'CODE39' NOT NULL,
  "start_label" integer DEFAULT 1 NOT NULL,
  "printing_type" character(32) DEFAULT 'BAR' NOT NULL,
  "layout_name" character(20) DEFAULT 'DEFAULT' NOT NULL,
  "guidebox" integer DEFAULT 0,
  "font" character(10) DEFAULT 'TR' NOT NULL,
  "font_size" integer DEFAULT 10 NOT NULL,
  "units" character(20) DEFAULT 'POINT' NOT NULL,
  "callnum_split" integer DEFAULT 0,
  "text_justify" character(1) DEFAULT 'L' NOT NULL,
  "format_string" character varying(210) DEFAULT 'barcode' NOT NULL,
  "layout_xml" text NOT NULL,
  "creator" character(15) DEFAULT 'Labels' NOT NULL,
  PRIMARY KEY ("layout_id")
);

--
-- Table: creator_templates
--
DROP TABLE "creator_templates" CASCADE;
CREATE TABLE "creator_templates" (
  "template_id" serial NOT NULL,
  "profile_id" integer,
  "template_code" character(100) DEFAULT 'DEFAULT TEMPLATE' NOT NULL,
  "template_desc" character(100) DEFAULT 'Default description' NOT NULL,
  "page_width" numeric DEFAULT 0 NOT NULL,
  "page_height" numeric DEFAULT 0 NOT NULL,
  "label_width" numeric DEFAULT 0 NOT NULL,
  "label_height" numeric DEFAULT 0 NOT NULL,
  "top_text_margin" numeric DEFAULT 0 NOT NULL,
  "left_text_margin" numeric DEFAULT 0 NOT NULL,
  "top_margin" numeric DEFAULT 0 NOT NULL,
  "left_margin" numeric DEFAULT 0 NOT NULL,
  "cols" integer DEFAULT 0 NOT NULL,
  "rows" integer DEFAULT 0 NOT NULL,
  "col_gap" numeric DEFAULT 0 NOT NULL,
  "row_gap" numeric DEFAULT 0 NOT NULL,
  "units" character(20) DEFAULT 'POINT' NOT NULL,
  "creator" character(15) DEFAULT 'Labels' NOT NULL,
  PRIMARY KEY ("template_id")
);

--
-- Table: currency
--
DROP TABLE "currency" CASCADE;
CREATE TABLE "currency" (
  "currency" character varying(10) DEFAULT '' NOT NULL,
  "symbol" character varying(5),
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "rate" numeric(15,5),
  "active" smallint,
  PRIMARY KEY ("currency")
);

--
-- Table: default_borrower_circ_rules
--
DROP TABLE "default_borrower_circ_rules" CASCADE;
CREATE TABLE "default_borrower_circ_rules" (
  "categorycode" character varying(10) NOT NULL,
  "maxissueqty" integer,
  PRIMARY KEY ("categorycode")
);

--
-- Table: default_branch_circ_rules
--
DROP TABLE "default_branch_circ_rules" CASCADE;
CREATE TABLE "default_branch_circ_rules" (
  "branchcode" character varying(10) NOT NULL,
  "maxissueqty" integer,
  "holdallowed" smallint,
  PRIMARY KEY ("branchcode")
);

--
-- Table: default_branch_item_rules
--
DROP TABLE "default_branch_item_rules" CASCADE;
CREATE TABLE "default_branch_item_rules" (
  "itemtype" character varying(10) NOT NULL,
  "holdallowed" smallint,
  PRIMARY KEY ("itemtype")
);

--
-- Table: default_circ_rules
--
DROP TABLE "default_circ_rules" CASCADE;
CREATE TABLE "default_circ_rules" (
  "singleton" character varying DEFAULT 'singleton' NOT NULL,
  "maxissueqty" integer,
  "holdallowed" integer,
  PRIMARY KEY ("singleton")
);

--
-- Table: deletedbiblio
--
DROP TABLE "deletedbiblio" CASCADE;
CREATE TABLE "deletedbiblio" (
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "frameworkcode" character varying(4) DEFAULT '' NOT NULL,
  "author" text,
  "title" text,
  "unititle" text,
  "notes" text,
  "serial" smallint,
  "seriestitle" text,
  "copyrightdate" smallint,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "datecreated" date NOT NULL,
  "abstract" text,
  PRIMARY KEY ("biblionumber")
);

--
-- Table: deletedbiblioitems
--
DROP TABLE "deletedbiblioitems" CASCADE;
CREATE TABLE "deletedbiblioitems" (
  "biblioitemnumber" integer DEFAULT 0 NOT NULL,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "volume" text,
  "number" text,
  "itemtype" character varying(10),
  "isbn" character varying(30),
  "issn" character varying(9),
  "publicationyear" text,
  "publishercode" character varying(255),
  "volumedate" date,
  "volumedesc" text,
  "collectiontitle" text,
  "collectionissn" text,
  "collectionvolume" text,
  "editionstatement" text,
  "editionresponsibility" text,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "illus" character varying(255),
  "pages" character varying(255),
  "notes" text,
  "size" character varying(255),
  "place" character varying(255),
  "lccn" character varying(25),
  "marc" bytea,
  "url" character varying(255),
  "cn_source" character varying(10),
  "cn_class" character varying(30),
  "cn_item" character varying(10),
  "cn_suffix" character varying(10),
  "cn_sort" character varying(30),
  "totalissues" integer,
  "marcxml" text NOT NULL,
  PRIMARY KEY ("biblioitemnumber")
);

--
-- Table: deletedborrowers
--
DROP TABLE "deletedborrowers" CASCADE;
CREATE TABLE "deletedborrowers" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "cardnumber" character varying(16),
  "surname" text NOT NULL,
  "firstname" text,
  "title" text,
  "othernames" text,
  "initials" text,
  "streetnumber" character varying(10),
  "streettype" character varying(50),
  "address" text NOT NULL,
  "address2" text,
  "city" text NOT NULL,
  "state" text,
  "zipcode" character varying(25),
  "country" text,
  "email" text,
  "phone" text,
  "mobile" character varying(50),
  "fax" text,
  "emailpro" text,
  "phonepro" text,
  "b_streetnumber" character varying(10),
  "b_streettype" character varying(50),
  "b_address" character varying(100),
  "b_address2" text,
  "b_city" text,
  "b_state" text,
  "b_zipcode" character varying(25),
  "b_country" text,
  "b_email" text,
  "b_phone" text,
  "dateofbirth" date,
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "categorycode" character varying(10),
  "dateenrolled" date,
  "dateexpiry" date,
  "gonenoaddress" smallint,
  "lost" smallint,
  "debarred" smallint,
  "contactname" text,
  "contactfirstname" text,
  "contacttitle" text,
  "guarantorid" integer,
  "borrowernotes" text,
  "relationship" character varying(100),
  "ethnicity" character varying(50),
  "ethnotes" character varying(255),
  "sex" character varying(1),
  "password" character varying(30),
  "flags" integer,
  "userid" character varying(30),
  "opacnote" text,
  "contactnote" character varying(255),
  "sort1" character varying(80),
  "sort2" character varying(80),
  "altcontactfirstname" character varying(255),
  "altcontactsurname" character varying(255),
  "altcontactaddress1" character varying(255),
  "altcontactaddress2" character varying(255),
  "altcontactaddress3" character varying(255),
  "altcontactstate" text,
  "altcontactzipcode" character varying(50),
  "altcontactcountry" text,
  "altcontactphone" character varying(50),
  "smsalertnumber" character varying(50),
  "privacy" integer
);

--
-- Table: deleteditems
--
DROP TABLE "deleteditems" CASCADE;
CREATE TABLE "deleteditems" (
  "itemnumber" integer DEFAULT 0 NOT NULL,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "biblioitemnumber" integer DEFAULT 0 NOT NULL,
  "barcode" character varying(20),
  "dateaccessioned" date,
  "booksellerid" text,
  "homebranch" character varying(10),
  "price" numeric(8,2),
  "replacementprice" numeric(8,2),
  "replacementpricedate" date,
  "datelastborrowed" date,
  "datelastseen" date,
  "stack" smallint,
  "notforloan" smallint DEFAULT 0 NOT NULL,
  "damaged" smallint DEFAULT 0 NOT NULL,
  "itemlost" smallint DEFAULT 0 NOT NULL,
  "wthdrawn" smallint DEFAULT 0 NOT NULL,
  "itemcallnumber" character varying(255),
  "issues" smallint,
  "renewals" smallint,
  "reserves" smallint,
  "restricted" smallint,
  "itemnotes" text,
  "holdingbranch" character varying(10),
  "paidfor" text,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "location" character varying(80),
  "permanent_location" character varying(80),
  "onloan" date,
  "cn_source" character varying(10),
  "cn_sort" character varying(30),
  "ccode" character varying(10),
  "materials" character varying(10),
  "uri" character varying(255),
  "itype" character varying(10),
  "more_subfields_xml" text,
  "enumchron" text,
  "copynumber" character varying(32),
  "marc" bytea,
  "stocknumber" character varying(32),
  PRIMARY KEY ("itemnumber"),
  CONSTRAINT "deleteditemsstocknumberidx" UNIQUE ("stocknumber")
);

--
-- Table: ethnicity
--
DROP TABLE "ethnicity" CASCADE;
CREATE TABLE "ethnicity" (
  "code" character varying(10) DEFAULT '' NOT NULL,
  "name" character varying(255),
  PRIMARY KEY ("code")
);

--
-- Table: export_format
--
DROP TABLE "export_format" CASCADE;
CREATE TABLE "export_format" (
  "export_format_id" serial NOT NULL,
  "profile" character varying(255) NOT NULL,
  "description" text NOT NULL,
  "marcfields" text NOT NULL,
  "csv_separator" character varying(2) NOT NULL,
  "field_separator" character varying(2) NOT NULL,
  "subfield_separator" character varying(2) NOT NULL,
  "encoding" character varying(255) NOT NULL,
  PRIMARY KEY ("export_format_id")
);

--
-- Table: fieldmapping
--
DROP TABLE "fieldmapping" CASCADE;
CREATE TABLE "fieldmapping" (
  "id" serial NOT NULL,
  "field" character varying(255) NOT NULL,
  "frameworkcode" character(4) DEFAULT '' NOT NULL,
  "fieldcode" character(3) NOT NULL,
  "subfieldcode" character(1) NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: hold_fill_targets
--
DROP TABLE "hold_fill_targets" CASCADE;
CREATE TABLE "hold_fill_targets" (
  "borrowernumber" integer NOT NULL,
  "biblionumber" integer NOT NULL,
  "itemnumber" integer NOT NULL,
  "source_branchcode" character varying(10),
  "item_level_request" smallint DEFAULT 0 NOT NULL,
  PRIMARY KEY ("itemnumber")
);
CREATE INDEX "hold_fill_targets_idx_biblionumber" on "hold_fill_targets" ("biblionumber");
CREATE INDEX "hold_fill_targets_idx_borrowernumber" on "hold_fill_targets" ("borrowernumber");
CREATE INDEX "hold_fill_targets_idx_source_branchcode" on "hold_fill_targets" ("source_branchcode");

--
-- Table: import_batches
--
DROP TABLE "import_batches" CASCADE;
CREATE TABLE "import_batches" (
  "import_batch_id" serial NOT NULL,
  "matcher_id" integer,
  "template_id" integer,
  "branchcode" character varying(10),
  "num_biblios" integer DEFAULT 0 NOT NULL,
  "num_items" integer DEFAULT 0 NOT NULL,
  "upload_timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "overlay_action" character varying DEFAULT 'create_new' NOT NULL,
  "nomatch_action" character varying DEFAULT 'create_new' NOT NULL,
  "item_action" character varying DEFAULT 'always_add' NOT NULL,
  "import_status" character varying DEFAULT 'staging' NOT NULL,
  "batch_type" character varying DEFAULT 'batch' NOT NULL,
  "file_name" character varying(100),
  "comments" text,
  PRIMARY KEY ("import_batch_id")
);

--
-- Table: import_biblios
--
DROP TABLE "import_biblios" CASCADE;
CREATE TABLE "import_biblios" (
  "import_record_id" integer NOT NULL,
  "matched_biblionumber" integer,
  "control_number" character varying(25),
  "original_source" character varying(25),
  "title" character varying(128),
  "author" character varying(80),
  "isbn" character varying(30),
  "issn" character varying(9),
  "has_items" smallint DEFAULT 0 NOT NULL
);
CREATE INDEX "import_biblios_idx_import_record_id" on "import_biblios" ("import_record_id");

--
-- Table: import_items
--
DROP TABLE "import_items" CASCADE;
CREATE TABLE "import_items" (
  "import_items_id" serial NOT NULL,
  "import_record_id" integer NOT NULL,
  "itemnumber" integer,
  "branchcode" character varying(10),
  "status" character varying DEFAULT 'staged' NOT NULL,
  "marcxml" text NOT NULL,
  "import_error" text,
  PRIMARY KEY ("import_items_id")
);
CREATE INDEX "import_items_idx_import_record_id" on "import_items" ("import_record_id");

--
-- Table: import_record_matches
--
DROP TABLE "import_record_matches" CASCADE;
CREATE TABLE "import_record_matches" (
  "import_record_id" integer NOT NULL,
  "candidate_match_id" integer NOT NULL,
  "score" integer DEFAULT 0 NOT NULL
);
CREATE INDEX "import_record_matches_idx_import_record_id" on "import_record_matches" ("import_record_id");

--
-- Table: import_records
--
DROP TABLE "import_records" CASCADE;
CREATE TABLE "import_records" (
  "import_record_id" serial NOT NULL,
  "import_batch_id" integer NOT NULL,
  "branchcode" character varying(10),
  "record_sequence" integer DEFAULT 0 NOT NULL,
  "upload_timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "import_date" date,
  "marc" bytea NOT NULL,
  "marcxml" text NOT NULL,
  "marcxml_old" text NOT NULL,
  "record_type" character varying DEFAULT 'biblio' NOT NULL,
  "overlay_status" character varying DEFAULT 'no_match' NOT NULL,
  "status" character varying DEFAULT 'staged' NOT NULL,
  "import_error" text,
  "encoding" character varying(40) DEFAULT '' NOT NULL,
  "z3950random" character varying(40),
  PRIMARY KEY ("import_record_id")
);
CREATE INDEX "import_records_idx_import_batch_id" on "import_records" ("import_batch_id");

--
-- Table: issues
--
DROP TABLE "issues" CASCADE;
CREATE TABLE "issues" (
  "borrowernumber" integer,
  "itemnumber" integer,
  "date_due" date,
  "branchcode" character varying(10),
  "issuingbranch" character varying(18),
  "returndate" date,
  "lastreneweddate" date,
  "return" character varying(4),
  "renewals" smallint,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "issuedate" date
);
CREATE INDEX "issues_idx_borrowernumber" on "issues" ("borrowernumber");
CREATE INDEX "issues_idx_itemnumber" on "issues" ("itemnumber");

--
-- Table: issuingrules
--
DROP TABLE "issuingrules" CASCADE;
CREATE TABLE "issuingrules" (
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  "itemtype" character varying(10) DEFAULT '' NOT NULL,
  "restrictedtype" smallint,
  "rentaldiscount" numeric(28,6),
  "reservecharge" numeric(28,6),
  "fine" numeric(28,6),
  "finedays" integer,
  "firstremind" integer,
  "chargeperiod" integer,
  "accountsent" integer,
  "chargename" character varying(100),
  "maxissueqty" integer,
  "issuelength" integer,
  "hardduedate" date,
  "hardduedatecompare" smallint DEFAULT 0 NOT NULL,
  "renewalsallowed" smallint DEFAULT 0 NOT NULL,
  "reservesallowed" smallint DEFAULT 0 NOT NULL,
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  PRIMARY KEY ("branchcode", "categorycode", "itemtype")
);

--
-- Table: item_circulation_alert_preferences
--
DROP TABLE "item_circulation_alert_preferences" CASCADE;
CREATE TABLE "item_circulation_alert_preferences" (
  "id" serial NOT NULL,
  "branchcode" character varying(10) NOT NULL,
  "categorycode" character varying(10) NOT NULL,
  "item_type" character varying(10) NOT NULL,
  "notification" character varying(16) NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: itemdeletelist
--
DROP TABLE "itemdeletelist" CASCADE;
CREATE TABLE "itemdeletelist" (
  "list_id" integer NOT NULL,
  "itemnumber" integer NOT NULL,
  "biblionumber" integer NOT NULL,
  PRIMARY KEY ("list_id", "itemnumber")
);

--
-- Table: items
--
DROP TABLE "items" CASCADE;
CREATE TABLE "items" (
  "itemnumber" serial NOT NULL,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "biblioitemnumber" integer DEFAULT 0 NOT NULL,
  "barcode" character varying(20),
  "dateaccessioned" date,
  "booksellerid" text,
  "homebranch" character varying(10),
  "price" numeric(8,2),
  "replacementprice" numeric(8,2),
  "replacementpricedate" date,
  "datelastborrowed" date,
  "datelastseen" date,
  "stack" smallint,
  "notforloan" smallint DEFAULT 0 NOT NULL,
  "damaged" smallint DEFAULT 0 NOT NULL,
  "itemlost" smallint DEFAULT 0 NOT NULL,
  "wthdrawn" smallint DEFAULT 0 NOT NULL,
  "itemcallnumber" character varying(255),
  "issues" smallint,
  "renewals" smallint,
  "reserves" smallint,
  "restricted" smallint,
  "itemnotes" text,
  "holdingbranch" character varying(10),
  "paidfor" text,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "location" character varying(80),
  "permanent_location" character varying(80),
  "onloan" date,
  "cn_source" character varying(10),
  "cn_sort" character varying(30),
  "ccode" character varying(10),
  "materials" character varying(10),
  "uri" character varying(255),
  "itype" character varying(10),
  "more_subfields_xml" text,
  "enumchron" text,
  "copynumber" character varying(32),
  "stocknumber" character varying(32),
  PRIMARY KEY ("itemnumber"),
  CONSTRAINT "itembarcodeidx" UNIQUE ("barcode")
);
CREATE INDEX "items_idx_biblioitemnumber" on "items" ("biblioitemnumber");
CREATE INDEX "items_idx_holdingbranch" on "items" ("holdingbranch");
CREATE INDEX "items_idx_homebranch" on "items" ("homebranch");

--
-- Table: itemtypes
--
DROP TABLE "itemtypes" CASCADE;
CREATE TABLE "itemtypes" (
  "itemtype" character varying(10) DEFAULT '' NOT NULL,
  "description" text,
  "rentalcharge" double precision,
  "notforloan" smallint,
  "imageurl" character varying(200),
  "summary" text,
  PRIMARY KEY ("itemtype")
);

--
-- Table: labels_batches
--
DROP TABLE "labels_batches" CASCADE;
CREATE TABLE "labels_batches" (
  "label_id" serial NOT NULL,
  "batch_id" integer DEFAULT 1 NOT NULL,
  "item_number" integer DEFAULT 0 NOT NULL,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "branch_code" character varying(10) DEFAULT 'NB' NOT NULL,
  PRIMARY KEY ("label_id")
);
CREATE INDEX "labels_batches_idx_branch_code" on "labels_batches" ("branch_code");
CREATE INDEX "labels_batches_idx_item_number" on "labels_batches" ("item_number");

--
-- Table: labels_layouts
--
DROP TABLE "labels_layouts" CASCADE;
CREATE TABLE "labels_layouts" (
  "layout_id" serial NOT NULL,
  "barcode_type" character(100) DEFAULT 'CODE39' NOT NULL,
  "printing_type" character(32) DEFAULT 'BAR' NOT NULL,
  "layout_name" character(20) DEFAULT 'DEFAULT' NOT NULL,
  "guidebox" integer DEFAULT 0,
  "font" character(10) DEFAULT 'TR' NOT NULL,
  "font_size" integer DEFAULT 10 NOT NULL,
  "callnum_split" integer DEFAULT 0,
  "text_justify" character(1) DEFAULT 'L' NOT NULL,
  "format_string" character varying(210) DEFAULT 'barcode' NOT NULL,
  PRIMARY KEY ("layout_id")
);

--
-- Table: labels_templates
--
DROP TABLE "labels_templates" CASCADE;
CREATE TABLE "labels_templates" (
  "template_id" serial NOT NULL,
  "profile_id" integer,
  "template_code" character(100) DEFAULT 'DEFAULT TEMPLATE' NOT NULL,
  "template_desc" character(100) DEFAULT 'Default description' NOT NULL,
  "page_width" numeric DEFAULT 0 NOT NULL,
  "page_height" numeric DEFAULT 0 NOT NULL,
  "label_width" numeric DEFAULT 0 NOT NULL,
  "label_height" numeric DEFAULT 0 NOT NULL,
  "top_text_margin" numeric DEFAULT 0 NOT NULL,
  "left_text_margin" numeric DEFAULT 0 NOT NULL,
  "top_margin" numeric DEFAULT 0 NOT NULL,
  "left_margin" numeric DEFAULT 0 NOT NULL,
  "cols" integer DEFAULT 0 NOT NULL,
  "rows" integer DEFAULT 0 NOT NULL,
  "col_gap" numeric DEFAULT 0 NOT NULL,
  "row_gap" numeric DEFAULT 0 NOT NULL,
  "units" character(20) DEFAULT 'POINT' NOT NULL,
  PRIMARY KEY ("template_id")
);

--
-- Table: language_descriptions
--
DROP TABLE "language_descriptions" CASCADE;
CREATE TABLE "language_descriptions" (
  "subtag" character varying(25),
  "type" character varying(25),
  "lang" character varying(25),
  "description" character varying(255),
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: language_rfc4646_to_iso639
--
DROP TABLE "language_rfc4646_to_iso639" CASCADE;
CREATE TABLE "language_rfc4646_to_iso639" (
  "rfc4646_subtag" character varying(25),
  "iso639_2_code" character varying(25),
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: language_script_bidi
--
DROP TABLE "language_script_bidi" CASCADE;
CREATE TABLE "language_script_bidi" (
  "rfc4646_subtag" character varying(25),
  "bidi" character varying(3)
);

--
-- Table: language_script_mapping
--
DROP TABLE "language_script_mapping" CASCADE;
CREATE TABLE "language_script_mapping" (
  "language_subtag" character varying(25),
  "script_subtag" character varying(25)
);

--
-- Table: language_subtag_registry
--
DROP TABLE "language_subtag_registry" CASCADE;
CREATE TABLE "language_subtag_registry" (
  "subtag" character varying(25),
  "type" character varying(25),
  "description" character varying(25),
  "added" date,
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: letter
--
DROP TABLE "letter" CASCADE;
CREATE TABLE "letter" (
  "module" character varying(20) DEFAULT '' NOT NULL,
  "code" character varying(20) DEFAULT '' NOT NULL,
  "name" character varying(100) DEFAULT '' NOT NULL,
  "title" character varying(200) DEFAULT '' NOT NULL,
  "content" text,
  PRIMARY KEY ("module", "code")
);

--
-- Table: marc_matchers
--
DROP TABLE "marc_matchers" CASCADE;
CREATE TABLE "marc_matchers" (
  "matcher_id" serial NOT NULL,
  "code" character varying(10) DEFAULT '' NOT NULL,
  "description" character varying(255) DEFAULT '' NOT NULL,
  "record_type" character varying(10) DEFAULT 'biblio' NOT NULL,
  "threshold" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("matcher_id")
);

--
-- Table: marc_subfield_structure
--
DROP TABLE "marc_subfield_structure" CASCADE;
CREATE TABLE "marc_subfield_structure" (
  "tagfield" character varying(3) DEFAULT '' NOT NULL,
  "tagsubfield" character varying(1) DEFAULT '' NOT NULL,
  "liblibrarian" character varying(255) DEFAULT '' NOT NULL,
  "libopac" character varying(255) DEFAULT '' NOT NULL,
  "repeatable" smallint DEFAULT 0 NOT NULL,
  "mandatory" smallint DEFAULT 0 NOT NULL,
  "kohafield" character varying(40),
  "tab" smallint,
  "authorised_value" character varying(20),
  "authtypecode" character varying(20),
  "value_builder" character varying(80),
  "isurl" smallint,
  "hidden" smallint,
  "frameworkcode" character varying(4) DEFAULT '' NOT NULL,
  "seealso" character varying(1100),
  "link" character varying(80),
  "defaultvalue" text,
  PRIMARY KEY ("frameworkcode", "tagfield", "tagsubfield")
);

--
-- Table: marc_tag_structure
--
DROP TABLE "marc_tag_structure" CASCADE;
CREATE TABLE "marc_tag_structure" (
  "tagfield" character varying(3) DEFAULT '' NOT NULL,
  "liblibrarian" character varying(255) DEFAULT '' NOT NULL,
  "libopac" character varying(255) DEFAULT '' NOT NULL,
  "repeatable" smallint DEFAULT 0 NOT NULL,
  "mandatory" smallint DEFAULT 0 NOT NULL,
  "authorised_value" character varying(10),
  "frameworkcode" character varying(4) DEFAULT '' NOT NULL,
  PRIMARY KEY ("frameworkcode", "tagfield")
);

--
-- Table: matchchecks
--
DROP TABLE "matchchecks" CASCADE;
CREATE TABLE "matchchecks" (
  "matcher_id" integer NOT NULL,
  "matchcheck_id" serial NOT NULL,
  "source_matchpoint_id" integer NOT NULL,
  "target_matchpoint_id" integer NOT NULL,
  PRIMARY KEY ("matchcheck_id")
);
CREATE INDEX "matchchecks_idx_matcher_id" on "matchchecks" ("matcher_id");
CREATE INDEX "matchchecks_idx_source_matchpoint_id" on "matchchecks" ("source_matchpoint_id");
CREATE INDEX "matchchecks_idx_target_matchpoint_id" on "matchchecks" ("target_matchpoint_id");

--
-- Table: matcher_matchpoints
--
DROP TABLE "matcher_matchpoints" CASCADE;
CREATE TABLE "matcher_matchpoints" (
  "matcher_id" integer NOT NULL,
  "matchpoint_id" integer NOT NULL
);
CREATE INDEX "matcher_matchpoints_idx_matcher_id" on "matcher_matchpoints" ("matcher_id");
CREATE INDEX "matcher_matchpoints_idx_matchpoint_id" on "matcher_matchpoints" ("matchpoint_id");

--
-- Table: matchpoint_component_norms
--
DROP TABLE "matchpoint_component_norms" CASCADE;
CREATE TABLE "matchpoint_component_norms" (
  "matchpoint_component_id" integer NOT NULL,
  "sequence" integer DEFAULT 0 NOT NULL,
  "norm_routine" character varying(50) DEFAULT '' NOT NULL
);
CREATE INDEX "matchpoint_component_norms_idx_matchpoint_component_id" on "matchpoint_component_norms" ("matchpoint_component_id");

--
-- Table: matchpoint_components
--
DROP TABLE "matchpoint_components" CASCADE;
CREATE TABLE "matchpoint_components" (
  "matchpoint_id" integer NOT NULL,
  "matchpoint_component_id" serial NOT NULL,
  "sequence" integer DEFAULT 0 NOT NULL,
  "tag" character varying(3) DEFAULT '' NOT NULL,
  "subfields" character varying(40) DEFAULT '' NOT NULL,
  "offset" integer DEFAULT 0 NOT NULL,
  "length" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("matchpoint_component_id")
);
CREATE INDEX "matchpoint_components_idx_matchpoint_id" on "matchpoint_components" ("matchpoint_id");

--
-- Table: matchpoints
--
DROP TABLE "matchpoints" CASCADE;
CREATE TABLE "matchpoints" (
  "matcher_id" integer NOT NULL,
  "matchpoint_id" serial NOT NULL,
  "search_index" character varying(30) DEFAULT '' NOT NULL,
  "score" integer DEFAULT 0 NOT NULL,
  PRIMARY KEY ("matchpoint_id")
);
CREATE INDEX "matchpoints_idx_matcher_id" on "matchpoints" ("matcher_id");

--
-- Table: message_attributes
--
DROP TABLE "message_attributes" CASCADE;
CREATE TABLE "message_attributes" (
  "message_attribute_id" serial NOT NULL,
  "message_name" character varying(40),
  "takes_days" smallint DEFAULT 0 NOT NULL,
  PRIMARY KEY ("message_attribute_id"),
  CONSTRAINT "message_name" UNIQUE ("message_name")
);

--
-- Table: message_queue
--
DROP TABLE "message_queue" CASCADE;
CREATE TABLE "message_queue" (
  "message_id" serial NOT NULL,
  "borrowernumber" integer,
  "subject" text,
  "content" text,
  "metadata" text,
  "letter_code" character varying(64),
  "message_transport_type" character varying(20) NOT NULL,
  "status" character varying DEFAULT 'pending' NOT NULL,
  "time_queued" timestamp DEFAULT current_timestamp NOT NULL,
  "to_address" text,
  "from_address" text,
  "content_type" text
);
CREATE INDEX "message_queue_idx_borrowernumber" on "message_queue" ("borrowernumber");
CREATE INDEX "message_queue_idx_message_transport_type" on "message_queue" ("message_transport_type");

--
-- Table: message_transport_types
--
DROP TABLE "message_transport_types" CASCADE;
CREATE TABLE "message_transport_types" (
  "message_transport_type" character varying(20) NOT NULL,
  PRIMARY KEY ("message_transport_type")
);

--
-- Table: message_transports
--
DROP TABLE "message_transports" CASCADE;
CREATE TABLE "message_transports" (
  "message_attribute_id" integer NOT NULL,
  "message_transport_type" character varying(20) NOT NULL,
  "is_digest" smallint DEFAULT 0 NOT NULL,
  "letter_module" character varying(20) DEFAULT '' NOT NULL,
  "letter_code" character varying(20) DEFAULT '' NOT NULL,
  PRIMARY KEY ("message_attribute_id", "message_transport_type", "is_digest")
);
CREATE INDEX "message_transports_idx_letter_module_letter_code" on "message_transports" ("letter_module", "letter_code");
CREATE INDEX "message_transports_idx_message_attribute_id" on "message_transports" ("message_attribute_id");
CREATE INDEX "message_transports_idx_message_transport_type" on "message_transports" ("message_transport_type");

--
-- Table: messages
--
DROP TABLE "messages" CASCADE;
CREATE TABLE "messages" (
  "message_id" serial NOT NULL,
  "borrowernumber" integer NOT NULL,
  "branchcode" character varying(10),
  "message_type" character varying(1) NOT NULL,
  "message" text NOT NULL,
  "message_date" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("message_id")
);

--
-- Table: notifys
--
DROP TABLE "notifys" CASCADE;
CREATE TABLE "notifys" (
  "notify_id" integer DEFAULT 0 NOT NULL,
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "itemnumber" integer DEFAULT 0 NOT NULL,
  "notify_date" date,
  "notify_send_date" date,
  "notify_level" integer DEFAULT 0 NOT NULL,
  "method" character varying(20) DEFAULT '' NOT NULL
);

--
-- Table: nozebra
--
DROP TABLE "nozebra" CASCADE;
CREATE TABLE "nozebra" (
  "server" character varying(20) NOT NULL,
  "indexname" character varying(40) NOT NULL,
  "value" character varying(250) NOT NULL,
  "biblionumbers" text NOT NULL
);

--
-- Table: old_issues
--
DROP TABLE "old_issues" CASCADE;
CREATE TABLE "old_issues" (
  "borrowernumber" integer,
  "itemnumber" integer,
  "date_due" date,
  "branchcode" character varying(10),
  "issuingbranch" character varying(18),
  "returndate" date,
  "lastreneweddate" date,
  "return" character varying(4),
  "renewals" smallint,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "issuedate" date
);
CREATE INDEX "old_issues_idx_borrowernumber" on "old_issues" ("borrowernumber");
CREATE INDEX "old_issues_idx_itemnumber" on "old_issues" ("itemnumber");

--
-- Table: old_reserves
--
DROP TABLE "old_reserves" CASCADE;
CREATE TABLE "old_reserves" (
  "borrowernumber" integer,
  "reservedate" date,
  "biblionumber" integer,
  "constrainttype" character varying(1),
  "branchcode" character varying(10),
  "notificationdate" date,
  "reminderdate" date,
  "cancellationdate" date,
  "reservenotes" text,
  "priority" smallint,
  "found" character varying(1),
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "itemnumber" integer,
  "waitingdate" date,
  "expirationdate" date,
  "lowestpriority" smallint NOT NULL
);
CREATE INDEX "old_reserves_idx_biblionumber" on "old_reserves" ("biblionumber");
CREATE INDEX "old_reserves_idx_borrowernumber" on "old_reserves" ("borrowernumber");
CREATE INDEX "old_reserves_idx_itemnumber" on "old_reserves" ("itemnumber");

--
-- Table: opac_news
--
DROP TABLE "opac_news" CASCADE;
CREATE TABLE "opac_news" (
  "idnew" serial NOT NULL,
  "title" character varying(250) DEFAULT '' NOT NULL,
  "new" text NOT NULL,
  "lang" character varying(25) DEFAULT '' NOT NULL,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "expirationdate" date,
  "number" integer,
  PRIMARY KEY ("idnew")
);

--
-- Table: overduerules
--
DROP TABLE "overduerules" CASCADE;
CREATE TABLE "overduerules" (
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "categorycode" character varying(10) DEFAULT '' NOT NULL,
  "delay1" integer,
  "letter1" character varying(20),
  "debarred1" character varying(1) DEFAULT '0',
  "delay2" integer,
  "debarred2" character varying(1) DEFAULT '0',
  "letter2" character varying(20),
  "delay3" integer,
  "letter3" character varying(20),
  "debarred3" integer DEFAULT 0,
  PRIMARY KEY ("branchcode", "categorycode")
);

--
-- Table: patroncards
--
DROP TABLE "patroncards" CASCADE;
CREATE TABLE "patroncards" (
  "cardid" serial NOT NULL,
  "batch_id" character varying(10) DEFAULT '1' NOT NULL,
  "borrowernumber" integer NOT NULL,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("cardid")
);
CREATE INDEX "patroncards_idx_borrowernumber" on "patroncards" ("borrowernumber");

--
-- Table: patronimage
--
DROP TABLE "patronimage" CASCADE;
CREATE TABLE "patronimage" (
  "cardnumber" character varying(16) NOT NULL,
  "mimetype" character varying(15) NOT NULL,
  "imagefile" bytea NOT NULL,
  PRIMARY KEY ("cardnumber")
);

--
-- Table: permissions
--
DROP TABLE "permissions" CASCADE;
CREATE TABLE "permissions" (
  "module_bit" integer DEFAULT 0 NOT NULL,
  "code" character varying(64) DEFAULT '' NOT NULL,
  "description" character varying(255),
  PRIMARY KEY ("module_bit", "code")
);
CREATE INDEX "permissions_idx_module_bit" on "permissions" ("module_bit");

--
-- Table: printers
--
DROP TABLE "printers" CASCADE;
CREATE TABLE "printers" (
  "printername" character varying(40) DEFAULT '' NOT NULL,
  "printqueue" character varying(20),
  "printtype" character varying(20),
  PRIMARY KEY ("printername")
);

--
-- Table: printers_profile
--
DROP TABLE "printers_profile" CASCADE;
CREATE TABLE "printers_profile" (
  "profile_id" serial NOT NULL,
  "printer_name" character varying(40) DEFAULT 'Default Printer' NOT NULL,
  "template_id" integer DEFAULT 0 NOT NULL,
  "paper_bin" character varying(20) DEFAULT 'Bypass' NOT NULL,
  "offset_horz" numeric DEFAULT 0 NOT NULL,
  "offset_vert" numeric DEFAULT 0 NOT NULL,
  "creep_horz" numeric DEFAULT 0 NOT NULL,
  "creep_vert" numeric DEFAULT 0 NOT NULL,
  "units" character(20) DEFAULT 'POINT' NOT NULL,
  "creator" character(15) DEFAULT 'Labels' NOT NULL,
  PRIMARY KEY ("profile_id"),
  CONSTRAINT "printername" UNIQUE ("printer_name", "template_id", "paper_bin", "creator")
);

--
-- Table: repeatable_holidays
--
DROP TABLE "repeatable_holidays" CASCADE;
CREATE TABLE "repeatable_holidays" (
  "id" serial NOT NULL,
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "weekday" smallint,
  "day" smallint,
  "month" smallint,
  "title" character varying(50) DEFAULT '' NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: reports_dictionary
--
DROP TABLE "reports_dictionary" CASCADE;
CREATE TABLE "reports_dictionary" (
  "id" serial NOT NULL,
  "name" character varying(255),
  "description" text,
  "date_created" timestamp,
  "date_modified" timestamp,
  "saved_sql" text,
  "area" integer,
  PRIMARY KEY ("id")
);

--
-- Table: reserveconstraints
--
DROP TABLE "reserveconstraints" CASCADE;
CREATE TABLE "reserveconstraints" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "reservedate" date,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "biblioitemnumber" integer,
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL
);

--
-- Table: reserves
--
DROP TABLE "reserves" CASCADE;
CREATE TABLE "reserves" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "reservedate" date,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "constrainttype" character varying(1),
  "branchcode" character varying(10),
  "notificationdate" date,
  "reminderdate" date,
  "cancellationdate" date,
  "reservenotes" text,
  "priority" smallint,
  "found" character varying(1),
  "timestamp" timestamp DEFAULT current_timestamp NOT NULL,
  "itemnumber" integer,
  "waitingdate" date,
  "expirationdate" date,
  "lowestpriority" smallint NOT NULL
);
CREATE INDEX "reserves_idx_biblionumber" on "reserves" ("biblionumber");
CREATE INDEX "reserves_idx_borrowernumber" on "reserves" ("borrowernumber");
CREATE INDEX "reserves_idx_branchcode" on "reserves" ("branchcode");
CREATE INDEX "reserves_idx_itemnumber" on "reserves" ("itemnumber");

--
-- Table: reviews
--
DROP TABLE "reviews" CASCADE;
CREATE TABLE "reviews" (
  "reviewid" serial NOT NULL,
  "borrowernumber" integer,
  "biblionumber" integer,
  "review" text,
  "approved" smallint,
  "datereviewed" timestamp,
  PRIMARY KEY ("reviewid")
);

--
-- Table: roadtype
--
DROP TABLE "roadtype" CASCADE;
CREATE TABLE "roadtype" (
  "roadtypeid" serial NOT NULL,
  "road_type" character varying(100) DEFAULT '' NOT NULL,
  PRIMARY KEY ("roadtypeid")
);

--
-- Table: saved_reports
--
DROP TABLE "saved_reports" CASCADE;
CREATE TABLE "saved_reports" (
  "id" serial NOT NULL,
  "report_id" integer,
  "report" text,
  "date_run" timestamp,
  PRIMARY KEY ("id")
);

--
-- Table: saved_sql
--
DROP TABLE "saved_sql" CASCADE;
CREATE TABLE "saved_sql" (
  "id" serial NOT NULL,
  "borrowernumber" integer,
  "date_created" timestamp,
  "last_modified" timestamp,
  "savedsql" text,
  "last_run" timestamp,
  "report_name" character varying(255),
  "type" character varying(255),
  "notes" text,
  PRIMARY KEY ("id")
);

--
-- Table: search_history
--
DROP TABLE "search_history" CASCADE;
CREATE TABLE "search_history" (
  "userid" integer NOT NULL,
  "sessionid" character varying(32) NOT NULL,
  "query_desc" character varying(255) NOT NULL,
  "query_cgi" character varying(255) NOT NULL,
  "total" integer NOT NULL,
  "time" timestamp DEFAULT current_timestamp NOT NULL
);

--
-- Table: serial
--
DROP TABLE "serial" CASCADE;
CREATE TABLE "serial" (
  "serialid" serial NOT NULL,
  "biblionumber" character varying(100) DEFAULT '' NOT NULL,
  "subscriptionid" character varying(100) DEFAULT '' NOT NULL,
  "serialseq" character varying(100) DEFAULT '' NOT NULL,
  "status" smallint DEFAULT 0 NOT NULL,
  "planneddate" date,
  "notes" text,
  "publisheddate" date,
  "itemnumber" text,
  "claimdate" date,
  "routingnotes" text,
  PRIMARY KEY ("serialid")
);

--
-- Table: serialitems
--
DROP TABLE "serialitems" CASCADE;
CREATE TABLE "serialitems" (
  "itemnumber" integer NOT NULL,
  "serialid" integer NOT NULL,
  CONSTRAINT "serialitemsidx" UNIQUE ("itemnumber")
);
CREATE INDEX "serialitems_idx_serialid" on "serialitems" ("serialid");

--
-- Table: services_throttle
--
DROP TABLE "services_throttle" CASCADE;
CREATE TABLE "services_throttle" (
  "service_type" character varying(10) DEFAULT '' NOT NULL,
  "service_count" character varying(45),
  PRIMARY KEY ("service_type")
);

--
-- Table: sessions
--
DROP TABLE "sessions" CASCADE;
CREATE TABLE "sessions" (
  "id" character varying(32) NOT NULL,
  "a_session" text NOT NULL,
  CONSTRAINT "id" UNIQUE ("id")
);

--
-- Table: special_holidays
--
DROP TABLE "special_holidays" CASCADE;
CREATE TABLE "special_holidays" (
  "id" serial NOT NULL,
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "day" smallint DEFAULT 0 NOT NULL,
  "month" smallint DEFAULT 0 NOT NULL,
  "year" smallint DEFAULT 0 NOT NULL,
  "isexception" smallint DEFAULT 1 NOT NULL,
  "title" character varying(50) DEFAULT '' NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: stat_from_marcxml
--
DROP TABLE "stat_from_marcxml" CASCADE;
CREATE TABLE "stat_from_marcxml" (
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "itemtype" character varying(1),
  "cataloguerm" text,
  "cataloguers" text,
  "insertdate" character varying(6),
  "modifydate" character varying(8),
  "accessionno" text,
  "isbn" text,
  "issn" text,
  "callnumber" text,
  "title" text
);

--
-- Table: statistics
--
DROP TABLE "statistics" CASCADE;
CREATE TABLE "statistics" (
  "datetime" timestamp,
  "branch" character varying(10),
  "proccode" character varying(4),
  "value" double precision,
  "type" character varying(16),
  "other" text,
  "usercode" character varying(10),
  "itemnumber" integer,
  "itemtype" character varying(10),
  "borrowernumber" integer,
  "associatedborrower" integer
);

--
-- Table: stopwords
--
DROP TABLE "stopwords" CASCADE;
CREATE TABLE "stopwords" (
  "word" character varying(255)
);

--
-- Table: subscription
--
DROP TABLE "subscription" CASCADE;
CREATE TABLE "subscription" (
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "subscriptionid" serial NOT NULL,
  "librarian" character varying(100) DEFAULT '',
  "startdate" date,
  "aqbooksellerid" integer DEFAULT 0,
  "cost" integer DEFAULT 0,
  "aqbudgetid" integer DEFAULT 0,
  "weeklength" integer DEFAULT 0,
  "monthlength" integer DEFAULT 0,
  "numberlength" integer DEFAULT 0,
  "periodicity" smallint DEFAULT 0,
  "dow" character varying(100) DEFAULT '',
  "numberingmethod" character varying(100) DEFAULT '',
  "notes" text,
  "status" character varying(100) DEFAULT '' NOT NULL,
  "add1" integer DEFAULT 0,
  "every1" integer DEFAULT 0,
  "whenmorethan1" integer DEFAULT 0,
  "setto1" integer,
  "lastvalue1" integer,
  "add2" integer DEFAULT 0,
  "every2" integer DEFAULT 0,
  "whenmorethan2" integer DEFAULT 0,
  "setto2" integer,
  "lastvalue2" integer,
  "add3" integer DEFAULT 0,
  "every3" integer DEFAULT 0,
  "innerloop1" integer DEFAULT 0,
  "innerloop2" integer DEFAULT 0,
  "innerloop3" integer DEFAULT 0,
  "whenmorethan3" integer DEFAULT 0,
  "setto3" integer,
  "lastvalue3" integer,
  "issuesatonce" smallint DEFAULT 1 NOT NULL,
  "firstacquidate" date,
  "manualhistory" smallint DEFAULT 0 NOT NULL,
  "irregularity" text,
  "letter" character varying(20),
  "numberpattern" smallint DEFAULT 0,
  "distributedto" text,
  "internalnotes" text,
  "callnumber" text,
  "location" character varying(80) DEFAULT '',
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "hemisphere" smallint DEFAULT 0,
  "lastbranch" character varying(10),
  "serialsadditems" smallint DEFAULT 0 NOT NULL,
  "staffdisplaycount" character varying(10),
  "opacdisplaycount" character varying(10),
  "graceperiod" integer DEFAULT 0 NOT NULL,
  "enddate" date,
  PRIMARY KEY ("subscriptionid")
);

--
-- Table: subscriptionhistory
--
DROP TABLE "subscriptionhistory" CASCADE;
CREATE TABLE "subscriptionhistory" (
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "subscriptionid" integer DEFAULT 0 NOT NULL,
  "histstartdate" date,
  "histenddate" date,
  "missinglist" text NOT NULL,
  "recievedlist" text NOT NULL,
  "opacnote" character varying(150) DEFAULT '' NOT NULL,
  "librariannote" character varying(150) DEFAULT '' NOT NULL,
  PRIMARY KEY ("subscriptionid")
);

--
-- Table: subscriptionroutinglist
--
DROP TABLE "subscriptionroutinglist" CASCADE;
CREATE TABLE "subscriptionroutinglist" (
  "routingid" serial NOT NULL,
  "borrowernumber" integer NOT NULL,
  "ranking" integer,
  "subscriptionid" integer NOT NULL,
  PRIMARY KEY ("routingid"),
  CONSTRAINT "subscriptionid" UNIQUE ("subscriptionid", "borrowernumber")
);
CREATE INDEX "subscriptionroutinglist_idx_borrowernumber" on "subscriptionroutinglist" ("borrowernumber");
CREATE INDEX "subscriptionroutinglist_idx_subscriptionid" on "subscriptionroutinglist" ("subscriptionid");

--
-- Table: suggestions
--
DROP TABLE "suggestions" CASCADE;
CREATE TABLE "suggestions" (
  "suggestionid" serial NOT NULL,
  "suggestedby" integer DEFAULT 0 NOT NULL,
  "managedby" integer,
  "status" character varying(10) DEFAULT '' NOT NULL,
  "note" text,
  "author" character varying(80),
  "title" character varying(80),
  "copyrightdate" smallint,
  "publishercode" character varying(255),
  "date" timestamp DEFAULT current_timestamp NOT NULL,
  "volumedesc" character varying(255),
  "publicationyear" smallint DEFAULT 0,
  "place" character varying(255),
  "isbn" character varying(30),
  "mailoverseeing" smallint DEFAULT 0,
  "biblionumber" integer,
  "reason" text,
  "budgetid" integer,
  "branchcode" character varying(10),
  "acceptedby" integer,
  "accepteddate" date,
  "suggesteddate" date,
  "manageddate" date,
  "rejectedby" integer,
  "rejecteddate" date,
  "collectiontitle" text,
  "itemtype" character varying(30),
  "quantity" smallint,
  "currency" character varying(3),
  "price" numeric(28,6),
  "total" numeric(28,6),
  PRIMARY KEY ("suggestionid")
);

--
-- Table: systempreferences
--
DROP TABLE "systempreferences" CASCADE;
CREATE TABLE "systempreferences" (
  "variable" character varying(50) DEFAULT '' NOT NULL,
  "value" text,
  "options" text,
  "explanation" text,
  "type" character varying(20),
  PRIMARY KEY ("variable")
);

--
-- Table: tags
--
DROP TABLE "tags" CASCADE;
CREATE TABLE "tags" (
  "entry" character varying(255) DEFAULT '' NOT NULL,
  "weight" bigint DEFAULT 0 NOT NULL,
  PRIMARY KEY ("entry")
);

--
-- Table: tags_all
--
DROP TABLE "tags_all" CASCADE;
CREATE TABLE "tags_all" (
  "tag_id" serial NOT NULL,
  "borrowernumber" integer NOT NULL,
  "biblionumber" integer NOT NULL,
  "term" character varying(255) NOT NULL,
  "language" integer,
  "date_created" timestamp NOT NULL,
  PRIMARY KEY ("tag_id")
);
CREATE INDEX "tags_all_idx_biblionumber" on "tags_all" ("biblionumber");
CREATE INDEX "tags_all_idx_borrowernumber" on "tags_all" ("borrowernumber");

--
-- Table: tags_approval
--
DROP TABLE "tags_approval" CASCADE;
CREATE TABLE "tags_approval" (
  "term" character varying(255) NOT NULL,
  "approved" integer DEFAULT 0 NOT NULL,
  "date_approved" timestamp,
  "approved_by" integer,
  "weight_total" integer DEFAULT 1 NOT NULL,
  PRIMARY KEY ("term")
);
CREATE INDEX "tags_approval_idx_approved_by" on "tags_approval" ("approved_by");

--
-- Table: tags_index
--
DROP TABLE "tags_index" CASCADE;
CREATE TABLE "tags_index" (
  "term" character varying(255) NOT NULL,
  "biblionumber" integer NOT NULL,
  "weight" integer DEFAULT 1 NOT NULL,
  PRIMARY KEY ("term", "biblionumber")
);
CREATE INDEX "tags_index_idx_biblionumber" on "tags_index" ("biblionumber");
CREATE INDEX "tags_index_idx_term" on "tags_index" ("term");

--
-- Table: tmp_holdsqueue
--
DROP TABLE "tmp_holdsqueue" CASCADE;
CREATE TABLE "tmp_holdsqueue" (
  "biblionumber" integer,
  "itemnumber" integer,
  "barcode" character varying(20),
  "surname" text NOT NULL,
  "firstname" text,
  "phone" text,
  "borrowernumber" integer NOT NULL,
  "cardnumber" character varying(16),
  "reservedate" date,
  "title" text,
  "itemcallnumber" character varying(255),
  "holdingbranch" character varying(10),
  "pickbranch" character varying(10),
  "notes" text,
  "item_level_request" smallint DEFAULT 0 NOT NULL
);

--
-- Table: user_permissions
--
DROP TABLE "user_permissions" CASCADE;
CREATE TABLE "user_permissions" (
  "borrowernumber" integer DEFAULT 0 NOT NULL,
  "module_bit" integer DEFAULT 0 NOT NULL,
  "code" character varying(64)
);
CREATE INDEX "user_permissions_idx_borrowernumber" on "user_permissions" ("borrowernumber");
CREATE INDEX "user_permissions_idx_module_bit_code" on "user_permissions" ("module_bit", "code");

--
-- Table: userflags
--
DROP TABLE "userflags" CASCADE;
CREATE TABLE "userflags" (
  "bit" integer DEFAULT 0 NOT NULL,
  "flag" character varying(30),
  "flagdesc" character varying(255),
  "defaulton" integer,
  PRIMARY KEY ("bit")
);

--
-- Table: view_maxbasketno_x_biblio
--
DROP TABLE "view_maxbasketno_x_biblio" CASCADE;
CREATE TABLE "view_maxbasketno_x_biblio" (
  "maxbasketno" integer,
  "biblionumber" integer
);

--
-- Table: view_maxsubid_x_biblio
--
DROP TABLE "view_maxsubid_x_biblio" CASCADE;
CREATE TABLE "view_maxsubid_x_biblio" (
  "maxsubscriptionid" integer,
  "biblionumber" integer DEFAULT 0 NOT NULL
);

--
-- Table: virtualshelfcontents
--
DROP TABLE "virtualshelfcontents" CASCADE;
CREATE TABLE "virtualshelfcontents" (
  "shelfnumber" integer DEFAULT 0 NOT NULL,
  "biblionumber" integer DEFAULT 0 NOT NULL,
  "flags" integer,
  "dateadded" timestamp DEFAULT current_timestamp NOT NULL
);
CREATE INDEX "virtualshelfcontents_idx_biblionumber" on "virtualshelfcontents" ("biblionumber");
CREATE INDEX "virtualshelfcontents_idx_shelfnumber" on "virtualshelfcontents" ("shelfnumber");

--
-- Table: virtualshelves
--
DROP TABLE "virtualshelves" CASCADE;
CREATE TABLE "virtualshelves" (
  "shelfnumber" serial NOT NULL,
  "shelfname" character varying(255),
  "owner" character varying(80),
  "category" character varying(1),
  "sortfield" character varying(16),
  "lastmodified" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("shelfnumber")
);

--
-- Table: z3950servers
--
DROP TABLE "z3950servers" CASCADE;
CREATE TABLE "z3950servers" (
  "host" character varying(255),
  "port" integer,
  "db" character varying(255),
  "userid" character varying(255),
  "password" character varying(255),
  "name" text,
  "id" serial NOT NULL,
  "checked" smallint,
  "rank" integer,
  "syntax" character varying(80),
  "icon" text,
  "position" character varying DEFAULT 'primary' NOT NULL,
  "type" character varying DEFAULT 'zed' NOT NULL,
  "encoding" text,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: zebraqueue
--
DROP TABLE "zebraqueue" CASCADE;
CREATE TABLE "zebraqueue" (
  "id" serial NOT NULL,
  "biblio_auth_number" bigint DEFAULT 0 NOT NULL,
  "operation" character(20) DEFAULT '' NOT NULL,
  "server" character(20) DEFAULT '' NOT NULL,
  "done" integer DEFAULT 0 NOT NULL,
  "time" timestamp DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY ("id")
);

--
-- Table: branches
--
DROP TABLE "branches" CASCADE;
CREATE TABLE "branches" (
  "branchcode" character varying(10) DEFAULT '' NOT NULL,
  "branchname" text NOT NULL,
  "branchaddress1" text,
  "branchaddress2" text,
  "branchaddress3" text,
  "branchzip" character varying(25),
  "branchcity" text,
  "branchstate" text,
  "branchcountry" text,
  "branchphone" text,
  "branchfax" text,
  "branchemail" text,
  "branchurl" text,
  "issuing" smallint,
  "branchip" character varying(15),
  "branchprinter" character varying(100),
  "branchnotes" text,
  CONSTRAINT "branchcode" UNIQUE ("branchcode")
);
CREATE INDEX "branches_idx_branchcode" on "branches" ("branchcode");

--
-- Foreign Key Definitions
--

ALTER TABLE "accountlines" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "accountlines" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "accountoffsets" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbasket" ADD FOREIGN KEY ("basketgroupid")
  REFERENCES "aqbasketgroups" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbasket" ADD FOREIGN KEY ("booksellerid")
  REFERENCES "aqbooksellers" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbasket" ADD FOREIGN KEY ("contractnumber")
  REFERENCES "aqcontract" ("contractnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbasketgroups" ADD FOREIGN KEY ("booksellerid")
  REFERENCES "aqbooksellers" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbooksellers" ADD FOREIGN KEY ("invoiceprice")
  REFERENCES "currency" ("currency") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbooksellers" ADD FOREIGN KEY ("listprice")
  REFERENCES "currency" ("currency") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbudgets" ADD FOREIGN KEY ("budget_period_id")
  REFERENCES "aqbudgetperiods" ("budget_period_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqbudgets_planning" ADD FOREIGN KEY ("budget_id")
  REFERENCES "aqbudgets" ("budget_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqcontract" ADD FOREIGN KEY ("booksellerid")
  REFERENCES "aqbooksellers" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqorderbreakdown" ADD FOREIGN KEY ("bookfundid")
  REFERENCES "aqbookfund" ("bookfundid") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqorderbreakdown" ADD FOREIGN KEY ("ordernumber")
  REFERENCES "aqorders" ("ordernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqorders" ADD FOREIGN KEY ("basketno")
  REFERENCES "aqbasket" ("basketno") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "aqorders" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "auth_tag_structure" ADD FOREIGN KEY ("authtypecode")
  REFERENCES "auth_types" ("authtypecode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "biblioitems" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_attributes" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_attributes" ADD FOREIGN KEY ("code")
  REFERENCES "borrower_attribute_types" ("code") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_message_preferences" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_message_preferences" ADD FOREIGN KEY ("categorycode")
  REFERENCES "categories" ("categorycode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_message_preferences" ADD FOREIGN KEY ("message_attribute_id")
  REFERENCES "message_attributes" ("message_attribute_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_message_transport_preferences" ADD FOREIGN KEY ("borrower_message_preference_id")
  REFERENCES "borrower_message_preferences" ("borrower_message_preference_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrower_message_transport_preferences" ADD FOREIGN KEY ("message_transport_type")
  REFERENCES "message_transport_types" ("message_transport_type") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrowers" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "borrowers" ADD FOREIGN KEY ("categorycode")
  REFERENCES "categories" ("categorycode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branch_borrower_circ_rules" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branch_borrower_circ_rules" ADD FOREIGN KEY ("categorycode")
  REFERENCES "categories" ("categorycode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branch_item_rules" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branch_item_rules" ADD FOREIGN KEY ("itemtype")
  REFERENCES "itemtypes" ("itemtype") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branchrelations" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branchrelations" ADD FOREIGN KEY ("categorycode")
  REFERENCES "branchcategories" ("categorycode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branchtransfers" ADD FOREIGN KEY ("frombranch")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branchtransfers" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branchtransfers" ADD FOREIGN KEY ("tobranch")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "class_sources" ADD FOREIGN KEY ("class_sort_rule")
  REFERENCES "class_sort_rules" ("class_sort_rule") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "creator_batches" ADD FOREIGN KEY ("borrower_number")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "creator_batches" ADD FOREIGN KEY ("branch_code")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "creator_batches" ADD FOREIGN KEY ("item_number")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "default_borrower_circ_rules" ADD FOREIGN KEY ("categorycode")
  REFERENCES "categories" ("categorycode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "default_branch_circ_rules" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "default_branch_item_rules" ADD FOREIGN KEY ("itemtype")
  REFERENCES "itemtypes" ("itemtype") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "hold_fill_targets" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "hold_fill_targets" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "hold_fill_targets" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "hold_fill_targets" ADD FOREIGN KEY ("source_branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "import_biblios" ADD FOREIGN KEY ("import_record_id")
  REFERENCES "import_records" ("import_record_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "import_items" ADD FOREIGN KEY ("import_record_id")
  REFERENCES "import_records" ("import_record_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "import_record_matches" ADD FOREIGN KEY ("import_record_id")
  REFERENCES "import_records" ("import_record_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "import_records" ADD FOREIGN KEY ("import_batch_id")
  REFERENCES "import_batches" ("import_batch_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "issues" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "issues" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "items" ADD FOREIGN KEY ("biblioitemnumber")
  REFERENCES "biblioitems" ("biblioitemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "items" ADD FOREIGN KEY ("holdingbranch")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "items" ADD FOREIGN KEY ("homebranch")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "labels_batches" ADD FOREIGN KEY ("branch_code")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "labels_batches" ADD FOREIGN KEY ("item_number")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchchecks" ADD FOREIGN KEY ("matcher_id")
  REFERENCES "marc_matchers" ("matcher_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchchecks" ADD FOREIGN KEY ("source_matchpoint_id")
  REFERENCES "matchpoints" ("matchpoint_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchchecks" ADD FOREIGN KEY ("target_matchpoint_id")
  REFERENCES "matchpoints" ("matchpoint_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matcher_matchpoints" ADD FOREIGN KEY ("matcher_id")
  REFERENCES "marc_matchers" ("matcher_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matcher_matchpoints" ADD FOREIGN KEY ("matchpoint_id")
  REFERENCES "matchpoints" ("matchpoint_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchpoint_component_norms" ADD FOREIGN KEY ("matchpoint_component_id")
  REFERENCES "matchpoint_components" ("matchpoint_component_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchpoint_components" ADD FOREIGN KEY ("matchpoint_id")
  REFERENCES "matchpoints" ("matchpoint_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "matchpoints" ADD FOREIGN KEY ("matcher_id")
  REFERENCES "marc_matchers" ("matcher_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "message_queue" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "message_queue" ADD FOREIGN KEY ("message_transport_type")
  REFERENCES "message_transport_types" ("message_transport_type") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "message_transports" ADD FOREIGN KEY ("letter_module", "letter_code")
  REFERENCES "letter" ("module", "code") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "message_transports" ADD FOREIGN KEY ("message_attribute_id")
  REFERENCES "message_attributes" ("message_attribute_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "message_transports" ADD FOREIGN KEY ("message_transport_type")
  REFERENCES "message_transport_types" ("message_transport_type") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "old_issues" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "old_issues" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "old_reserves" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "old_reserves" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "old_reserves" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "patroncards" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "permissions" ADD FOREIGN KEY ("module_bit")
  REFERENCES "userflags" ("bit") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "reserves" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "reserves" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "reserves" ADD FOREIGN KEY ("branchcode")
  REFERENCES "branches" ("branchcode") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "reserves" ADD FOREIGN KEY ("itemnumber")
  REFERENCES "items" ("itemnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "serialitems" ADD FOREIGN KEY ("serialid")
  REFERENCES "serial" ("serialid") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "subscriptionroutinglist" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "subscriptionroutinglist" ADD FOREIGN KEY ("subscriptionid")
  REFERENCES "subscription" ("subscriptionid") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "tags_all" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "tags_all" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "tags_approval" ADD FOREIGN KEY ("approved_by")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "tags_index" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "tags_index" ADD FOREIGN KEY ("term")
  REFERENCES "tags_approval" ("term") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "user_permissions" ADD FOREIGN KEY ("borrowernumber")
  REFERENCES "borrowers" ("borrowernumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "user_permissions" ADD FOREIGN KEY ("module_bit", "code")
  REFERENCES "permissions" ("module_bit", "code") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "virtualshelfcontents" ADD FOREIGN KEY ("biblionumber")
  REFERENCES "biblio" ("biblionumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "virtualshelfcontents" ADD FOREIGN KEY ("shelfnumber")
  REFERENCES "virtualshelves" ("shelfnumber") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

ALTER TABLE "branches" ADD FOREIGN KEY ("branchcode")
  REFERENCES "default_branch_circ_rules" ("branchcode") DEFERRABLE;

