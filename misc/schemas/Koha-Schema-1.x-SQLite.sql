-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Jun 10 12:39:32 2011
-- 

BEGIN TRANSACTION;

--
-- Table: accountlines
--
DROP TABLE accountlines;

CREATE TABLE accountlines (
  borrowernumber integer NOT NULL DEFAULT 0,
  accountno smallint NOT NULL DEFAULT 0,
  itemnumber integer,
  date date,
  amount decimal(28,6),
  description mediumtext,
  dispute mediumtext,
  accounttype varchar(5),
  amountoutstanding decimal(28,6),
  lastincrement decimal(28,6),
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  notify_id integer NOT NULL DEFAULT 0,
  notify_level integer NOT NULL DEFAULT 0,
  note text,
  manager_id integer
);

CREATE INDEX accountlines_idx_borrowernumber ON accountlines (borrowernumber);

CREATE INDEX accountlines_idx_itemnumber ON accountlines (itemnumber);

--
-- Table: accountoffsets
--
DROP TABLE accountoffsets;

CREATE TABLE accountoffsets (
  borrowernumber integer NOT NULL DEFAULT 0,
  accountno smallint NOT NULL DEFAULT 0,
  offsetaccount smallint NOT NULL DEFAULT 0,
  offsetamount decimal(28,6),
  timestamp timestamp NOT NULL DEFAULT current_timestamp
);

CREATE INDEX accountoffsets_idx_borrowernumber ON accountoffsets (borrowernumber);

--
-- Table: action_logs
--
DROP TABLE action_logs;

CREATE TABLE action_logs (
  action_id INTEGER PRIMARY KEY NOT NULL,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  user integer NOT NULL DEFAULT 0,
  module text,
  action text,
  object integer,
  info text
);

--
-- Table: alert
--
DROP TABLE alert;

CREATE TABLE alert (
  alertid INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer NOT NULL DEFAULT 0,
  type varchar(10) NOT NULL DEFAULT '',
  externalid varchar(20) NOT NULL DEFAULT ''
);

--
-- Table: aqbasket
--
DROP TABLE aqbasket;

CREATE TABLE aqbasket (
  basketno INTEGER PRIMARY KEY NOT NULL,
  basketname varchar(50),
  note mediumtext,
  booksellernote mediumtext,
  contractnumber integer,
  creationdate date,
  closedate date,
  booksellerid integer NOT NULL DEFAULT 1,
  authorisedby varchar(10),
  booksellerinvoicenumber mediumtext,
  basketgroupid integer
);

CREATE INDEX aqbasket_idx_basketgroupid ON aqbasket (basketgroupid);

CREATE INDEX aqbasket_idx_booksellerid ON aqbasket (booksellerid);

CREATE INDEX aqbasket_idx_contractnumber ON aqbasket (contractnumber);

--
-- Table: aqbasketgroups
--
DROP TABLE aqbasketgroups;

CREATE TABLE aqbasketgroups (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar(50),
  closed tinyint,
  booksellerid integer NOT NULL,
  deliveryplace varchar(10),
  freedeliveryplace text,
  deliverycomment varchar(255),
  billingplace varchar(10) NOT NULL
);

CREATE INDEX aqbasketgroups_idx_booksellerid ON aqbasketgroups (booksellerid);

--
-- Table: aqbookfund
--
DROP TABLE aqbookfund;

CREATE TABLE aqbookfund (
  bookfundid varchar(10) NOT NULL DEFAULT '',
  bookfundname mediumtext,
  bookfundgroup varchar(5),
  branchcode varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (bookfundid, branchcode)
);

--
-- Table: aqbooksellers
--
DROP TABLE aqbooksellers;

CREATE TABLE aqbooksellers (
  id INTEGER PRIMARY KEY NOT NULL,
  name mediumtext NOT NULL,
  address1 mediumtext,
  address2 mediumtext,
  address3 mediumtext,
  address4 mediumtext,
  phone varchar(30),
  accountnumber mediumtext,
  othersupplier mediumtext,
  currency varchar(3) NOT NULL DEFAULT '',
  booksellerfax mediumtext,
  notes mediumtext,
  bookselleremail mediumtext,
  booksellerurl mediumtext,
  contact varchar(100),
  postal mediumtext,
  url varchar(255),
  contpos varchar(100),
  contphone varchar(100),
  contfax varchar(100),
  contaltphone varchar(100),
  contemail varchar(100),
  contnotes mediumtext,
  active tinyint,
  listprice varchar(10),
  invoiceprice varchar(10),
  gstreg tinyint,
  listincgst tinyint,
  invoiceincgst tinyint,
  discount float(6,4),
  fax varchar(50),
  gstrate decimal(6,4)
);

CREATE INDEX aqbooksellers_idx_invoiceprice ON aqbooksellers (invoiceprice);

CREATE INDEX aqbooksellers_idx_listprice ON aqbooksellers (listprice);

--
-- Table: aqbudgetperiods
--
DROP TABLE aqbudgetperiods;

CREATE TABLE aqbudgetperiods (
  budget_period_id INTEGER PRIMARY KEY NOT NULL,
  budget_period_startdate date NOT NULL,
  budget_period_enddate date NOT NULL,
  budget_period_active tinyint DEFAULT 0,
  budget_period_description mediumtext,
  budget_period_locked tinyint,
  sort1_authcat varchar(10),
  sort2_authcat varchar(10),
  budget_period_total decimal(28,6)
);

--
-- Table: aqbudgets
--
DROP TABLE aqbudgets;

CREATE TABLE aqbudgets (
  budget_code varchar(30),
  budget_amount decimal(28,6) NOT NULL DEFAULT 0.000000,
  budget_id INTEGER PRIMARY KEY NOT NULL,
  budget_branchcode varchar(10),
  budget_parent_id integer,
  budget_name varchar(80),
  budget_encumb decimal(28,6) DEFAULT 0.000000,
  budget_expend decimal(28,6) DEFAULT 0.000000,
  budget_notes mediumtext,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  budget_period_id integer,
  sort1_authcat varchar(80),
  sort2_authcat varchar(80),
  budget_owner_id integer,
  budget_permission integer DEFAULT 0
);

CREATE INDEX aqbudgets_idx_budget_period_id ON aqbudgets (budget_period_id);

--
-- Table: aqbudgets_planning
--
DROP TABLE aqbudgets_planning;

CREATE TABLE aqbudgets_planning (
  plan_id INTEGER PRIMARY KEY NOT NULL,
  budget_id integer NOT NULL,
  budget_period_id integer NOT NULL,
  estimated_amount decimal(28,6),
  authcat varchar(30) NOT NULL,
  authvalue varchar(30) NOT NULL,
  display tinyint DEFAULT 1
);

CREATE INDEX aqbudgets_planning_idx_budget_id ON aqbudgets_planning (budget_id);

--
-- Table: aqcontract
--
DROP TABLE aqcontract;

CREATE TABLE aqcontract (
  contractnumber INTEGER PRIMARY KEY NOT NULL,
  contractstartdate date,
  contractenddate date,
  contractname varchar(50),
  contractdescription mediumtext,
  booksellerid integer NOT NULL
);

CREATE INDEX aqcontract_idx_booksellerid ON aqcontract (booksellerid);

--
-- Table: aqorderbreakdown
--
DROP TABLE aqorderbreakdown;

CREATE TABLE aqorderbreakdown (
  ordernumber integer,
  linenumber integer,
  branchcode varchar(10),
  bookfundid varchar(10) NOT NULL DEFAULT '',
  allocation smallint
);

CREATE INDEX aqorderbreakdown_idx_bookfundid ON aqorderbreakdown (bookfundid);

CREATE INDEX aqorderbreakdown_idx_ordernumber ON aqorderbreakdown (ordernumber);

--
-- Table: aqorderdelivery
--
DROP TABLE aqorderdelivery;

CREATE TABLE aqorderdelivery (
  ordernumber date,
  deliverynumber smallint NOT NULL DEFAULT 0,
  deliverydate varchar(18),
  qtydelivered smallint,
  deliverycomments mediumtext
);

--
-- Table: aqorders
--
DROP TABLE aqorders;

CREATE TABLE aqorders (
  ordernumber INTEGER PRIMARY KEY NOT NULL,
  biblionumber integer,
  entrydate date,
  quantity smallint,
  currency varchar(3),
  listprice decimal(28,6),
  totalamount decimal(28,6),
  datereceived date,
  booksellerinvoicenumber mediumtext,
  freight decimal(28,6),
  unitprice decimal(28,6),
  quantityreceived smallint NOT NULL DEFAULT 0,
  cancelledby varchar(10),
  datecancellationprinted date,
  notes mediumtext,
  supplierreference mediumtext,
  purchaseordernumber mediumtext,
  subscription tinyint,
  serialid varchar(30),
  basketno integer,
  biblioitemnumber integer,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  rrp decimal(13,2),
  ecost decimal(13,2),
  gst decimal(13,2),
  budgetdate date,
  sort1 varchar(80),
  sort2 varchar(80),
  uncertainprice tinyint,
  budget_id integer NOT NULL,
  budgetgroup_id integer NOT NULL,
  sort1_authcat varchar(10),
  sort2_authcat varchar(10)
);

CREATE INDEX aqorders_idx_basketno ON aqorders (basketno);

CREATE INDEX aqorders_idx_biblionumber ON aqorders (biblionumber);

--
-- Table: aqorders_items
--
DROP TABLE aqorders_items;

CREATE TABLE aqorders_items (
  ordernumber integer NOT NULL,
  itemnumber INTEGER PRIMARY KEY NOT NULL,
  timestamp timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: auth_header
--
DROP TABLE auth_header;

CREATE TABLE auth_header (
  authid INTEGER PRIMARY KEY NOT NULL,
  authtypecode varchar(10) NOT NULL DEFAULT '',
  datecreated date,
  datemodified date,
  origincode varchar(20),
  authtrees mediumtext,
  marc blob,
  linkid bigint,
  marcxml longtext NOT NULL
);

--
-- Table: auth_subfield_structure
--
DROP TABLE auth_subfield_structure;

CREATE TABLE auth_subfield_structure (
  authtypecode varchar(10) NOT NULL DEFAULT '',
  tagfield varchar(3) NOT NULL DEFAULT '',
  tagsubfield varchar(1) NOT NULL DEFAULT '',
  liblibrarian varchar(255) NOT NULL DEFAULT '',
  libopac varchar(255) NOT NULL DEFAULT '',
  repeatable tinyint NOT NULL DEFAULT 0,
  mandatory tinyint NOT NULL DEFAULT 0,
  tab tinyint,
  authorised_value varchar(10),
  value_builder varchar(80),
  seealso varchar(255),
  isurl tinyint,
  hidden tinyint NOT NULL DEFAULT 0,
  linkid tinyint NOT NULL DEFAULT 0,
  kohafield varchar(45) DEFAULT '',
  frameworkcode varchar(10),
  PRIMARY KEY (authtypecode, tagfield, tagsubfield)
);

--
-- Table: auth_tag_structure
--
DROP TABLE auth_tag_structure;

CREATE TABLE auth_tag_structure (
  authtypecode varchar(10) NOT NULL DEFAULT '',
  tagfield varchar(3) NOT NULL DEFAULT '',
  liblibrarian varchar(255) NOT NULL DEFAULT '',
  libopac varchar(255) NOT NULL DEFAULT '',
  repeatable tinyint NOT NULL DEFAULT 0,
  mandatory tinyint NOT NULL DEFAULT 0,
  authorised_value varchar(10),
  PRIMARY KEY (authtypecode, tagfield)
);

CREATE INDEX auth_tag_structure_idx_authtypecode ON auth_tag_structure (authtypecode);

--
-- Table: auth_types
--
DROP TABLE auth_types;

CREATE TABLE auth_types (
  authtypecode varchar(10) NOT NULL DEFAULT '',
  authtypetext varchar(255) NOT NULL DEFAULT '',
  auth_tag_to_report varchar(3) NOT NULL DEFAULT '',
  summary mediumtext NOT NULL,
  PRIMARY KEY (authtypecode)
);

--
-- Table: authorised_values
--
DROP TABLE authorised_values;

CREATE TABLE authorised_values (
  id INTEGER PRIMARY KEY NOT NULL,
  category varchar(10) NOT NULL DEFAULT '',
  authorised_value varchar(80) NOT NULL DEFAULT '',
  lib varchar(80),
  lib_opac varchar(80),
  imageurl varchar(200)
);

--
-- Table: biblio
--
DROP TABLE biblio;

CREATE TABLE biblio (
  biblionumber INTEGER PRIMARY KEY NOT NULL,
  frameworkcode varchar(4) NOT NULL DEFAULT '',
  author mediumtext,
  title mediumtext,
  unititle mediumtext,
  notes mediumtext,
  serial tinyint,
  seriestitle mediumtext,
  copyrightdate smallint,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  datecreated date NOT NULL,
  abstract mediumtext
);

--
-- Table: biblio_framework
--
DROP TABLE biblio_framework;

CREATE TABLE biblio_framework (
  frameworkcode varchar(4) NOT NULL DEFAULT '',
  frameworktext varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (frameworkcode)
);

--
-- Table: biblioitems
--
DROP TABLE biblioitems;

CREATE TABLE biblioitems (
  biblioitemnumber INTEGER PRIMARY KEY NOT NULL,
  biblionumber integer NOT NULL DEFAULT 0,
  volume mediumtext,
  number mediumtext,
  itemtype varchar(10),
  isbn varchar(30),
  issn varchar(9),
  publicationyear text,
  publishercode varchar(255),
  volumedate date,
  volumedesc text,
  collectiontitle mediumtext,
  collectionissn text,
  collectionvolume mediumtext,
  editionstatement text,
  editionresponsibility text,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  illus varchar(255),
  pages varchar(255),
  notes mediumtext,
  size varchar(255),
  place varchar(255),
  lccn varchar(25),
  marc longblob,
  url varchar(255),
  cn_source varchar(10),
  cn_class varchar(30),
  cn_item varchar(10),
  cn_suffix varchar(10),
  cn_sort varchar(30),
  totalissues integer,
  marcxml longtext NOT NULL
);

CREATE INDEX biblioitems_idx_biblionumber ON biblioitems (biblionumber);

--
-- Table: borrower_attribute_types
--
DROP TABLE borrower_attribute_types;

CREATE TABLE borrower_attribute_types (
  code varchar(10) NOT NULL,
  description varchar(255) NOT NULL,
  repeatable tinyint NOT NULL DEFAULT 0,
  unique_id tinyint NOT NULL DEFAULT 0,
  opac_display tinyint NOT NULL DEFAULT 0,
  password_allowed tinyint NOT NULL DEFAULT 0,
  staff_searchable tinyint NOT NULL DEFAULT 0,
  authorised_value_category varchar(10),
  PRIMARY KEY (code)
);

--
-- Table: borrower_attributes
--
DROP TABLE borrower_attributes;

CREATE TABLE borrower_attributes (
  borrowernumber integer NOT NULL,
  code varchar(10) NOT NULL,
  attribute varchar(64),
  password varchar(64)
);

CREATE INDEX borrower_attributes_idx_borrowernumber ON borrower_attributes (borrowernumber);

CREATE INDEX borrower_attributes_idx_code ON borrower_attributes (code);

--
-- Table: borrower_message_preferences
--
DROP TABLE borrower_message_preferences;

CREATE TABLE borrower_message_preferences (
  borrower_message_preference_id INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer,
  categorycode varchar(10),
  message_attribute_id integer DEFAULT 0,
  days_in_advance integer DEFAULT 0,
  wants_digest tinyint NOT NULL DEFAULT 0
);

CREATE INDEX borrower_message_preferences_idx_borrowernumber ON borrower_message_preferences (borrowernumber);

CREATE INDEX borrower_message_preferences_idx_categorycode ON borrower_message_preferences (categorycode);

CREATE INDEX borrower_message_preferences_idx_message_attribute_id ON borrower_message_preferences (message_attribute_id);

--
-- Table: borrower_message_transport_preferences
--
DROP TABLE borrower_message_transport_preferences;

CREATE TABLE borrower_message_transport_preferences (
  borrower_message_preference_id integer NOT NULL DEFAULT 0,
  message_transport_type varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (borrower_message_preference_id, message_transport_type)
);

CREATE INDEX borrower_message_transport_preferences_idx_borrower_message_preference_id ON borrower_message_transport_preferences (borrower_message_preference_id);

CREATE INDEX borrower_message_transport_preferences_idx_message_transport_type ON borrower_message_transport_preferences (message_transport_type);

--
-- Table: borrowers
--
DROP TABLE borrowers;

CREATE TABLE borrowers (
  borrowernumber INTEGER PRIMARY KEY NOT NULL,
  cardnumber varchar(16),
  surname mediumtext NOT NULL,
  firstname text,
  title mediumtext,
  othernames mediumtext,
  initials text,
  streetnumber varchar(10),
  streettype varchar(50),
  address mediumtext NOT NULL,
  address2 text,
  city mediumtext NOT NULL,
  state mediumtext,
  zipcode varchar(25),
  country text,
  email mediumtext,
  phone text,
  mobile varchar(50),
  fax mediumtext,
  emailpro text,
  phonepro text,
  b_streetnumber varchar(10),
  b_streettype varchar(50),
  b_address varchar(100),
  b_address2 text,
  b_city mediumtext,
  b_state mediumtext,
  b_zipcode varchar(25),
  b_country text,
  b_email text,
  b_phone mediumtext,
  dateofbirth date,
  branchcode varchar(10) NOT NULL DEFAULT '',
  categorycode varchar(10) NOT NULL DEFAULT '',
  dateenrolled date,
  dateexpiry date,
  gonenoaddress tinyint,
  lost tinyint,
  debarred tinyint,
  contactname mediumtext,
  contactfirstname text,
  contacttitle text,
  guarantorid integer,
  borrowernotes mediumtext,
  relationship varchar(100),
  ethnicity varchar(50),
  ethnotes varchar(255),
  sex varchar(1),
  password varchar(30),
  flags integer,
  userid varchar(30),
  opacnote mediumtext,
  contactnote varchar(255),
  sort1 varchar(80),
  sort2 varchar(80),
  altcontactfirstname varchar(255),
  altcontactsurname varchar(255),
  altcontactaddress1 varchar(255),
  altcontactaddress2 varchar(255),
  altcontactaddress3 varchar(255),
  altcontactstate mediumtext,
  altcontactzipcode varchar(50),
  altcontactcountry text,
  altcontactphone varchar(50),
  smsalertnumber varchar(50),
  disable_reading_history tinyint,
  privacy integer NOT NULL DEFAULT 1
);

CREATE INDEX borrowers_idx_branchcode ON borrowers (branchcode);

CREATE INDEX borrowers_idx_categorycode ON borrowers (categorycode);

CREATE UNIQUE INDEX cardnumber ON borrowers (cardnumber);

--
-- Table: branch_borrower_circ_rules
--
DROP TABLE branch_borrower_circ_rules;

CREATE TABLE branch_borrower_circ_rules (
  branchcode varchar(10) NOT NULL,
  categorycode varchar(10) NOT NULL,
  maxissueqty integer,
  PRIMARY KEY (categorycode, branchcode)
);

CREATE INDEX branch_borrower_circ_rules_idx_branchcode ON branch_borrower_circ_rules (branchcode);

CREATE INDEX branch_borrower_circ_rules_idx_categorycode ON branch_borrower_circ_rules (categorycode);

--
-- Table: branch_item_rules
--
DROP TABLE branch_item_rules;

CREATE TABLE branch_item_rules (
  branchcode varchar(10) NOT NULL,
  itemtype varchar(10) NOT NULL,
  holdallowed tinyint,
  PRIMARY KEY (itemtype, branchcode)
);

CREATE INDEX branch_item_rules_idx_branchcode ON branch_item_rules (branchcode);

CREATE INDEX branch_item_rules_idx_itemtype ON branch_item_rules (itemtype);

--
-- Table: branch_transfer_limits
--
DROP TABLE branch_transfer_limits;

CREATE TABLE branch_transfer_limits (
  limitid INTEGER PRIMARY KEY NOT NULL,
  tobranch varchar(10) NOT NULL,
  frombranch varchar(10) NOT NULL,
  itemtype varchar(10),
  ccode varchar(10)
);

--
-- Table: branchcategories
--
DROP TABLE branchcategories;

CREATE TABLE branchcategories (
  categorycode varchar(10) NOT NULL DEFAULT '',
  categoryname varchar(32),
  codedescription mediumtext,
  categorytype varchar(16),
  PRIMARY KEY (categorycode)
);

--
-- Table: branchrelations
--
DROP TABLE branchrelations;

CREATE TABLE branchrelations (
  branchcode varchar(10) NOT NULL DEFAULT '',
  categorycode varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (branchcode, categorycode)
);

CREATE INDEX branchrelations_idx_branchcode ON branchrelations (branchcode);

CREATE INDEX branchrelations_idx_categorycode ON branchrelations (categorycode);

--
-- Table: branchtransfers
--
DROP TABLE branchtransfers;

CREATE TABLE branchtransfers (
  itemnumber integer NOT NULL DEFAULT 0,
  datesent datetime,
  frombranch varchar(10) NOT NULL DEFAULT '',
  datearrived datetime,
  tobranch varchar(10) NOT NULL DEFAULT '',
  comments mediumtext
);

CREATE INDEX branchtransfers_idx_frombranch ON branchtransfers (frombranch);

CREATE INDEX branchtransfers_idx_itemnumber ON branchtransfers (itemnumber);

CREATE INDEX branchtransfers_idx_tobranch ON branchtransfers (tobranch);

--
-- Table: browser
--
DROP TABLE browser;

CREATE TABLE browser (
  level integer NOT NULL,
  classification varchar(20) NOT NULL,
  description varchar(255) NOT NULL,
  number bigint NOT NULL,
  endnode tinyint NOT NULL
);

--
-- Table: categories
--
DROP TABLE categories;

CREATE TABLE categories (
  categorycode varchar(10) NOT NULL DEFAULT '',
  description mediumtext,
  enrolmentperiod smallint,
  enrolmentperioddate date,
  upperagelimit smallint,
  dateofbirthrequired tinyint,
  finetype varchar(30),
  bulk tinyint,
  enrolmentfee decimal(28,6),
  overduenoticerequired tinyint,
  issuelimit smallint,
  reservefee decimal(28,6),
  hidelostitems tinyint NOT NULL DEFAULT 0,
  category_type varchar(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (categorycode)
);

--
-- Table: cities
--
DROP TABLE cities;

CREATE TABLE cities (
  cityid INTEGER PRIMARY KEY NOT NULL,
  city_name varchar(100) NOT NULL DEFAULT '',
  city_zipcode varchar(20)
);

--
-- Table: class_sort_rules
--
DROP TABLE class_sort_rules;

CREATE TABLE class_sort_rules (
  class_sort_rule varchar(10) NOT NULL DEFAULT '',
  description mediumtext,
  sort_routine varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (class_sort_rule)
);

--
-- Table: class_sources
--
DROP TABLE class_sources;

CREATE TABLE class_sources (
  cn_source varchar(10) NOT NULL DEFAULT '',
  description mediumtext,
  used tinyint NOT NULL DEFAULT 0,
  class_sort_rule varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (cn_source)
);

CREATE INDEX class_sources_idx_class_sort_rule ON class_sources (class_sort_rule);

--
-- Table: collections
--
DROP TABLE collections;

CREATE TABLE collections (
  colid INTEGER PRIMARY KEY NOT NULL,
  coltitle varchar(100) NOT NULL DEFAULT '',
  coldesc text NOT NULL,
  colbranchcode varchar(4)
);

--
-- Table: collections_tracking
--
DROP TABLE collections_tracking;

CREATE TABLE collections_tracking (
  ctid INTEGER PRIMARY KEY NOT NULL,
  colid integer NOT NULL DEFAULT 0,
  itemnumber integer NOT NULL DEFAULT 0
);

--
-- Table: creator_batches
--
DROP TABLE creator_batches;

CREATE TABLE creator_batches (
  label_id INTEGER PRIMARY KEY NOT NULL,
  batch_id integer NOT NULL DEFAULT 1,
  item_number integer,
  borrower_number integer,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  branch_code varchar(10) NOT NULL DEFAULT 'NB',
  creator char(15) NOT NULL DEFAULT 'Labels'
);

CREATE INDEX creator_batches_idx_borrower_number ON creator_batches (borrower_number);

CREATE INDEX creator_batches_idx_branch_code ON creator_batches (branch_code);

CREATE INDEX creator_batches_idx_item_number ON creator_batches (item_number);

--
-- Table: creator_images
--
DROP TABLE creator_images;

CREATE TABLE creator_images (
  image_id INTEGER PRIMARY KEY NOT NULL,
  imagefile mediumblob,
  image_name char(20) NOT NULL DEFAULT 'DEFAULT'
);

CREATE UNIQUE INDEX image_name_index ON creator_images (image_name);

--
-- Table: creator_layouts
--
DROP TABLE creator_layouts;

CREATE TABLE creator_layouts (
  layout_id INTEGER PRIMARY KEY NOT NULL,
  barcode_type char(100) NOT NULL DEFAULT 'CODE39',
  start_label integer NOT NULL DEFAULT 1,
  printing_type char(32) NOT NULL DEFAULT 'BAR',
  layout_name char(20) NOT NULL DEFAULT 'DEFAULT',
  guidebox integer DEFAULT 0,
  font char(10) NOT NULL DEFAULT 'TR',
  font_size integer NOT NULL DEFAULT 10,
  units char(20) NOT NULL DEFAULT 'POINT',
  callnum_split integer DEFAULT 0,
  text_justify char(1) NOT NULL DEFAULT 'L',
  format_string varchar(210) NOT NULL DEFAULT 'barcode',
  layout_xml text NOT NULL,
  creator char(15) NOT NULL DEFAULT 'Labels'
);

--
-- Table: creator_templates
--
DROP TABLE creator_templates;

CREATE TABLE creator_templates (
  template_id INTEGER PRIMARY KEY NOT NULL,
  profile_id integer,
  template_code char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  template_desc char(100) NOT NULL DEFAULT 'Default description',
  page_width float NOT NULL DEFAULT 0,
  page_height float NOT NULL DEFAULT 0,
  label_width float NOT NULL DEFAULT 0,
  label_height float NOT NULL DEFAULT 0,
  top_text_margin float NOT NULL DEFAULT 0,
  left_text_margin float NOT NULL DEFAULT 0,
  top_margin float NOT NULL DEFAULT 0,
  left_margin float NOT NULL DEFAULT 0,
  cols integer NOT NULL DEFAULT 0,
  rows integer NOT NULL DEFAULT 0,
  col_gap float NOT NULL DEFAULT 0,
  row_gap float NOT NULL DEFAULT 0,
  units char(20) NOT NULL DEFAULT 'POINT',
  creator char(15) NOT NULL DEFAULT 'Labels'
);

--
-- Table: currency
--
DROP TABLE currency;

CREATE TABLE currency (
  currency varchar(10) NOT NULL DEFAULT '',
  symbol varchar(5),
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  rate float(15,5),
  active tinyint,
  PRIMARY KEY (currency)
);

--
-- Table: default_borrower_circ_rules
--
DROP TABLE default_borrower_circ_rules;

CREATE TABLE default_borrower_circ_rules (
  categorycode varchar(10) NOT NULL,
  maxissueqty integer,
  PRIMARY KEY (categorycode)
);

--
-- Table: default_branch_circ_rules
--
DROP TABLE default_branch_circ_rules;

CREATE TABLE default_branch_circ_rules (
  branchcode varchar(10) NOT NULL,
  maxissueqty integer,
  holdallowed tinyint,
  PRIMARY KEY (branchcode)
);

--
-- Table: default_branch_item_rules
--
DROP TABLE default_branch_item_rules;

CREATE TABLE default_branch_item_rules (
  itemtype varchar(10) NOT NULL,
  holdallowed tinyint,
  PRIMARY KEY (itemtype)
);

--
-- Table: default_circ_rules
--
DROP TABLE default_circ_rules;

CREATE TABLE default_circ_rules (
  singleton enum NOT NULL DEFAULT 'singleton',
  maxissueqty integer,
  holdallowed integer,
  PRIMARY KEY (singleton)
);

--
-- Table: deletedbiblio
--
DROP TABLE deletedbiblio;

CREATE TABLE deletedbiblio (
  biblionumber INTEGER PRIMARY KEY NOT NULL DEFAULT 0,
  frameworkcode varchar(4) NOT NULL DEFAULT '',
  author mediumtext,
  title mediumtext,
  unititle mediumtext,
  notes mediumtext,
  serial tinyint,
  seriestitle mediumtext,
  copyrightdate smallint,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  datecreated date NOT NULL,
  abstract mediumtext
);

--
-- Table: deletedbiblioitems
--
DROP TABLE deletedbiblioitems;

CREATE TABLE deletedbiblioitems (
  biblioitemnumber INTEGER PRIMARY KEY NOT NULL DEFAULT 0,
  biblionumber integer NOT NULL DEFAULT 0,
  volume mediumtext,
  number mediumtext,
  itemtype varchar(10),
  isbn varchar(30),
  issn varchar(9),
  publicationyear text,
  publishercode varchar(255),
  volumedate date,
  volumedesc text,
  collectiontitle mediumtext,
  collectionissn text,
  collectionvolume mediumtext,
  editionstatement text,
  editionresponsibility text,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  illus varchar(255),
  pages varchar(255),
  notes mediumtext,
  size varchar(255),
  place varchar(255),
  lccn varchar(25),
  marc longblob,
  url varchar(255),
  cn_source varchar(10),
  cn_class varchar(30),
  cn_item varchar(10),
  cn_suffix varchar(10),
  cn_sort varchar(30),
  totalissues integer,
  marcxml longtext NOT NULL
);

--
-- Table: deletedborrowers
--
DROP TABLE deletedborrowers;

CREATE TABLE deletedborrowers (
  borrowernumber integer NOT NULL DEFAULT 0,
  cardnumber varchar(16),
  surname mediumtext NOT NULL,
  firstname text,
  title mediumtext,
  othernames mediumtext,
  initials text,
  streetnumber varchar(10),
  streettype varchar(50),
  address mediumtext NOT NULL,
  address2 text,
  city mediumtext NOT NULL,
  state mediumtext,
  zipcode varchar(25),
  country text,
  email mediumtext,
  phone text,
  mobile varchar(50),
  fax mediumtext,
  emailpro text,
  phonepro text,
  b_streetnumber varchar(10),
  b_streettype varchar(50),
  b_address varchar(100),
  b_address2 text,
  b_city mediumtext,
  b_state mediumtext,
  b_zipcode varchar(25),
  b_country text,
  b_email text,
  b_phone mediumtext,
  dateofbirth date,
  branchcode varchar(10) NOT NULL DEFAULT '',
  categorycode varchar(10),
  dateenrolled date,
  dateexpiry date,
  gonenoaddress tinyint,
  lost tinyint,
  debarred tinyint,
  contactname mediumtext,
  contactfirstname text,
  contacttitle text,
  guarantorid integer,
  borrowernotes mediumtext,
  relationship varchar(100),
  ethnicity varchar(50),
  ethnotes varchar(255),
  sex varchar(1),
  password varchar(30),
  flags integer,
  userid varchar(30),
  opacnote mediumtext,
  contactnote varchar(255),
  sort1 varchar(80),
  sort2 varchar(80),
  altcontactfirstname varchar(255),
  altcontactsurname varchar(255),
  altcontactaddress1 varchar(255),
  altcontactaddress2 varchar(255),
  altcontactaddress3 varchar(255),
  altcontactstate mediumtext,
  altcontactzipcode varchar(50),
  altcontactcountry text,
  altcontactphone varchar(50),
  smsalertnumber varchar(50),
  privacy integer
);

--
-- Table: deleteditems
--
DROP TABLE deleteditems;

CREATE TABLE deleteditems (
  itemnumber INTEGER PRIMARY KEY NOT NULL DEFAULT 0,
  biblionumber integer NOT NULL DEFAULT 0,
  biblioitemnumber integer NOT NULL DEFAULT 0,
  barcode varchar(20),
  dateaccessioned date,
  booksellerid mediumtext,
  homebranch varchar(10),
  price decimal(8,2),
  replacementprice decimal(8,2),
  replacementpricedate date,
  datelastborrowed date,
  datelastseen date,
  stack tinyint,
  notforloan tinyint NOT NULL DEFAULT 0,
  damaged tinyint NOT NULL DEFAULT 0,
  itemlost tinyint NOT NULL DEFAULT 0,
  wthdrawn tinyint NOT NULL DEFAULT 0,
  itemcallnumber varchar(255),
  issues smallint,
  renewals smallint,
  reserves smallint,
  restricted tinyint,
  itemnotes mediumtext,
  holdingbranch varchar(10),
  paidfor mediumtext,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  location varchar(80),
  permanent_location varchar(80),
  onloan date,
  cn_source varchar(10),
  cn_sort varchar(30),
  ccode varchar(10),
  materials varchar(10),
  uri varchar(255),
  itype varchar(10),
  more_subfields_xml longtext,
  enumchron text,
  copynumber varchar(32),
  marc longblob,
  stocknumber varchar(32)
);

CREATE UNIQUE INDEX deleteditemsstocknumberidx ON deleteditems (stocknumber);

--
-- Table: ethnicity
--
DROP TABLE ethnicity;

CREATE TABLE ethnicity (
  code varchar(10) NOT NULL DEFAULT '',
  name varchar(255),
  PRIMARY KEY (code)
);

--
-- Table: export_format
--
DROP TABLE export_format;

CREATE TABLE export_format (
  export_format_id INTEGER PRIMARY KEY NOT NULL,
  profile varchar(255) NOT NULL,
  description mediumtext NOT NULL,
  marcfields mediumtext NOT NULL,
  csv_separator varchar(2) NOT NULL,
  field_separator varchar(2) NOT NULL,
  subfield_separator varchar(2) NOT NULL,
  encoding varchar(255) NOT NULL
);

--
-- Table: fieldmapping
--
DROP TABLE fieldmapping;

CREATE TABLE fieldmapping (
  id INTEGER PRIMARY KEY NOT NULL,
  field varchar(255) NOT NULL,
  frameworkcode char(4) NOT NULL DEFAULT '',
  fieldcode char(3) NOT NULL,
  subfieldcode char(1) NOT NULL
);

--
-- Table: hold_fill_targets
--
DROP TABLE hold_fill_targets;

CREATE TABLE hold_fill_targets (
  borrowernumber integer NOT NULL,
  biblionumber integer NOT NULL,
  itemnumber INTEGER PRIMARY KEY NOT NULL,
  source_branchcode varchar(10),
  item_level_request tinyint NOT NULL DEFAULT 0
);

CREATE INDEX hold_fill_targets_idx_biblionumber ON hold_fill_targets (biblionumber);

CREATE INDEX hold_fill_targets_idx_borrowernumber ON hold_fill_targets (borrowernumber);

CREATE INDEX hold_fill_targets_idx_source_branchcode ON hold_fill_targets (source_branchcode);

--
-- Table: import_batches
--
DROP TABLE import_batches;

CREATE TABLE import_batches (
  import_batch_id INTEGER PRIMARY KEY NOT NULL,
  matcher_id integer,
  template_id integer,
  branchcode varchar(10),
  num_biblios integer NOT NULL DEFAULT 0,
  num_items integer NOT NULL DEFAULT 0,
  upload_timestamp timestamp NOT NULL DEFAULT current_timestamp,
  overlay_action enum NOT NULL DEFAULT 'create_new',
  nomatch_action enum NOT NULL DEFAULT 'create_new',
  item_action enum NOT NULL DEFAULT 'always_add',
  import_status enum NOT NULL DEFAULT 'staging',
  batch_type enum NOT NULL DEFAULT 'batch',
  file_name varchar(100),
  comments mediumtext
);

--
-- Table: import_biblios
--
DROP TABLE import_biblios;

CREATE TABLE import_biblios (
  import_record_id integer NOT NULL,
  matched_biblionumber integer,
  control_number varchar(25),
  original_source varchar(25),
  title varchar(128),
  author varchar(80),
  isbn varchar(30),
  issn varchar(9),
  has_items tinyint NOT NULL DEFAULT 0
);

CREATE INDEX import_biblios_idx_import_record_id ON import_biblios (import_record_id);

--
-- Table: import_items
--
DROP TABLE import_items;

CREATE TABLE import_items (
  import_items_id INTEGER PRIMARY KEY NOT NULL,
  import_record_id integer NOT NULL,
  itemnumber integer,
  branchcode varchar(10),
  status enum NOT NULL DEFAULT 'staged',
  marcxml longtext NOT NULL,
  import_error mediumtext
);

CREATE INDEX import_items_idx_import_record_id ON import_items (import_record_id);

--
-- Table: import_record_matches
--
DROP TABLE import_record_matches;

CREATE TABLE import_record_matches (
  import_record_id integer NOT NULL,
  candidate_match_id integer NOT NULL,
  score integer NOT NULL DEFAULT 0
);

CREATE INDEX import_record_matches_idx_import_record_id ON import_record_matches (import_record_id);

--
-- Table: import_records
--
DROP TABLE import_records;

CREATE TABLE import_records (
  import_record_id INTEGER PRIMARY KEY NOT NULL,
  import_batch_id integer NOT NULL,
  branchcode varchar(10),
  record_sequence integer NOT NULL DEFAULT 0,
  upload_timestamp timestamp NOT NULL DEFAULT current_timestamp,
  import_date date,
  marc longblob NOT NULL,
  marcxml longtext NOT NULL,
  marcxml_old longtext NOT NULL,
  record_type enum NOT NULL DEFAULT 'biblio',
  overlay_status enum NOT NULL DEFAULT 'no_match',
  status enum NOT NULL DEFAULT 'staged',
  import_error mediumtext,
  encoding varchar(40) NOT NULL DEFAULT '',
  z3950random varchar(40)
);

CREATE INDEX import_records_idx_import_batch_id ON import_records (import_batch_id);

--
-- Table: issues
--
DROP TABLE issues;

CREATE TABLE issues (
  borrowernumber integer,
  itemnumber integer,
  date_due date,
  branchcode varchar(10),
  issuingbranch varchar(18),
  returndate date,
  lastreneweddate date,
  return varchar(4),
  renewals tinyint,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  issuedate date
);

CREATE INDEX issues_idx_borrowernumber ON issues (borrowernumber);

CREATE INDEX issues_idx_itemnumber ON issues (itemnumber);

--
-- Table: issuingrules
--
DROP TABLE issuingrules;

CREATE TABLE issuingrules (
  categorycode varchar(10) NOT NULL DEFAULT '',
  itemtype varchar(10) NOT NULL DEFAULT '',
  restrictedtype tinyint,
  rentaldiscount decimal(28,6),
  reservecharge decimal(28,6),
  fine decimal(28,6),
  finedays integer,
  firstremind integer,
  chargeperiod integer,
  accountsent integer,
  chargename varchar(100),
  maxissueqty integer,
  issuelength integer,
  hardduedate date,
  hardduedatecompare tinyint NOT NULL DEFAULT 0,
  renewalsallowed smallint NOT NULL DEFAULT 0,
  reservesallowed smallint NOT NULL DEFAULT 0,
  branchcode varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (branchcode, categorycode, itemtype)
);

--
-- Table: item_circulation_alert_preferences
--
DROP TABLE item_circulation_alert_preferences;

CREATE TABLE item_circulation_alert_preferences (
  id INTEGER PRIMARY KEY NOT NULL,
  branchcode varchar(10) NOT NULL,
  categorycode varchar(10) NOT NULL,
  item_type varchar(10) NOT NULL,
  notification varchar(16) NOT NULL
);

--
-- Table: itemdeletelist
--
DROP TABLE itemdeletelist;

CREATE TABLE itemdeletelist (
  list_id integer NOT NULL,
  itemnumber integer NOT NULL,
  biblionumber integer NOT NULL,
  PRIMARY KEY (list_id, itemnumber)
);

--
-- Table: items
--
DROP TABLE items;

CREATE TABLE items (
  itemnumber INTEGER PRIMARY KEY NOT NULL,
  biblionumber integer NOT NULL DEFAULT 0,
  biblioitemnumber integer NOT NULL DEFAULT 0,
  barcode varchar(20),
  dateaccessioned date,
  booksellerid mediumtext,
  homebranch varchar(10),
  price decimal(8,2),
  replacementprice decimal(8,2),
  replacementpricedate date,
  datelastborrowed date,
  datelastseen date,
  stack tinyint,
  notforloan tinyint NOT NULL DEFAULT 0,
  damaged tinyint NOT NULL DEFAULT 0,
  itemlost tinyint NOT NULL DEFAULT 0,
  wthdrawn tinyint NOT NULL DEFAULT 0,
  itemcallnumber varchar(255),
  issues smallint,
  renewals smallint,
  reserves smallint,
  restricted tinyint,
  itemnotes mediumtext,
  holdingbranch varchar(10),
  paidfor mediumtext,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  location varchar(80),
  permanent_location varchar(80),
  onloan date,
  cn_source varchar(10),
  cn_sort varchar(30),
  ccode varchar(10),
  materials varchar(10),
  uri varchar(255),
  itype varchar(10),
  more_subfields_xml longtext,
  enumchron text,
  copynumber varchar(32),
  stocknumber varchar(32)
);

CREATE INDEX items_idx_biblioitemnumber ON items (biblioitemnumber);

CREATE INDEX items_idx_holdingbranch ON items (holdingbranch);

CREATE INDEX items_idx_homebranch ON items (homebranch);

CREATE UNIQUE INDEX itembarcodeidx ON items (barcode);

--
-- Table: itemtypes
--
DROP TABLE itemtypes;

CREATE TABLE itemtypes (
  itemtype varchar(10) NOT NULL DEFAULT '',
  description mediumtext,
  rentalcharge double precision(16,4),
  notforloan smallint,
  imageurl varchar(200),
  summary text,
  PRIMARY KEY (itemtype)
);

--
-- Table: labels_batches
--
DROP TABLE labels_batches;

CREATE TABLE labels_batches (
  label_id INTEGER PRIMARY KEY NOT NULL,
  batch_id integer NOT NULL DEFAULT 1,
  item_number integer NOT NULL DEFAULT 0,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  branch_code varchar(10) NOT NULL DEFAULT 'NB'
);

CREATE INDEX labels_batches_idx_branch_code ON labels_batches (branch_code);

CREATE INDEX labels_batches_idx_item_number ON labels_batches (item_number);

--
-- Table: labels_layouts
--
DROP TABLE labels_layouts;

CREATE TABLE labels_layouts (
  layout_id INTEGER PRIMARY KEY NOT NULL,
  barcode_type char(100) NOT NULL DEFAULT 'CODE39',
  printing_type char(32) NOT NULL DEFAULT 'BAR',
  layout_name char(20) NOT NULL DEFAULT 'DEFAULT',
  guidebox integer DEFAULT 0,
  font char(10) NOT NULL DEFAULT 'TR',
  font_size integer NOT NULL DEFAULT 10,
  callnum_split integer DEFAULT 0,
  text_justify char(1) NOT NULL DEFAULT 'L',
  format_string varchar(210) NOT NULL DEFAULT 'barcode'
);

--
-- Table: labels_templates
--
DROP TABLE labels_templates;

CREATE TABLE labels_templates (
  template_id INTEGER PRIMARY KEY NOT NULL,
  profile_id integer,
  template_code char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  template_desc char(100) NOT NULL DEFAULT 'Default description',
  page_width float NOT NULL DEFAULT 0,
  page_height float NOT NULL DEFAULT 0,
  label_width float NOT NULL DEFAULT 0,
  label_height float NOT NULL DEFAULT 0,
  top_text_margin float NOT NULL DEFAULT 0,
  left_text_margin float NOT NULL DEFAULT 0,
  top_margin float NOT NULL DEFAULT 0,
  left_margin float NOT NULL DEFAULT 0,
  cols integer NOT NULL DEFAULT 0,
  rows integer NOT NULL DEFAULT 0,
  col_gap float NOT NULL DEFAULT 0,
  row_gap float NOT NULL DEFAULT 0,
  units char(20) NOT NULL DEFAULT 'POINT'
);

--
-- Table: language_descriptions
--
DROP TABLE language_descriptions;

CREATE TABLE language_descriptions (
  subtag varchar(25),
  type varchar(25),
  lang varchar(25),
  description varchar(255),
  id INTEGER PRIMARY KEY NOT NULL
);

--
-- Table: language_rfc4646_to_iso639
--
DROP TABLE language_rfc4646_to_iso639;

CREATE TABLE language_rfc4646_to_iso639 (
  rfc4646_subtag varchar(25),
  iso639_2_code varchar(25),
  id INTEGER PRIMARY KEY NOT NULL
);

--
-- Table: language_script_bidi
--
DROP TABLE language_script_bidi;

CREATE TABLE language_script_bidi (
  rfc4646_subtag varchar(25),
  bidi varchar(3)
);

--
-- Table: language_script_mapping
--
DROP TABLE language_script_mapping;

CREATE TABLE language_script_mapping (
  language_subtag varchar(25),
  script_subtag varchar(25)
);

--
-- Table: language_subtag_registry
--
DROP TABLE language_subtag_registry;

CREATE TABLE language_subtag_registry (
  subtag varchar(25),
  type varchar(25),
  description varchar(25),
  added date,
  id INTEGER PRIMARY KEY NOT NULL
);

--
-- Table: letter
--
DROP TABLE letter;

CREATE TABLE letter (
  module varchar(20) NOT NULL DEFAULT '',
  code varchar(20) NOT NULL DEFAULT '',
  name varchar(100) NOT NULL DEFAULT '',
  title varchar(200) NOT NULL DEFAULT '',
  content text,
  PRIMARY KEY (module, code)
);

--
-- Table: marc_matchers
--
DROP TABLE marc_matchers;

CREATE TABLE marc_matchers (
  matcher_id INTEGER PRIMARY KEY NOT NULL,
  code varchar(10) NOT NULL DEFAULT '',
  description varchar(255) NOT NULL DEFAULT '',
  record_type varchar(10) NOT NULL DEFAULT 'biblio',
  threshold integer NOT NULL DEFAULT 0
);

--
-- Table: marc_subfield_structure
--
DROP TABLE marc_subfield_structure;

CREATE TABLE marc_subfield_structure (
  tagfield varchar(3) NOT NULL DEFAULT '',
  tagsubfield varchar(1) NOT NULL DEFAULT '',
  liblibrarian varchar(255) NOT NULL DEFAULT '',
  libopac varchar(255) NOT NULL DEFAULT '',
  repeatable tinyint NOT NULL DEFAULT 0,
  mandatory tinyint NOT NULL DEFAULT 0,
  kohafield varchar(40),
  tab tinyint,
  authorised_value varchar(20),
  authtypecode varchar(20),
  value_builder varchar(80),
  isurl tinyint,
  hidden tinyint,
  frameworkcode varchar(4) NOT NULL DEFAULT '',
  seealso varchar(1100),
  link varchar(80),
  defaultvalue text,
  PRIMARY KEY (frameworkcode, tagfield, tagsubfield)
);

--
-- Table: marc_tag_structure
--
DROP TABLE marc_tag_structure;

CREATE TABLE marc_tag_structure (
  tagfield varchar(3) NOT NULL DEFAULT '',
  liblibrarian varchar(255) NOT NULL DEFAULT '',
  libopac varchar(255) NOT NULL DEFAULT '',
  repeatable tinyint NOT NULL DEFAULT 0,
  mandatory tinyint NOT NULL DEFAULT 0,
  authorised_value varchar(10),
  frameworkcode varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (frameworkcode, tagfield)
);

--
-- Table: matchchecks
--
DROP TABLE matchchecks;

CREATE TABLE matchchecks (
  matcher_id integer NOT NULL,
  matchcheck_id INTEGER PRIMARY KEY NOT NULL,
  source_matchpoint_id integer NOT NULL,
  target_matchpoint_id integer NOT NULL
);

CREATE INDEX matchchecks_idx_matcher_id ON matchchecks (matcher_id);

CREATE INDEX matchchecks_idx_source_matchpoint_id ON matchchecks (source_matchpoint_id);

CREATE INDEX matchchecks_idx_target_matchpoint_id ON matchchecks (target_matchpoint_id);

--
-- Table: matcher_matchpoints
--
DROP TABLE matcher_matchpoints;

CREATE TABLE matcher_matchpoints (
  matcher_id integer NOT NULL,
  matchpoint_id integer NOT NULL
);

CREATE INDEX matcher_matchpoints_idx_matcher_id ON matcher_matchpoints (matcher_id);

CREATE INDEX matcher_matchpoints_idx_matchpoint_id ON matcher_matchpoints (matchpoint_id);

--
-- Table: matchpoint_component_norms
--
DROP TABLE matchpoint_component_norms;

CREATE TABLE matchpoint_component_norms (
  matchpoint_component_id integer NOT NULL,
  sequence integer NOT NULL DEFAULT 0,
  norm_routine varchar(50) NOT NULL DEFAULT ''
);

CREATE INDEX matchpoint_component_norms_idx_matchpoint_component_id ON matchpoint_component_norms (matchpoint_component_id);

--
-- Table: matchpoint_components
--
DROP TABLE matchpoint_components;

CREATE TABLE matchpoint_components (
  matchpoint_id integer NOT NULL,
  matchpoint_component_id INTEGER PRIMARY KEY NOT NULL,
  sequence integer NOT NULL DEFAULT 0,
  tag varchar(3) NOT NULL DEFAULT '',
  subfields varchar(40) NOT NULL DEFAULT '',
  offset integer NOT NULL DEFAULT 0,
  length integer NOT NULL DEFAULT 0
);

CREATE INDEX matchpoint_components_idx_matchpoint_id ON matchpoint_components (matchpoint_id);

--
-- Table: matchpoints
--
DROP TABLE matchpoints;

CREATE TABLE matchpoints (
  matcher_id integer NOT NULL,
  matchpoint_id INTEGER PRIMARY KEY NOT NULL,
  search_index varchar(30) NOT NULL DEFAULT '',
  score integer NOT NULL DEFAULT 0
);

CREATE INDEX matchpoints_idx_matcher_id ON matchpoints (matcher_id);

--
-- Table: message_attributes
--
DROP TABLE message_attributes;

CREATE TABLE message_attributes (
  message_attribute_id INTEGER PRIMARY KEY NOT NULL,
  message_name varchar(40),
  takes_days tinyint NOT NULL DEFAULT 0
);

CREATE UNIQUE INDEX message_name ON message_attributes (message_name);

--
-- Table: message_queue
--
DROP TABLE message_queue;

CREATE TABLE message_queue (
  message_id integer NOT NULL,
  borrowernumber integer,
  subject text,
  content text,
  metadata text,
  letter_code varchar(64),
  message_transport_type varchar(20) NOT NULL,
  status enum NOT NULL DEFAULT 'pending',
  time_queued timestamp NOT NULL DEFAULT current_timestamp,
  to_address mediumtext,
  from_address mediumtext,
  content_type text
);

CREATE INDEX message_queue_idx_borrowernumber ON message_queue (borrowernumber);

CREATE INDEX message_queue_idx_message_transport_type ON message_queue (message_transport_type);

--
-- Table: message_transport_types
--
DROP TABLE message_transport_types;

CREATE TABLE message_transport_types (
  message_transport_type varchar(20) NOT NULL,
  PRIMARY KEY (message_transport_type)
);

--
-- Table: message_transports
--
DROP TABLE message_transports;

CREATE TABLE message_transports (
  message_attribute_id integer NOT NULL,
  message_transport_type varchar(20) NOT NULL,
  is_digest tinyint NOT NULL DEFAULT 0,
  letter_module varchar(20) NOT NULL DEFAULT '',
  letter_code varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (message_attribute_id, message_transport_type, is_digest)
);

CREATE INDEX message_transports_idx_letter_module_letter_code ON message_transports (letter_module, letter_code);

CREATE INDEX message_transports_idx_message_attribute_id ON message_transports (message_attribute_id);

CREATE INDEX message_transports_idx_message_transport_type ON message_transports (message_transport_type);

--
-- Table: messages
--
DROP TABLE messages;

CREATE TABLE messages (
  message_id INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer NOT NULL,
  branchcode varchar(10),
  message_type varchar(1) NOT NULL,
  message text NOT NULL,
  message_date timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: notifys
--
DROP TABLE notifys;

CREATE TABLE notifys (
  notify_id integer NOT NULL DEFAULT 0,
  borrowernumber integer NOT NULL DEFAULT 0,
  itemnumber integer NOT NULL DEFAULT 0,
  notify_date date,
  notify_send_date date,
  notify_level integer NOT NULL DEFAULT 0,
  method varchar(20) NOT NULL DEFAULT ''
);

--
-- Table: nozebra
--
DROP TABLE nozebra;

CREATE TABLE nozebra (
  server varchar(20) NOT NULL,
  indexname varchar(40) NOT NULL,
  value varchar(250) NOT NULL,
  biblionumbers longtext NOT NULL
);

--
-- Table: old_issues
--
DROP TABLE old_issues;

CREATE TABLE old_issues (
  borrowernumber integer,
  itemnumber integer,
  date_due date,
  branchcode varchar(10),
  issuingbranch varchar(18),
  returndate date,
  lastreneweddate date,
  return varchar(4),
  renewals tinyint,
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  issuedate date
);

CREATE INDEX old_issues_idx_borrowernumber ON old_issues (borrowernumber);

CREATE INDEX old_issues_idx_itemnumber ON old_issues (itemnumber);

--
-- Table: old_reserves
--
DROP TABLE old_reserves;

CREATE TABLE old_reserves (
  borrowernumber integer,
  reservedate date,
  biblionumber integer,
  constrainttype varchar(1),
  branchcode varchar(10),
  notificationdate date,
  reminderdate date,
  cancellationdate date,
  reservenotes mediumtext,
  priority smallint,
  found varchar(1),
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  itemnumber integer,
  waitingdate date,
  expirationdate date,
  lowestpriority tinyint NOT NULL
);

CREATE INDEX old_reserves_idx_biblionumber ON old_reserves (biblionumber);

CREATE INDEX old_reserves_idx_borrowernumber ON old_reserves (borrowernumber);

CREATE INDEX old_reserves_idx_itemnumber ON old_reserves (itemnumber);

--
-- Table: opac_news
--
DROP TABLE opac_news;

CREATE TABLE opac_news (
  idnew INTEGER PRIMARY KEY NOT NULL,
  title varchar(250) NOT NULL DEFAULT '',
  new text NOT NULL,
  lang varchar(25) NOT NULL DEFAULT '',
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  expirationdate date,
  number integer
);

--
-- Table: overduerules
--
DROP TABLE overduerules;

CREATE TABLE overduerules (
  branchcode varchar(10) NOT NULL DEFAULT '',
  categorycode varchar(10) NOT NULL DEFAULT '',
  delay1 integer,
  letter1 varchar(20),
  debarred1 varchar(1) DEFAULT '0',
  delay2 integer,
  debarred2 varchar(1) DEFAULT '0',
  letter2 varchar(20),
  delay3 integer,
  letter3 varchar(20),
  debarred3 integer DEFAULT 0,
  PRIMARY KEY (branchcode, categorycode)
);

--
-- Table: patroncards
--
DROP TABLE patroncards;

CREATE TABLE patroncards (
  cardid INTEGER PRIMARY KEY NOT NULL,
  batch_id varchar(10) NOT NULL DEFAULT '1',
  borrowernumber integer NOT NULL,
  timestamp timestamp NOT NULL DEFAULT current_timestamp
);

CREATE INDEX patroncards_idx_borrowernumber ON patroncards (borrowernumber);

--
-- Table: patronimage
--
DROP TABLE patronimage;

CREATE TABLE patronimage (
  cardnumber varchar(16) NOT NULL,
  mimetype varchar(15) NOT NULL,
  imagefile mediumblob NOT NULL,
  PRIMARY KEY (cardnumber)
);

--
-- Table: permissions
--
DROP TABLE permissions;

CREATE TABLE permissions (
  module_bit integer NOT NULL DEFAULT 0,
  code varchar(64) NOT NULL DEFAULT '',
  description varchar(255),
  PRIMARY KEY (module_bit, code)
);

CREATE INDEX permissions_idx_module_bit ON permissions (module_bit);

--
-- Table: printers
--
DROP TABLE printers;

CREATE TABLE printers (
  printername varchar(40) NOT NULL DEFAULT '',
  printqueue varchar(20),
  printtype varchar(20),
  PRIMARY KEY (printername)
);

--
-- Table: printers_profile
--
DROP TABLE printers_profile;

CREATE TABLE printers_profile (
  profile_id INTEGER PRIMARY KEY NOT NULL,
  printer_name varchar(40) NOT NULL DEFAULT 'Default Printer',
  template_id integer NOT NULL DEFAULT 0,
  paper_bin varchar(20) NOT NULL DEFAULT 'Bypass',
  offset_horz float NOT NULL DEFAULT 0,
  offset_vert float NOT NULL DEFAULT 0,
  creep_horz float NOT NULL DEFAULT 0,
  creep_vert float NOT NULL DEFAULT 0,
  units char(20) NOT NULL DEFAULT 'POINT',
  creator char(15) NOT NULL DEFAULT 'Labels'
);

CREATE UNIQUE INDEX printername ON printers_profile (printer_name, template_id, paper_bin, creator);

--
-- Table: repeatable_holidays
--
DROP TABLE repeatable_holidays;

CREATE TABLE repeatable_holidays (
  id INTEGER PRIMARY KEY NOT NULL,
  branchcode varchar(10) NOT NULL DEFAULT '',
  weekday smallint,
  day smallint,
  month smallint,
  title varchar(50) NOT NULL DEFAULT '',
  description text NOT NULL
);

--
-- Table: reports_dictionary
--
DROP TABLE reports_dictionary;

CREATE TABLE reports_dictionary (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar(255),
  description text,
  date_created datetime,
  date_modified datetime,
  saved_sql text,
  area integer
);

--
-- Table: reserveconstraints
--
DROP TABLE reserveconstraints;

CREATE TABLE reserveconstraints (
  borrowernumber integer NOT NULL DEFAULT 0,
  reservedate date,
  biblionumber integer NOT NULL DEFAULT 0,
  biblioitemnumber integer,
  timestamp timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: reserves
--
DROP TABLE reserves;

CREATE TABLE reserves (
  borrowernumber integer NOT NULL DEFAULT 0,
  reservedate date,
  biblionumber integer NOT NULL DEFAULT 0,
  constrainttype varchar(1),
  branchcode varchar(10),
  notificationdate date,
  reminderdate date,
  cancellationdate date,
  reservenotes mediumtext,
  priority smallint,
  found varchar(1),
  timestamp timestamp NOT NULL DEFAULT current_timestamp,
  itemnumber integer,
  waitingdate date,
  expirationdate date,
  lowestpriority tinyint NOT NULL
);

CREATE INDEX reserves_idx_biblionumber ON reserves (biblionumber);

CREATE INDEX reserves_idx_borrowernumber ON reserves (borrowernumber);

CREATE INDEX reserves_idx_branchcode ON reserves (branchcode);

CREATE INDEX reserves_idx_itemnumber ON reserves (itemnumber);

--
-- Table: reviews
--
DROP TABLE reviews;

CREATE TABLE reviews (
  reviewid INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer,
  biblionumber integer,
  review text,
  approved tinyint,
  datereviewed datetime
);

--
-- Table: roadtype
--
DROP TABLE roadtype;

CREATE TABLE roadtype (
  roadtypeid INTEGER PRIMARY KEY NOT NULL,
  road_type varchar(100) NOT NULL DEFAULT ''
);

--
-- Table: saved_reports
--
DROP TABLE saved_reports;

CREATE TABLE saved_reports (
  id INTEGER PRIMARY KEY NOT NULL,
  report_id integer,
  report longtext,
  date_run datetime
);

--
-- Table: saved_sql
--
DROP TABLE saved_sql;

CREATE TABLE saved_sql (
  id INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer,
  date_created datetime,
  last_modified datetime,
  savedsql text,
  last_run datetime,
  report_name varchar(255),
  type varchar(255),
  notes text
);

--
-- Table: search_history
--
DROP TABLE search_history;

CREATE TABLE search_history (
  userid integer NOT NULL,
  sessionid varchar(32) NOT NULL,
  query_desc varchar(255) NOT NULL,
  query_cgi varchar(255) NOT NULL,
  total integer NOT NULL,
  time timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: serial
--
DROP TABLE serial;

CREATE TABLE serial (
  serialid INTEGER PRIMARY KEY NOT NULL,
  biblionumber varchar(100) NOT NULL DEFAULT '',
  subscriptionid varchar(100) NOT NULL DEFAULT '',
  serialseq varchar(100) NOT NULL DEFAULT '',
  status tinyint NOT NULL DEFAULT 0,
  planneddate date,
  notes text,
  publisheddate date,
  itemnumber text,
  claimdate date,
  routingnotes text
);

--
-- Table: serialitems
--
DROP TABLE serialitems;

CREATE TABLE serialitems (
  itemnumber integer NOT NULL,
  serialid integer NOT NULL
);

CREATE INDEX serialitems_idx_serialid ON serialitems (serialid);

CREATE UNIQUE INDEX serialitemsidx ON serialitems (itemnumber);

--
-- Table: services_throttle
--
DROP TABLE services_throttle;

CREATE TABLE services_throttle (
  service_type varchar(10) NOT NULL DEFAULT '',
  service_count varchar(45),
  PRIMARY KEY (service_type)
);

--
-- Table: sessions
--
DROP TABLE sessions;

CREATE TABLE sessions (
  id varchar(32) NOT NULL,
  a_session text NOT NULL
);

CREATE UNIQUE INDEX id ON sessions (id);

--
-- Table: special_holidays
--
DROP TABLE special_holidays;

CREATE TABLE special_holidays (
  id INTEGER PRIMARY KEY NOT NULL,
  branchcode varchar(10) NOT NULL DEFAULT '',
  day smallint NOT NULL DEFAULT 0,
  month smallint NOT NULL DEFAULT 0,
  year smallint NOT NULL DEFAULT 0,
  isexception smallint NOT NULL DEFAULT 1,
  title varchar(50) NOT NULL DEFAULT '',
  description text NOT NULL
);

--
-- Table: stat_from_marcxml
--
DROP TABLE stat_from_marcxml;

CREATE TABLE stat_from_marcxml (
  biblionumber integer NOT NULL DEFAULT 0,
  itemtype varchar(1),
  cataloguerm longtext,
  cataloguers longtext,
  insertdate varchar(6),
  modifydate varchar(8),
  accessionno longtext,
  isbn longtext,
  issn longtext,
  callnumber longtext,
  title longtext
);

--
-- Table: statistics
--
DROP TABLE statistics;

CREATE TABLE statistics (
  datetime datetime,
  branch varchar(10),
  proccode varchar(4),
  value double precision(16,4),
  type varchar(16),
  other mediumtext,
  usercode varchar(10),
  itemnumber integer,
  itemtype varchar(10),
  borrowernumber integer,
  associatedborrower integer
);

--
-- Table: stopwords
--
DROP TABLE stopwords;

CREATE TABLE stopwords (
  word varchar(255)
);

--
-- Table: subscription
--
DROP TABLE subscription;

CREATE TABLE subscription (
  biblionumber integer NOT NULL DEFAULT 0,
  subscriptionid INTEGER PRIMARY KEY NOT NULL,
  librarian varchar(100) DEFAULT '',
  startdate date,
  aqbooksellerid integer DEFAULT 0,
  cost integer DEFAULT 0,
  aqbudgetid integer DEFAULT 0,
  weeklength integer DEFAULT 0,
  monthlength integer DEFAULT 0,
  numberlength integer DEFAULT 0,
  periodicity tinyint DEFAULT 0,
  dow varchar(100) DEFAULT '',
  numberingmethod varchar(100) DEFAULT '',
  notes mediumtext,
  status varchar(100) NOT NULL DEFAULT '',
  add1 integer DEFAULT 0,
  every1 integer DEFAULT 0,
  whenmorethan1 integer DEFAULT 0,
  setto1 integer,
  lastvalue1 integer,
  add2 integer DEFAULT 0,
  every2 integer DEFAULT 0,
  whenmorethan2 integer DEFAULT 0,
  setto2 integer,
  lastvalue2 integer,
  add3 integer DEFAULT 0,
  every3 integer DEFAULT 0,
  innerloop1 integer DEFAULT 0,
  innerloop2 integer DEFAULT 0,
  innerloop3 integer DEFAULT 0,
  whenmorethan3 integer DEFAULT 0,
  setto3 integer,
  lastvalue3 integer,
  issuesatonce tinyint NOT NULL DEFAULT 1,
  firstacquidate date,
  manualhistory tinyint NOT NULL DEFAULT 0,
  irregularity text,
  letter varchar(20),
  numberpattern tinyint DEFAULT 0,
  distributedto text,
  internalnotes longtext,
  callnumber text,
  location varchar(80) DEFAULT '',
  branchcode varchar(10) NOT NULL DEFAULT '',
  hemisphere tinyint DEFAULT 0,
  lastbranch varchar(10),
  serialsadditems tinyint NOT NULL DEFAULT 0,
  staffdisplaycount varchar(10),
  opacdisplaycount varchar(10),
  graceperiod integer NOT NULL DEFAULT 0,
  enddate date
);

--
-- Table: subscriptionhistory
--
DROP TABLE subscriptionhistory;

CREATE TABLE subscriptionhistory (
  biblionumber integer NOT NULL DEFAULT 0,
  subscriptionid INTEGER PRIMARY KEY NOT NULL DEFAULT 0,
  histstartdate date,
  histenddate date,
  missinglist longtext NOT NULL,
  recievedlist longtext NOT NULL,
  opacnote varchar(150) NOT NULL DEFAULT '',
  librariannote varchar(150) NOT NULL DEFAULT ''
);

--
-- Table: subscriptionroutinglist
--
DROP TABLE subscriptionroutinglist;

CREATE TABLE subscriptionroutinglist (
  routingid INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer NOT NULL,
  ranking integer,
  subscriptionid integer NOT NULL
);

CREATE INDEX subscriptionroutinglist_idx_borrowernumber ON subscriptionroutinglist (borrowernumber);

CREATE INDEX subscriptionroutinglist_idx_subscriptionid ON subscriptionroutinglist (subscriptionid);

CREATE UNIQUE INDEX subscriptionid ON subscriptionroutinglist (subscriptionid, borrowernumber);

--
-- Table: suggestions
--
DROP TABLE suggestions;

CREATE TABLE suggestions (
  suggestionid INTEGER PRIMARY KEY NOT NULL,
  suggestedby integer NOT NULL DEFAULT 0,
  managedby integer,
  status varchar(10) NOT NULL DEFAULT '',
  note mediumtext,
  author varchar(80),
  title varchar(80),
  copyrightdate smallint,
  publishercode varchar(255),
  date timestamp NOT NULL DEFAULT current_timestamp,
  volumedesc varchar(255),
  publicationyear smallint DEFAULT 0,
  place varchar(255),
  isbn varchar(30),
  mailoverseeing smallint DEFAULT 0,
  biblionumber integer,
  reason text,
  budgetid integer,
  branchcode varchar(10),
  acceptedby integer,
  accepteddate date,
  suggesteddate date,
  manageddate date,
  rejectedby integer,
  rejecteddate date,
  collectiontitle text,
  itemtype varchar(30),
  quantity smallint,
  currency varchar(3),
  price decimal(28,6),
  total decimal(28,6)
);

--
-- Table: systempreferences
--
DROP TABLE systempreferences;

CREATE TABLE systempreferences (
  variable varchar(50) NOT NULL DEFAULT '',
  value text,
  options mediumtext,
  explanation text,
  type varchar(20),
  PRIMARY KEY (variable)
);

--
-- Table: tags
--
DROP TABLE tags;

CREATE TABLE tags (
  entry varchar(255) NOT NULL DEFAULT '',
  weight bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (entry)
);

--
-- Table: tags_all
--
DROP TABLE tags_all;

CREATE TABLE tags_all (
  tag_id INTEGER PRIMARY KEY NOT NULL,
  borrowernumber integer NOT NULL,
  biblionumber integer NOT NULL,
  term varchar(255) NOT NULL,
  language integer,
  date_created datetime NOT NULL
);

CREATE INDEX tags_all_idx_biblionumber ON tags_all (biblionumber);

CREATE INDEX tags_all_idx_borrowernumber ON tags_all (borrowernumber);

--
-- Table: tags_approval
--
DROP TABLE tags_approval;

CREATE TABLE tags_approval (
  term varchar(255) NOT NULL,
  approved integer NOT NULL DEFAULT 0,
  date_approved datetime,
  approved_by integer,
  weight_total integer NOT NULL DEFAULT 1,
  PRIMARY KEY (term)
);

CREATE INDEX tags_approval_idx_approved_by ON tags_approval (approved_by);

--
-- Table: tags_index
--
DROP TABLE tags_index;

CREATE TABLE tags_index (
  term varchar(255) NOT NULL,
  biblionumber integer NOT NULL,
  weight integer NOT NULL DEFAULT 1,
  PRIMARY KEY (term, biblionumber)
);

CREATE INDEX tags_index_idx_biblionumber ON tags_index (biblionumber);

CREATE INDEX tags_index_idx_term ON tags_index (term);

--
-- Table: tmp_holdsqueue
--
DROP TABLE tmp_holdsqueue;

CREATE TABLE tmp_holdsqueue (
  biblionumber integer,
  itemnumber integer,
  barcode varchar(20),
  surname mediumtext NOT NULL,
  firstname text,
  phone text,
  borrowernumber integer NOT NULL,
  cardnumber varchar(16),
  reservedate date,
  title mediumtext,
  itemcallnumber varchar(255),
  holdingbranch varchar(10),
  pickbranch varchar(10),
  notes text,
  item_level_request tinyint NOT NULL DEFAULT 0
);

--
-- Table: user_permissions
--
DROP TABLE user_permissions;

CREATE TABLE user_permissions (
  borrowernumber integer NOT NULL DEFAULT 0,
  module_bit integer NOT NULL DEFAULT 0,
  code varchar(64)
);

CREATE INDEX user_permissions_idx_borrowernumber ON user_permissions (borrowernumber);

CREATE INDEX user_permissions_idx_module_bit_code ON user_permissions (module_bit, code);

--
-- Table: userflags
--
DROP TABLE userflags;

CREATE TABLE userflags (
  bit INTEGER PRIMARY KEY NOT NULL DEFAULT 0,
  flag varchar(30),
  flagdesc varchar(255),
  defaulton integer
);

--
-- Table: view_maxbasketno_x_biblio
--
DROP TABLE view_maxbasketno_x_biblio;

CREATE TABLE view_maxbasketno_x_biblio (
  maxbasketno integer,
  biblionumber integer
);

--
-- Table: view_maxsubid_x_biblio
--
DROP TABLE view_maxsubid_x_biblio;

CREATE TABLE view_maxsubid_x_biblio (
  maxsubscriptionid integer,
  biblionumber integer NOT NULL DEFAULT 0
);

--
-- Table: virtualshelfcontents
--
DROP TABLE virtualshelfcontents;

CREATE TABLE virtualshelfcontents (
  shelfnumber integer NOT NULL DEFAULT 0,
  biblionumber integer NOT NULL DEFAULT 0,
  flags integer,
  dateadded timestamp NOT NULL DEFAULT current_timestamp
);

CREATE INDEX virtualshelfcontents_idx_biblionumber ON virtualshelfcontents (biblionumber);

CREATE INDEX virtualshelfcontents_idx_shelfnumber ON virtualshelfcontents (shelfnumber);

--
-- Table: virtualshelves
--
DROP TABLE virtualshelves;

CREATE TABLE virtualshelves (
  shelfnumber INTEGER PRIMARY KEY NOT NULL,
  shelfname varchar(255),
  owner varchar(80),
  category varchar(1),
  sortfield varchar(16),
  lastmodified timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: z3950servers
--
DROP TABLE z3950servers;

CREATE TABLE z3950servers (
  host varchar(255),
  port integer,
  db varchar(255),
  userid varchar(255),
  password varchar(255),
  name mediumtext,
  id INTEGER PRIMARY KEY NOT NULL,
  checked smallint,
  rank integer,
  syntax varchar(80),
  icon text,
  position enum NOT NULL DEFAULT 'primary',
  type enum NOT NULL DEFAULT 'zed',
  encoding text,
  description text NOT NULL
);

--
-- Table: zebraqueue
--
DROP TABLE zebraqueue;

CREATE TABLE zebraqueue (
  id INTEGER PRIMARY KEY NOT NULL,
  biblio_auth_number bigint NOT NULL DEFAULT 0,
  operation char(20) NOT NULL DEFAULT '',
  server char(20) NOT NULL DEFAULT '',
  done integer NOT NULL DEFAULT 0,
  time timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Table: branches
--
DROP TABLE branches;

CREATE TABLE branches (
  branchcode varchar(10) NOT NULL DEFAULT '',
  branchname mediumtext NOT NULL,
  branchaddress1 mediumtext,
  branchaddress2 mediumtext,
  branchaddress3 mediumtext,
  branchzip varchar(25),
  branchcity mediumtext,
  branchstate mediumtext,
  branchcountry text,
  branchphone mediumtext,
  branchfax mediumtext,
  branchemail mediumtext,
  branchurl mediumtext,
  issuing tinyint,
  branchip varchar(15),
  branchprinter varchar(100),
  branchnotes mediumtext
);

CREATE INDEX branches_idx_branchcode ON branches (branchcode);

CREATE UNIQUE INDEX branchcode ON branches (branchcode);

COMMIT;
