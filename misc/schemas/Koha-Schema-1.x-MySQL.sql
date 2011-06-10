-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Jun 10 12:39:31 2011
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `accountlines`;

--
-- Table: `accountlines`
--
CREATE TABLE `accountlines` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `accountno` smallint NOT NULL DEFAULT 0,
  `itemnumber` integer,
  `date` date,
  `amount` decimal(28, 6),
  `description` mediumtext,
  `dispute` mediumtext,
  `accounttype` varchar(5),
  `amountoutstanding` decimal(28, 6),
  `lastincrement` decimal(28, 6),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `notify_id` integer NOT NULL DEFAULT 0,
  `notify_level` integer NOT NULL DEFAULT 0,
  `note` text,
  `manager_id` integer,
  INDEX `accountlines_idx_borrowernumber` (`borrowernumber`),
  INDEX `accountlines_idx_itemnumber` (`itemnumber`),
  CONSTRAINT `accountlines_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accountlines_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `accountoffsets`;

--
-- Table: `accountoffsets`
--
CREATE TABLE `accountoffsets` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `accountno` smallint NOT NULL DEFAULT 0,
  `offsetaccount` smallint NOT NULL DEFAULT 0,
  `offsetamount` decimal(28, 6),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  INDEX `accountoffsets_idx_borrowernumber` (`borrowernumber`),
  CONSTRAINT `accountoffsets_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `action_logs`;

--
-- Table: `action_logs`
--
CREATE TABLE `action_logs` (
  `action_id` integer NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `user` integer NOT NULL DEFAULT 0,
  `module` text,
  `action` text,
  `object` integer,
  `info` text,
  PRIMARY KEY (`action_id`)
);

DROP TABLE IF EXISTS `alert`;

--
-- Table: `alert`
--
CREATE TABLE `alert` (
  `alertid` integer NOT NULL auto_increment,
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `type` varchar(10) NOT NULL DEFAULT '',
  `externalid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`alertid`)
);

DROP TABLE IF EXISTS `aqbasket`;

--
-- Table: `aqbasket`
--
CREATE TABLE `aqbasket` (
  `basketno` integer NOT NULL auto_increment,
  `basketname` varchar(50),
  `note` mediumtext,
  `booksellernote` mediumtext,
  `contractnumber` integer,
  `creationdate` date,
  `closedate` date,
  `booksellerid` integer NOT NULL DEFAULT 1,
  `authorisedby` varchar(10),
  `booksellerinvoicenumber` mediumtext,
  `basketgroupid` integer,
  INDEX `aqbasket_idx_basketgroupid` (`basketgroupid`),
  INDEX `aqbasket_idx_booksellerid` (`booksellerid`),
  INDEX `aqbasket_idx_contractnumber` (`contractnumber`),
  PRIMARY KEY (`basketno`),
  CONSTRAINT `aqbasket_fk_basketgroupid` FOREIGN KEY (`basketgroupid`) REFERENCES `aqbasketgroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbasket_fk_booksellerid` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbasket_fk_contractnumber` FOREIGN KEY (`contractnumber`) REFERENCES `aqcontract` (`contractnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbasketgroups`;

--
-- Table: `aqbasketgroups`
--
CREATE TABLE `aqbasketgroups` (
  `id` integer NOT NULL auto_increment,
  `name` varchar(50),
  `closed` tinyint,
  `booksellerid` integer NOT NULL,
  `deliveryplace` varchar(10),
  `freedeliveryplace` text,
  `deliverycomment` varchar(255),
  `billingplace` varchar(10) NOT NULL,
  INDEX `aqbasketgroups_idx_booksellerid` (`booksellerid`),
  PRIMARY KEY (`id`),
  CONSTRAINT `aqbasketgroups_fk_booksellerid` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbookfund`;

--
-- Table: `aqbookfund`
--
CREATE TABLE `aqbookfund` (
  `bookfundid` varchar(10) NOT NULL DEFAULT '',
  `bookfundname` mediumtext,
  `bookfundgroup` varchar(5),
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`bookfundid`, `branchcode`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbooksellers`;

--
-- Table: `aqbooksellers`
--
CREATE TABLE `aqbooksellers` (
  `id` integer NOT NULL auto_increment,
  `name` mediumtext NOT NULL,
  `address1` mediumtext,
  `address2` mediumtext,
  `address3` mediumtext,
  `address4` mediumtext,
  `phone` varchar(30),
  `accountnumber` mediumtext,
  `othersupplier` mediumtext,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `booksellerfax` mediumtext,
  `notes` mediumtext,
  `bookselleremail` mediumtext,
  `booksellerurl` mediumtext,
  `contact` varchar(100),
  `postal` mediumtext,
  `url` varchar(255),
  `contpos` varchar(100),
  `contphone` varchar(100),
  `contfax` varchar(100),
  `contaltphone` varchar(100),
  `contemail` varchar(100),
  `contnotes` mediumtext,
  `active` tinyint,
  `listprice` varchar(10),
  `invoiceprice` varchar(10),
  `gstreg` tinyint,
  `listincgst` tinyint,
  `invoiceincgst` tinyint,
  `discount` float(6, 4),
  `fax` varchar(50),
  `gstrate` decimal(6, 4),
  INDEX `aqbooksellers_idx_invoiceprice` (`invoiceprice`),
  INDEX `aqbooksellers_idx_listprice` (`listprice`),
  PRIMARY KEY (`id`),
  CONSTRAINT `aqbooksellers_fk_invoiceprice` FOREIGN KEY (`invoiceprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbooksellers_fk_listprice` FOREIGN KEY (`listprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbudgetperiods`;

--
-- Table: `aqbudgetperiods`
--
CREATE TABLE `aqbudgetperiods` (
  `budget_period_id` integer NOT NULL auto_increment,
  `budget_period_startdate` date NOT NULL,
  `budget_period_enddate` date NOT NULL,
  `budget_period_active` tinyint DEFAULT 0,
  `budget_period_description` mediumtext,
  `budget_period_locked` tinyint,
  `sort1_authcat` varchar(10),
  `sort2_authcat` varchar(10),
  `budget_period_total` decimal(28, 6),
  PRIMARY KEY (`budget_period_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbudgets`;

--
-- Table: `aqbudgets`
--
CREATE TABLE `aqbudgets` (
  `budget_code` varchar(30),
  `budget_amount` decimal(28, 6) NOT NULL DEFAULT 0.000000,
  `budget_id` integer NOT NULL auto_increment,
  `budget_branchcode` varchar(10),
  `budget_parent_id` integer,
  `budget_name` varchar(80),
  `budget_encumb` decimal(28, 6) DEFAULT 0.000000,
  `budget_expend` decimal(28, 6) DEFAULT 0.000000,
  `budget_notes` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `budget_period_id` integer,
  `sort1_authcat` varchar(80),
  `sort2_authcat` varchar(80),
  `budget_owner_id` integer,
  `budget_permission` integer DEFAULT 0,
  INDEX `aqbudgets_idx_budget_period_id` (`budget_period_id`),
  PRIMARY KEY (`budget_id`),
  CONSTRAINT `aqbudgets_fk_budget_period_id` FOREIGN KEY (`budget_period_id`) REFERENCES `aqbudgetperiods` (`budget_period_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqbudgets_planning`;

--
-- Table: `aqbudgets_planning`
--
CREATE TABLE `aqbudgets_planning` (
  `plan_id` integer NOT NULL auto_increment,
  `budget_id` integer NOT NULL,
  `budget_period_id` integer NOT NULL,
  `estimated_amount` decimal(28, 6),
  `authcat` varchar(30) NOT NULL,
  `authvalue` varchar(30) NOT NULL,
  `display` tinyint DEFAULT 1,
  INDEX `aqbudgets_planning_idx_budget_id` (`budget_id`),
  PRIMARY KEY (`plan_id`),
  CONSTRAINT `aqbudgets_planning_fk_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqcontract`;

--
-- Table: `aqcontract`
--
CREATE TABLE `aqcontract` (
  `contractnumber` integer NOT NULL auto_increment,
  `contractstartdate` date,
  `contractenddate` date,
  `contractname` varchar(50),
  `contractdescription` mediumtext,
  `booksellerid` integer NOT NULL,
  INDEX `aqcontract_idx_booksellerid` (`booksellerid`),
  PRIMARY KEY (`contractnumber`),
  CONSTRAINT `aqcontract_fk_booksellerid` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqorderbreakdown`;

--
-- Table: `aqorderbreakdown`
--
CREATE TABLE `aqorderbreakdown` (
  `ordernumber` integer,
  `linenumber` integer,
  `branchcode` varchar(10),
  `bookfundid` varchar(10) NOT NULL DEFAULT '',
  `allocation` smallint,
  INDEX `aqorderbreakdown_idx_bookfundid` (`bookfundid`),
  INDEX `aqorderbreakdown_idx_ordernumber` (`ordernumber`),
  CONSTRAINT `aqorderbreakdown_fk_bookfundid` FOREIGN KEY (`bookfundid`) REFERENCES `aqbookfund` (`bookfundid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqorderbreakdown_fk_ordernumber` FOREIGN KEY (`ordernumber`) REFERENCES `aqorders` (`ordernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqorderdelivery`;

--
-- Table: `aqorderdelivery`
--
CREATE TABLE `aqorderdelivery` (
  `ordernumber` date,
  `deliverynumber` smallint NOT NULL DEFAULT 0,
  `deliverydate` varchar(18),
  `qtydelivered` smallint,
  `deliverycomments` mediumtext
);

DROP TABLE IF EXISTS `aqorders`;

--
-- Table: `aqorders`
--
CREATE TABLE `aqorders` (
  `ordernumber` integer NOT NULL auto_increment,
  `biblionumber` integer,
  `entrydate` date,
  `quantity` smallint,
  `currency` varchar(3),
  `listprice` decimal(28, 6),
  `totalamount` decimal(28, 6),
  `datereceived` date,
  `booksellerinvoicenumber` mediumtext,
  `freight` decimal(28, 6),
  `unitprice` decimal(28, 6),
  `quantityreceived` smallint NOT NULL DEFAULT 0,
  `cancelledby` varchar(10),
  `datecancellationprinted` date,
  `notes` mediumtext,
  `supplierreference` mediumtext,
  `purchaseordernumber` mediumtext,
  `subscription` tinyint,
  `serialid` varchar(30),
  `basketno` integer,
  `biblioitemnumber` integer,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `rrp` decimal(13, 2),
  `ecost` decimal(13, 2),
  `gst` decimal(13, 2),
  `budgetdate` date,
  `sort1` varchar(80),
  `sort2` varchar(80),
  `uncertainprice` tinyint,
  `budget_id` integer NOT NULL,
  `budgetgroup_id` integer NOT NULL,
  `sort1_authcat` varchar(10),
  `sort2_authcat` varchar(10),
  INDEX `aqorders_idx_basketno` (`basketno`),
  INDEX `aqorders_idx_biblionumber` (`biblionumber`),
  PRIMARY KEY (`ordernumber`),
  CONSTRAINT `aqorders_fk_basketno` FOREIGN KEY (`basketno`) REFERENCES `aqbasket` (`basketno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqorders_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `aqorders_items`;

--
-- Table: `aqorders_items`
--
CREATE TABLE `aqorders_items` (
  `ordernumber` integer NOT NULL,
  `itemnumber` integer NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`itemnumber`)
);

DROP TABLE IF EXISTS `auth_header`;

--
-- Table: `auth_header`
--
CREATE TABLE `auth_header` (
  `authid` bigint unsigned NOT NULL auto_increment,
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `datecreated` date,
  `datemodified` date,
  `origincode` varchar(20),
  `authtrees` mediumtext,
  `marc` blob,
  `linkid` bigint,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`authid`)
);

DROP TABLE IF EXISTS `auth_subfield_structure`;

--
-- Table: `auth_subfield_structure`
--
CREATE TABLE `auth_subfield_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint NOT NULL DEFAULT 0,
  `mandatory` tinyint NOT NULL DEFAULT 0,
  `tab` tinyint,
  `authorised_value` varchar(10),
  `value_builder` varchar(80),
  `seealso` varchar(255),
  `isurl` tinyint,
  `hidden` tinyint NOT NULL DEFAULT 0,
  `linkid` tinyint NOT NULL DEFAULT 0,
  `kohafield` varchar(45) DEFAULT '',
  `frameworkcode` varchar(10),
  PRIMARY KEY (`authtypecode`, `tagfield`, `tagsubfield`)
);

DROP TABLE IF EXISTS `auth_tag_structure`;

--
-- Table: `auth_tag_structure`
--
CREATE TABLE `auth_tag_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint NOT NULL DEFAULT 0,
  `mandatory` tinyint NOT NULL DEFAULT 0,
  `authorised_value` varchar(10),
  INDEX `auth_tag_structure_idx_authtypecode` (`authtypecode`),
  PRIMARY KEY (`authtypecode`, `tagfield`),
  CONSTRAINT `auth_tag_structure_fk_authtypecode` FOREIGN KEY (`authtypecode`) REFERENCES `auth_types` (`authtypecode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `auth_types`;

--
-- Table: `auth_types`
--
CREATE TABLE `auth_types` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `authtypetext` varchar(255) NOT NULL DEFAULT '',
  `auth_tag_to_report` varchar(3) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  PRIMARY KEY (`authtypecode`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `authorised_values`;

--
-- Table: `authorised_values`
--
CREATE TABLE `authorised_values` (
  `id` integer NOT NULL auto_increment,
  `category` varchar(10) NOT NULL DEFAULT '',
  `authorised_value` varchar(80) NOT NULL DEFAULT '',
  `lib` varchar(80),
  `lib_opac` varchar(80),
  `imageurl` varchar(200),
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `biblio`;

--
-- Table: `biblio`
--
CREATE TABLE `biblio` (
  `biblionumber` integer NOT NULL auto_increment,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint,
  `seriestitle` mediumtext,
  `copyrightdate` smallint,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `biblio_framework`;

--
-- Table: `biblio_framework`
--
CREATE TABLE `biblio_framework` (
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `frameworktext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`)
);

DROP TABLE IF EXISTS `biblioitems`;

--
-- Table: `biblioitems`
--
CREATE TABLE `biblioitems` (
  `biblioitemnumber` integer NOT NULL auto_increment,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10),
  `isbn` varchar(30),
  `issn` varchar(9),
  `publicationyear` text,
  `publishercode` varchar(255),
  `volumedate` date,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `illus` varchar(255),
  `pages` varchar(255),
  `notes` mediumtext,
  `size` varchar(255),
  `place` varchar(255),
  `lccn` varchar(25),
  `marc` longblob,
  `url` varchar(255),
  `cn_source` varchar(10),
  `cn_class` varchar(30),
  `cn_item` varchar(10),
  `cn_suffix` varchar(10),
  `cn_sort` varchar(30),
  `totalissues` integer,
  `marcxml` longtext NOT NULL,
  INDEX `biblioitems_idx_biblionumber` (`biblionumber`),
  PRIMARY KEY (`biblioitemnumber`),
  CONSTRAINT `biblioitems_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `borrower_attribute_types`;

--
-- Table: `borrower_attribute_types`
--
CREATE TABLE `borrower_attribute_types` (
  `code` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `repeatable` tinyint NOT NULL DEFAULT 0,
  `unique_id` tinyint NOT NULL DEFAULT 0,
  `opac_display` tinyint NOT NULL DEFAULT 0,
  `password_allowed` tinyint NOT NULL DEFAULT 0,
  `staff_searchable` tinyint NOT NULL DEFAULT 0,
  `authorised_value_category` varchar(10),
  PRIMARY KEY (`code`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `borrower_attributes`;

--
-- Table: `borrower_attributes`
--
CREATE TABLE `borrower_attributes` (
  `borrowernumber` integer NOT NULL,
  `code` varchar(10) NOT NULL,
  `attribute` varchar(64),
  `password` varchar(64),
  INDEX `borrower_attributes_idx_borrowernumber` (`borrowernumber`),
  INDEX `borrower_attributes_idx_code` (`code`),
  CONSTRAINT `borrower_attributes_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_attributes_fk_code` FOREIGN KEY (`code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `borrower_message_preferences`;

--
-- Table: `borrower_message_preferences`
--
CREATE TABLE `borrower_message_preferences` (
  `borrower_message_preference_id` integer NOT NULL auto_increment,
  `borrowernumber` integer,
  `categorycode` varchar(10),
  `message_attribute_id` integer DEFAULT 0,
  `days_in_advance` integer DEFAULT 0,
  `wants_digest` tinyint NOT NULL DEFAULT 0,
  INDEX `borrower_message_preferences_idx_borrowernumber` (`borrowernumber`),
  INDEX `borrower_message_preferences_idx_categorycode` (`categorycode`),
  INDEX `borrower_message_preferences_idx_message_attribute_id` (`message_attribute_id`),
  PRIMARY KEY (`borrower_message_preference_id`),
  CONSTRAINT `borrower_message_preferences_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_fk_categorycode` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_fk_message_attribute_id` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `borrower_message_transport_preferences`;

--
-- Table: `borrower_message_transport_preferences`
--
CREATE TABLE `borrower_message_transport_preferences` (
  `borrower_message_preference_id` integer NOT NULL DEFAULT 0,
  `message_transport_type` varchar(20) NOT NULL DEFAULT '0',
  INDEX `borrower_message_transport_preferences_idx_borrower_mes_7d9fb153` (`borrower_message_preference_id`),
  INDEX `borrower_message_transport_preferences_idx_message_tran_cad79ec2` (`message_transport_type`),
  PRIMARY KEY (`borrower_message_preference_id`, `message_transport_type`),
  CONSTRAINT `borrower_message_transport_preferences_fk_borrower_mess_94cd2e3b` FOREIGN KEY (`borrower_message_preference_id`) REFERENCES `borrower_message_preferences` (`borrower_message_preference_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_transport_preferences_fk_message_transport_type` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `borrowers`;

--
-- Table: `borrowers`
--
CREATE TABLE `borrowers` (
  `borrowernumber` integer NOT NULL auto_increment,
  `cardnumber` varchar(16),
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10),
  `streettype` varchar(50),
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` mediumtext,
  `zipcode` varchar(25),
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50),
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `b_streetnumber` varchar(10),
  `b_streettype` varchar(50),
  `b_address` varchar(100),
  `b_address2` text,
  `b_city` mediumtext,
  `b_state` mediumtext,
  `b_zipcode` varchar(25),
  `b_country` text,
  `b_email` text,
  `b_phone` mediumtext,
  `dateofbirth` date,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `dateenrolled` date,
  `dateexpiry` date,
  `gonenoaddress` tinyint,
  `lost` tinyint,
  `debarred` tinyint,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` integer,
  `borrowernotes` mediumtext,
  `relationship` varchar(100),
  `ethnicity` varchar(50),
  `ethnotes` varchar(255),
  `sex` varchar(1),
  `password` varchar(30),
  `flags` integer,
  `userid` varchar(30),
  `opacnote` mediumtext,
  `contactnote` varchar(255),
  `sort1` varchar(80),
  `sort2` varchar(80),
  `altcontactfirstname` varchar(255),
  `altcontactsurname` varchar(255),
  `altcontactaddress1` varchar(255),
  `altcontactaddress2` varchar(255),
  `altcontactaddress3` varchar(255),
  `altcontactstate` mediumtext,
  `altcontactzipcode` varchar(50),
  `altcontactcountry` text,
  `altcontactphone` varchar(50),
  `smsalertnumber` varchar(50),
  `disable_reading_history` tinyint,
  `privacy` integer NOT NULL DEFAULT 1,
  INDEX `borrowers_idx_branchcode` (`branchcode`),
  INDEX `borrowers_idx_categorycode` (`categorycode`),
  PRIMARY KEY (`borrowernumber`),
  UNIQUE `cardnumber` (`cardnumber`),
  CONSTRAINT `borrowers_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowers_fk_categorycode` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `branch_borrower_circ_rules`;

--
-- Table: `branch_borrower_circ_rules`
--
CREATE TABLE `branch_borrower_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` integer,
  INDEX `branch_borrower_circ_rules_idx_branchcode` (`branchcode`),
  INDEX `branch_borrower_circ_rules_idx_categorycode` (`categorycode`),
  PRIMARY KEY (`categorycode`, `branchcode`),
  CONSTRAINT `branch_borrower_circ_rules_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_borrower_circ_rules_fk_categorycode` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `branch_item_rules`;

--
-- Table: `branch_item_rules`
--
CREATE TABLE `branch_item_rules` (
  `branchcode` varchar(10) NOT NULL,
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint,
  INDEX `branch_item_rules_idx_branchcode` (`branchcode`),
  INDEX `branch_item_rules_idx_itemtype` (`itemtype`),
  PRIMARY KEY (`itemtype`, `branchcode`),
  CONSTRAINT `branch_item_rules_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_item_rules_fk_itemtype` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `branch_transfer_limits`;

--
-- Table: `branch_transfer_limits`
--
CREATE TABLE `branch_transfer_limits` (
  `limitid` integer NOT NULL auto_increment,
  `tobranch` varchar(10) NOT NULL,
  `frombranch` varchar(10) NOT NULL,
  `itemtype` varchar(10),
  `ccode` varchar(10),
  PRIMARY KEY (`limitid`)
);

DROP TABLE IF EXISTS `branchcategories`;

--
-- Table: `branchcategories`
--
CREATE TABLE `branchcategories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `categoryname` varchar(32),
  `codedescription` mediumtext,
  `categorytype` varchar(16),
  PRIMARY KEY (`categorycode`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `branchrelations`;

--
-- Table: `branchrelations`
--
CREATE TABLE `branchrelations` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  INDEX `branchrelations_idx_branchcode` (`branchcode`),
  INDEX `branchrelations_idx_categorycode` (`categorycode`),
  PRIMARY KEY (`branchcode`, `categorycode`),
  CONSTRAINT `branchrelations_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchrelations_fk_categorycode` FOREIGN KEY (`categorycode`) REFERENCES `branchcategories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `branchtransfers`;

--
-- Table: `branchtransfers`
--
CREATE TABLE `branchtransfers` (
  `itemnumber` integer NOT NULL DEFAULT 0,
  `datesent` datetime,
  `frombranch` varchar(10) NOT NULL DEFAULT '',
  `datearrived` datetime,
  `tobranch` varchar(10) NOT NULL DEFAULT '',
  `comments` mediumtext,
  INDEX `branchtransfers_idx_frombranch` (`frombranch`),
  INDEX `branchtransfers_idx_itemnumber` (`itemnumber`),
  INDEX `branchtransfers_idx_tobranch` (`tobranch`),
  CONSTRAINT `branchtransfers_fk_frombranch` FOREIGN KEY (`frombranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_fk_tobranch` FOREIGN KEY (`tobranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `browser`;

--
-- Table: `browser`
--
CREATE TABLE `browser` (
  `level` integer NOT NULL,
  `classification` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `number` bigint NOT NULL,
  `endnode` tinyint NOT NULL
);

DROP TABLE IF EXISTS `categories`;

--
-- Table: `categories`
--
CREATE TABLE `categories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `enrolmentperiod` smallint,
  `enrolmentperioddate` date,
  `upperagelimit` smallint,
  `dateofbirthrequired` tinyint,
  `finetype` varchar(30),
  `bulk` tinyint,
  `enrolmentfee` decimal(28, 6),
  `overduenoticerequired` tinyint,
  `issuelimit` smallint,
  `reservefee` decimal(28, 6),
  `hidelostitems` tinyint NOT NULL DEFAULT 0,
  `category_type` varchar(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`categorycode`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `cities`;

--
-- Table: `cities`
--
CREATE TABLE `cities` (
  `cityid` integer NOT NULL auto_increment,
  `city_name` varchar(100) NOT NULL DEFAULT '',
  `city_zipcode` varchar(20),
  PRIMARY KEY (`cityid`)
);

DROP TABLE IF EXISTS `class_sort_rules`;

--
-- Table: `class_sort_rules`
--
CREATE TABLE `class_sort_rules` (
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `sort_routine` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`class_sort_rule`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `class_sources`;

--
-- Table: `class_sources`
--
CREATE TABLE `class_sources` (
  `cn_source` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `used` tinyint NOT NULL DEFAULT 0,
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  INDEX `class_sources_idx_class_sort_rule` (`class_sort_rule`),
  PRIMARY KEY (`cn_source`),
  CONSTRAINT `class_sources_fk_class_sort_rule` FOREIGN KEY (`class_sort_rule`) REFERENCES `class_sort_rules` (`class_sort_rule`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `collections`;

--
-- Table: `collections`
--
CREATE TABLE `collections` (
  `colid` integer NOT NULL auto_increment,
  `coltitle` varchar(100) NOT NULL DEFAULT '',
  `coldesc` text NOT NULL,
  `colbranchcode` varchar(4),
  PRIMARY KEY (`colid`)
);

DROP TABLE IF EXISTS `collections_tracking`;

--
-- Table: `collections_tracking`
--
CREATE TABLE `collections_tracking` (
  `ctid` integer NOT NULL auto_increment,
  `colid` integer NOT NULL DEFAULT 0,
  `itemnumber` integer NOT NULL DEFAULT 0,
  PRIMARY KEY (`ctid`)
);

DROP TABLE IF EXISTS `creator_batches`;

--
-- Table: `creator_batches`
--
CREATE TABLE `creator_batches` (
  `label_id` integer NOT NULL auto_increment,
  `batch_id` integer NOT NULL DEFAULT 1,
  `item_number` integer,
  `borrower_number` integer,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `branch_code` varchar(10) NOT NULL DEFAULT 'NB',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  INDEX `creator_batches_idx_borrower_number` (`borrower_number`),
  INDEX `creator_batches_idx_branch_code` (`branch_code`),
  INDEX `creator_batches_idx_item_number` (`item_number`),
  PRIMARY KEY (`label_id`),
  CONSTRAINT `creator_batches_fk_borrower_number` FOREIGN KEY (`borrower_number`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `creator_batches_fk_branch_code` FOREIGN KEY (`branch_code`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `creator_batches_fk_item_number` FOREIGN KEY (`item_number`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `creator_images`;

--
-- Table: `creator_images`
--
CREATE TABLE `creator_images` (
  `image_id` integer NOT NULL auto_increment,
  `imagefile` mediumblob,
  `image_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`image_id`),
  UNIQUE `image_name_index` (`image_name`)
);

DROP TABLE IF EXISTS `creator_layouts`;

--
-- Table: `creator_layouts`
--
CREATE TABLE `creator_layouts` (
  `layout_id` integer NOT NULL auto_increment,
  `barcode_type` char(100) NOT NULL DEFAULT 'CODE39',
  `start_label` integer NOT NULL DEFAULT 1,
  `printing_type` char(32) NOT NULL DEFAULT 'BAR',
  `layout_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  `guidebox` integer DEFAULT 0,
  `font` char(10) NOT NULL DEFAULT 'TR',
  `font_size` integer NOT NULL DEFAULT 10,
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `callnum_split` integer DEFAULT 0,
  `text_justify` char(1) NOT NULL DEFAULT 'L',
  `format_string` varchar(210) NOT NULL DEFAULT 'barcode',
  `layout_xml` text NOT NULL,
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`layout_id`)
);

DROP TABLE IF EXISTS `creator_templates`;

--
-- Table: `creator_templates`
--
CREATE TABLE `creator_templates` (
  `template_id` integer NOT NULL auto_increment,
  `profile_id` integer,
  `template_code` char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  `template_desc` char(100) NOT NULL DEFAULT 'Default description',
  `page_width` float NOT NULL DEFAULT 0,
  `page_height` float NOT NULL DEFAULT 0,
  `label_width` float NOT NULL DEFAULT 0,
  `label_height` float NOT NULL DEFAULT 0,
  `top_text_margin` float NOT NULL DEFAULT 0,
  `left_text_margin` float NOT NULL DEFAULT 0,
  `top_margin` float NOT NULL DEFAULT 0,
  `left_margin` float NOT NULL DEFAULT 0,
  `cols` integer NOT NULL DEFAULT 0,
  `rows` integer NOT NULL DEFAULT 0,
  `col_gap` float NOT NULL DEFAULT 0,
  `row_gap` float NOT NULL DEFAULT 0,
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`template_id`)
);

DROP TABLE IF EXISTS `currency`;

--
-- Table: `currency`
--
CREATE TABLE `currency` (
  `currency` varchar(10) NOT NULL DEFAULT '',
  `symbol` varchar(5),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `rate` float(15, 5),
  `active` tinyint,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `default_borrower_circ_rules`;

--
-- Table: `default_borrower_circ_rules`
--
CREATE TABLE `default_borrower_circ_rules` (
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` integer,
  INDEX (`categorycode`),
  PRIMARY KEY (`categorycode`),
  CONSTRAINT `default_borrower_circ_rules_fk_categorycode` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `default_branch_circ_rules`;

--
-- Table: `default_branch_circ_rules`
--
CREATE TABLE `default_branch_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `maxissueqty` integer,
  `holdallowed` tinyint,
  INDEX (`branchcode`),
  PRIMARY KEY (`branchcode`),
  CONSTRAINT `default_branch_circ_rules_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `default_branch_item_rules`;

--
-- Table: `default_branch_item_rules`
--
CREATE TABLE `default_branch_item_rules` (
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint,
  INDEX (`itemtype`),
  PRIMARY KEY (`itemtype`),
  CONSTRAINT `default_branch_item_rules_fk_itemtype` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `default_circ_rules`;

--
-- Table: `default_circ_rules`
--
CREATE TABLE `default_circ_rules` (
  `singleton` enum('singleton') NOT NULL DEFAULT 'singleton',
  `maxissueqty` integer,
  `holdallowed` integer,
  PRIMARY KEY (`singleton`)
);

DROP TABLE IF EXISTS `deletedbiblio`;

--
-- Table: `deletedbiblio`
--
CREATE TABLE `deletedbiblio` (
  `biblionumber` integer NOT NULL DEFAULT 0,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint,
  `seriestitle` mediumtext,
  `copyrightdate` smallint,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`)
);

DROP TABLE IF EXISTS `deletedbiblioitems`;

--
-- Table: `deletedbiblioitems`
--
CREATE TABLE `deletedbiblioitems` (
  `biblioitemnumber` integer NOT NULL DEFAULT 0,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10),
  `isbn` varchar(30),
  `issn` varchar(9),
  `publicationyear` text,
  `publishercode` varchar(255),
  `volumedate` date,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `illus` varchar(255),
  `pages` varchar(255),
  `notes` mediumtext,
  `size` varchar(255),
  `place` varchar(255),
  `lccn` varchar(25),
  `marc` longblob,
  `url` varchar(255),
  `cn_source` varchar(10),
  `cn_class` varchar(30),
  `cn_item` varchar(10),
  `cn_suffix` varchar(10),
  `cn_sort` varchar(30),
  `totalissues` integer,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`biblioitemnumber`)
);

DROP TABLE IF EXISTS `deletedborrowers`;

--
-- Table: `deletedborrowers`
--
CREATE TABLE `deletedborrowers` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `cardnumber` varchar(16),
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10),
  `streettype` varchar(50),
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` mediumtext,
  `zipcode` varchar(25),
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50),
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `b_streetnumber` varchar(10),
  `b_streettype` varchar(50),
  `b_address` varchar(100),
  `b_address2` text,
  `b_city` mediumtext,
  `b_state` mediumtext,
  `b_zipcode` varchar(25),
  `b_country` text,
  `b_email` text,
  `b_phone` mediumtext,
  `dateofbirth` date,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10),
  `dateenrolled` date,
  `dateexpiry` date,
  `gonenoaddress` tinyint,
  `lost` tinyint,
  `debarred` tinyint,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` integer,
  `borrowernotes` mediumtext,
  `relationship` varchar(100),
  `ethnicity` varchar(50),
  `ethnotes` varchar(255),
  `sex` varchar(1),
  `password` varchar(30),
  `flags` integer,
  `userid` varchar(30),
  `opacnote` mediumtext,
  `contactnote` varchar(255),
  `sort1` varchar(80),
  `sort2` varchar(80),
  `altcontactfirstname` varchar(255),
  `altcontactsurname` varchar(255),
  `altcontactaddress1` varchar(255),
  `altcontactaddress2` varchar(255),
  `altcontactaddress3` varchar(255),
  `altcontactstate` mediumtext,
  `altcontactzipcode` varchar(50),
  `altcontactcountry` text,
  `altcontactphone` varchar(50),
  `smsalertnumber` varchar(50),
  `privacy` integer
);

DROP TABLE IF EXISTS `deleteditems`;

--
-- Table: `deleteditems`
--
CREATE TABLE `deleteditems` (
  `itemnumber` integer NOT NULL DEFAULT 0,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `biblioitemnumber` integer NOT NULL DEFAULT 0,
  `barcode` varchar(20),
  `dateaccessioned` date,
  `booksellerid` mediumtext,
  `homebranch` varchar(10),
  `price` decimal(8, 2),
  `replacementprice` decimal(8, 2),
  `replacementpricedate` date,
  `datelastborrowed` date,
  `datelastseen` date,
  `stack` tinyint,
  `notforloan` tinyint NOT NULL DEFAULT 0,
  `damaged` tinyint NOT NULL DEFAULT 0,
  `itemlost` tinyint NOT NULL DEFAULT 0,
  `wthdrawn` tinyint NOT NULL DEFAULT 0,
  `itemcallnumber` varchar(255),
  `issues` smallint,
  `renewals` smallint,
  `reserves` smallint,
  `restricted` tinyint,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10),
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `location` varchar(80),
  `permanent_location` varchar(80),
  `onloan` date,
  `cn_source` varchar(10),
  `cn_sort` varchar(30),
  `ccode` varchar(10),
  `materials` varchar(10),
  `uri` varchar(255),
  `itype` varchar(10),
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32),
  `marc` longblob,
  `stocknumber` varchar(32),
  PRIMARY KEY (`itemnumber`),
  UNIQUE `deleteditemsstocknumberidx` (`stocknumber`)
);

DROP TABLE IF EXISTS `ethnicity`;

--
-- Table: `ethnicity`
--
CREATE TABLE `ethnicity` (
  `code` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(255),
  PRIMARY KEY (`code`)
);

DROP TABLE IF EXISTS `export_format`;

--
-- Table: `export_format`
--
CREATE TABLE `export_format` (
  `export_format_id` integer NOT NULL auto_increment,
  `profile` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `marcfields` mediumtext NOT NULL,
  `csv_separator` varchar(2) NOT NULL,
  `field_separator` varchar(2) NOT NULL,
  `subfield_separator` varchar(2) NOT NULL,
  `encoding` varchar(255) NOT NULL,
  PRIMARY KEY (`export_format_id`)
);

DROP TABLE IF EXISTS `fieldmapping`;

--
-- Table: `fieldmapping`
--
CREATE TABLE `fieldmapping` (
  `id` integer NOT NULL auto_increment,
  `field` varchar(255) NOT NULL,
  `frameworkcode` char(4) NOT NULL DEFAULT '',
  `fieldcode` char(3) NOT NULL,
  `subfieldcode` char(1) NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `hold_fill_targets`;

--
-- Table: `hold_fill_targets`
--
CREATE TABLE `hold_fill_targets` (
  `borrowernumber` integer NOT NULL,
  `biblionumber` integer NOT NULL,
  `itemnumber` integer NOT NULL,
  `source_branchcode` varchar(10),
  `item_level_request` tinyint NOT NULL DEFAULT 0,
  INDEX `hold_fill_targets_idx_biblionumber` (`biblionumber`),
  INDEX `hold_fill_targets_idx_borrowernumber` (`borrowernumber`),
  INDEX `hold_fill_targets_idx_source_branchcode` (`source_branchcode`),
  INDEX (`itemnumber`),
  PRIMARY KEY (`itemnumber`),
  CONSTRAINT `hold_fill_targets_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_fk_source_branchcode` FOREIGN KEY (`source_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `import_batches`;

--
-- Table: `import_batches`
--
CREATE TABLE `import_batches` (
  `import_batch_id` integer NOT NULL auto_increment,
  `matcher_id` integer,
  `template_id` integer,
  `branchcode` varchar(10),
  `num_biblios` integer NOT NULL DEFAULT 0,
  `num_items` integer NOT NULL DEFAULT 0,
  `upload_timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `overlay_action` enum('replace', 'create_new', 'use_template', 'ignore') NOT NULL DEFAULT 'create_new',
  `nomatch_action` enum('create_new', 'ignore') NOT NULL DEFAULT 'create_new',
  `item_action` enum('always_add', 'add_only_for_matches', 'add_only_for_new', 'ignore') NOT NULL DEFAULT 'always_add',
  `import_status` enum('staging', 'staged', 'importing', 'imported', 'reverting', 'reverted', 'cleaned') NOT NULL DEFAULT 'staging',
  `batch_type` enum('batch', 'z3950') NOT NULL DEFAULT 'batch',
  `file_name` varchar(100),
  `comments` mediumtext,
  PRIMARY KEY (`import_batch_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `import_biblios`;

--
-- Table: `import_biblios`
--
CREATE TABLE `import_biblios` (
  `import_record_id` integer NOT NULL,
  `matched_biblionumber` integer,
  `control_number` varchar(25),
  `original_source` varchar(25),
  `title` varchar(128),
  `author` varchar(80),
  `isbn` varchar(30),
  `issn` varchar(9),
  `has_items` tinyint NOT NULL DEFAULT 0,
  INDEX `import_biblios_idx_import_record_id` (`import_record_id`),
  CONSTRAINT `import_biblios_fk_import_record_id` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `import_items`;

--
-- Table: `import_items`
--
CREATE TABLE `import_items` (
  `import_items_id` integer NOT NULL auto_increment,
  `import_record_id` integer NOT NULL,
  `itemnumber` integer,
  `branchcode` varchar(10),
  `status` enum('error', 'staged', 'imported', 'reverted', 'ignored') NOT NULL DEFAULT 'staged',
  `marcxml` longtext NOT NULL,
  `import_error` mediumtext,
  INDEX `import_items_idx_import_record_id` (`import_record_id`),
  PRIMARY KEY (`import_items_id`),
  CONSTRAINT `import_items_fk_import_record_id` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `import_record_matches`;

--
-- Table: `import_record_matches`
--
CREATE TABLE `import_record_matches` (
  `import_record_id` integer NOT NULL,
  `candidate_match_id` integer NOT NULL,
  `score` integer NOT NULL DEFAULT 0,
  INDEX `import_record_matches_idx_import_record_id` (`import_record_id`),
  CONSTRAINT `import_record_matches_fk_import_record_id` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `import_records`;

--
-- Table: `import_records`
--
CREATE TABLE `import_records` (
  `import_record_id` integer NOT NULL auto_increment,
  `import_batch_id` integer NOT NULL,
  `branchcode` varchar(10),
  `record_sequence` integer NOT NULL DEFAULT 0,
  `upload_timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `import_date` date,
  `marc` longblob NOT NULL,
  `marcxml` longtext NOT NULL,
  `marcxml_old` longtext NOT NULL,
  `record_type` enum('biblio', 'auth', 'holdings') NOT NULL DEFAULT 'biblio',
  `overlay_status` enum('no_match', 'auto_match', 'manual_match', 'match_applied') NOT NULL DEFAULT 'no_match',
  `status` enum('error', 'staged', 'imported', 'reverted', 'items_reverted', 'ignored') NOT NULL DEFAULT 'staged',
  `import_error` mediumtext,
  `encoding` varchar(40) NOT NULL DEFAULT '',
  `z3950random` varchar(40),
  INDEX `import_records_idx_import_batch_id` (`import_batch_id`),
  PRIMARY KEY (`import_record_id`),
  CONSTRAINT `import_records_fk_import_batch_id` FOREIGN KEY (`import_batch_id`) REFERENCES `import_batches` (`import_batch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `issues`;

--
-- Table: `issues`
--
CREATE TABLE `issues` (
  `borrowernumber` integer,
  `itemnumber` integer,
  `date_due` date,
  `branchcode` varchar(10),
  `issuingbranch` varchar(18),
  `returndate` date,
  `lastreneweddate` date,
  `return` varchar(4),
  `renewals` tinyint,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `issuedate` date,
  INDEX `issues_idx_borrowernumber` (`borrowernumber`),
  INDEX `issues_idx_itemnumber` (`itemnumber`),
  CONSTRAINT `issues_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `issues_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `issuingrules`;

--
-- Table: `issuingrules`
--
CREATE TABLE `issuingrules` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `restrictedtype` tinyint,
  `rentaldiscount` decimal(28, 6),
  `reservecharge` decimal(28, 6),
  `fine` decimal(28, 6),
  `finedays` integer,
  `firstremind` integer,
  `chargeperiod` integer,
  `accountsent` integer,
  `chargename` varchar(100),
  `maxissueqty` integer,
  `issuelength` integer,
  `hardduedate` date,
  `hardduedatecompare` tinyint NOT NULL DEFAULT 0,
  `renewalsallowed` smallint NOT NULL DEFAULT 0,
  `reservesallowed` smallint NOT NULL DEFAULT 0,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`, `categorycode`, `itemtype`)
);

DROP TABLE IF EXISTS `item_circulation_alert_preferences`;

--
-- Table: `item_circulation_alert_preferences`
--
CREATE TABLE `item_circulation_alert_preferences` (
  `id` integer NOT NULL auto_increment,
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `item_type` varchar(10) NOT NULL,
  `notification` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `itemdeletelist`;

--
-- Table: `itemdeletelist`
--
CREATE TABLE `itemdeletelist` (
  `list_id` integer NOT NULL,
  `itemnumber` integer NOT NULL,
  `biblionumber` integer NOT NULL,
  PRIMARY KEY (`list_id`, `itemnumber`)
);

DROP TABLE IF EXISTS `items`;

--
-- Table: `items`
--
CREATE TABLE `items` (
  `itemnumber` integer NOT NULL auto_increment,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `biblioitemnumber` integer NOT NULL DEFAULT 0,
  `barcode` varchar(20),
  `dateaccessioned` date,
  `booksellerid` mediumtext,
  `homebranch` varchar(10),
  `price` decimal(8, 2),
  `replacementprice` decimal(8, 2),
  `replacementpricedate` date,
  `datelastborrowed` date,
  `datelastseen` date,
  `stack` tinyint,
  `notforloan` tinyint NOT NULL DEFAULT 0,
  `damaged` tinyint NOT NULL DEFAULT 0,
  `itemlost` tinyint NOT NULL DEFAULT 0,
  `wthdrawn` tinyint NOT NULL DEFAULT 0,
  `itemcallnumber` varchar(255),
  `issues` smallint,
  `renewals` smallint,
  `reserves` smallint,
  `restricted` tinyint,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10),
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `location` varchar(80),
  `permanent_location` varchar(80),
  `onloan` date,
  `cn_source` varchar(10),
  `cn_sort` varchar(30),
  `ccode` varchar(10),
  `materials` varchar(10),
  `uri` varchar(255),
  `itype` varchar(10),
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32),
  `stocknumber` varchar(32),
  INDEX `items_idx_biblioitemnumber` (`biblioitemnumber`),
  INDEX `items_idx_holdingbranch` (`holdingbranch`),
  INDEX `items_idx_homebranch` (`homebranch`),
  PRIMARY KEY (`itemnumber`),
  UNIQUE `itembarcodeidx` (`barcode`),
  CONSTRAINT `items_fk_biblioitemnumber` FOREIGN KEY (`biblioitemnumber`) REFERENCES `biblioitems` (`biblioitemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `items_fk_holdingbranch` FOREIGN KEY (`holdingbranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `items_fk_homebranch` FOREIGN KEY (`homebranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `itemtypes`;

--
-- Table: `itemtypes`
--
CREATE TABLE `itemtypes` (
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `rentalcharge` double precision(16, 4),
  `notforloan` smallint,
  `imageurl` varchar(200),
  `summary` text,
  PRIMARY KEY (`itemtype`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `labels_batches`;

--
-- Table: `labels_batches`
--
CREATE TABLE `labels_batches` (
  `label_id` integer NOT NULL auto_increment,
  `batch_id` integer NOT NULL DEFAULT 1,
  `item_number` integer NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `branch_code` varchar(10) NOT NULL DEFAULT 'NB',
  INDEX `labels_batches_idx_branch_code` (`branch_code`),
  INDEX `labels_batches_idx_item_number` (`item_number`),
  PRIMARY KEY (`label_id`),
  CONSTRAINT `labels_batches_fk_branch_code` FOREIGN KEY (`branch_code`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `labels_batches_fk_item_number` FOREIGN KEY (`item_number`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `labels_layouts`;

--
-- Table: `labels_layouts`
--
CREATE TABLE `labels_layouts` (
  `layout_id` integer NOT NULL auto_increment,
  `barcode_type` char(100) NOT NULL DEFAULT 'CODE39',
  `printing_type` char(32) NOT NULL DEFAULT 'BAR',
  `layout_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  `guidebox` integer DEFAULT 0,
  `font` char(10) NOT NULL DEFAULT 'TR',
  `font_size` integer NOT NULL DEFAULT 10,
  `callnum_split` integer DEFAULT 0,
  `text_justify` char(1) NOT NULL DEFAULT 'L',
  `format_string` varchar(210) NOT NULL DEFAULT 'barcode',
  PRIMARY KEY (`layout_id`)
);

DROP TABLE IF EXISTS `labels_templates`;

--
-- Table: `labels_templates`
--
CREATE TABLE `labels_templates` (
  `template_id` integer NOT NULL auto_increment,
  `profile_id` integer,
  `template_code` char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  `template_desc` char(100) NOT NULL DEFAULT 'Default description',
  `page_width` float NOT NULL DEFAULT 0,
  `page_height` float NOT NULL DEFAULT 0,
  `label_width` float NOT NULL DEFAULT 0,
  `label_height` float NOT NULL DEFAULT 0,
  `top_text_margin` float NOT NULL DEFAULT 0,
  `left_text_margin` float NOT NULL DEFAULT 0,
  `top_margin` float NOT NULL DEFAULT 0,
  `left_margin` float NOT NULL DEFAULT 0,
  `cols` integer NOT NULL DEFAULT 0,
  `rows` integer NOT NULL DEFAULT 0,
  `col_gap` float NOT NULL DEFAULT 0,
  `row_gap` float NOT NULL DEFAULT 0,
  `units` char(20) NOT NULL DEFAULT 'POINT',
  PRIMARY KEY (`template_id`)
);

DROP TABLE IF EXISTS `language_descriptions`;

--
-- Table: `language_descriptions`
--
CREATE TABLE `language_descriptions` (
  `subtag` varchar(25),
  `type` varchar(25),
  `lang` varchar(25),
  `description` varchar(255),
  `id` integer NOT NULL auto_increment,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `language_rfc4646_to_iso639`;

--
-- Table: `language_rfc4646_to_iso639`
--
CREATE TABLE `language_rfc4646_to_iso639` (
  `rfc4646_subtag` varchar(25),
  `iso639_2_code` varchar(25),
  `id` integer NOT NULL auto_increment,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `language_script_bidi`;

--
-- Table: `language_script_bidi`
--
CREATE TABLE `language_script_bidi` (
  `rfc4646_subtag` varchar(25),
  `bidi` varchar(3)
);

DROP TABLE IF EXISTS `language_script_mapping`;

--
-- Table: `language_script_mapping`
--
CREATE TABLE `language_script_mapping` (
  `language_subtag` varchar(25),
  `script_subtag` varchar(25)
);

DROP TABLE IF EXISTS `language_subtag_registry`;

--
-- Table: `language_subtag_registry`
--
CREATE TABLE `language_subtag_registry` (
  `subtag` varchar(25),
  `type` varchar(25),
  `description` varchar(25),
  `added` date,
  `id` integer NOT NULL auto_increment,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `letter`;

--
-- Table: `letter`
--
CREATE TABLE `letter` (
  `module` varchar(20) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text,
  PRIMARY KEY (`module`, `code`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `marc_matchers`;

--
-- Table: `marc_matchers`
--
CREATE TABLE `marc_matchers` (
  `matcher_id` integer NOT NULL auto_increment,
  `code` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `record_type` varchar(10) NOT NULL DEFAULT 'biblio',
  `threshold` integer NOT NULL DEFAULT 0,
  PRIMARY KEY (`matcher_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `marc_subfield_structure`;

--
-- Table: `marc_subfield_structure`
--
CREATE TABLE `marc_subfield_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint NOT NULL DEFAULT 0,
  `mandatory` tinyint NOT NULL DEFAULT 0,
  `kohafield` varchar(40),
  `tab` tinyint,
  `authorised_value` varchar(20),
  `authtypecode` varchar(20),
  `value_builder` varchar(80),
  `isurl` tinyint,
  `hidden` tinyint,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `seealso` text,
  `link` varchar(80),
  `defaultvalue` text,
  PRIMARY KEY (`frameworkcode`, `tagfield`, `tagsubfield`)
);

DROP TABLE IF EXISTS `marc_tag_structure`;

--
-- Table: `marc_tag_structure`
--
CREATE TABLE `marc_tag_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint NOT NULL DEFAULT 0,
  `mandatory` tinyint NOT NULL DEFAULT 0,
  `authorised_value` varchar(10),
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`, `tagfield`)
);

DROP TABLE IF EXISTS `matchchecks`;

--
-- Table: `matchchecks`
--
CREATE TABLE `matchchecks` (
  `matcher_id` integer NOT NULL,
  `matchcheck_id` integer NOT NULL auto_increment,
  `source_matchpoint_id` integer NOT NULL,
  `target_matchpoint_id` integer NOT NULL,
  INDEX `matchchecks_idx_matcher_id` (`matcher_id`),
  INDEX `matchchecks_idx_source_matchpoint_id` (`source_matchpoint_id`),
  INDEX `matchchecks_idx_target_matchpoint_id` (`target_matchpoint_id`),
  PRIMARY KEY (`matchcheck_id`),
  CONSTRAINT `matchchecks_fk_matcher_id` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matchchecks_fk_source_matchpoint_id` FOREIGN KEY (`source_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matchchecks_fk_target_matchpoint_id` FOREIGN KEY (`target_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `matcher_matchpoints`;

--
-- Table: `matcher_matchpoints`
--
CREATE TABLE `matcher_matchpoints` (
  `matcher_id` integer NOT NULL,
  `matchpoint_id` integer NOT NULL,
  INDEX `matcher_matchpoints_idx_matcher_id` (`matcher_id`),
  INDEX `matcher_matchpoints_idx_matchpoint_id` (`matchpoint_id`),
  CONSTRAINT `matcher_matchpoints_fk_matcher_id` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchpoints_fk_matchpoint_id` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `matchpoint_component_norms`;

--
-- Table: `matchpoint_component_norms`
--
CREATE TABLE `matchpoint_component_norms` (
  `matchpoint_component_id` integer NOT NULL,
  `sequence` integer NOT NULL DEFAULT 0,
  `norm_routine` varchar(50) NOT NULL DEFAULT '',
  INDEX `matchpoint_component_norms_idx_matchpoint_component_id` (`matchpoint_component_id`),
  CONSTRAINT `matchpoint_component_norms_fk_matchpoint_component_id` FOREIGN KEY (`matchpoint_component_id`) REFERENCES `matchpoint_components` (`matchpoint_component_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `matchpoint_components`;

--
-- Table: `matchpoint_components`
--
CREATE TABLE `matchpoint_components` (
  `matchpoint_id` integer NOT NULL,
  `matchpoint_component_id` integer NOT NULL auto_increment,
  `sequence` integer NOT NULL DEFAULT 0,
  `tag` varchar(3) NOT NULL DEFAULT '',
  `subfields` varchar(40) NOT NULL DEFAULT '',
  `offset` integer NOT NULL DEFAULT 0,
  `length` integer NOT NULL DEFAULT 0,
  INDEX `matchpoint_components_idx_matchpoint_id` (`matchpoint_id`),
  PRIMARY KEY (`matchpoint_component_id`),
  CONSTRAINT `matchpoint_components_fk_matchpoint_id` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `matchpoints`;

--
-- Table: `matchpoints`
--
CREATE TABLE `matchpoints` (
  `matcher_id` integer NOT NULL,
  `matchpoint_id` integer NOT NULL auto_increment,
  `search_index` varchar(30) NOT NULL DEFAULT '',
  `score` integer NOT NULL DEFAULT 0,
  INDEX `matchpoints_idx_matcher_id` (`matcher_id`),
  PRIMARY KEY (`matchpoint_id`),
  CONSTRAINT `matchpoints_fk_matcher_id` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `message_attributes`;

--
-- Table: `message_attributes`
--
CREATE TABLE `message_attributes` (
  `message_attribute_id` integer NOT NULL auto_increment,
  `message_name` varchar(40),
  `takes_days` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`message_attribute_id`),
  UNIQUE `message_name` (`message_name`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `message_queue`;

--
-- Table: `message_queue`
--
CREATE TABLE `message_queue` (
  `message_id` integer NOT NULL auto_increment,
  `borrowernumber` integer,
  `subject` text,
  `content` text,
  `metadata` text,
  `letter_code` varchar(64),
  `message_transport_type` varchar(20) NOT NULL,
  `status` enum('sent', 'pending', 'failed', 'deleted') NOT NULL DEFAULT 'pending',
  `time_queued` timestamp NOT NULL DEFAULT current_timestamp,
  `to_address` mediumtext,
  `from_address` mediumtext,
  `content_type` text,
  INDEX `message_queue_idx_borrowernumber` (`borrowernumber`),
  INDEX `message_queue_idx_message_transport_type` (`message_transport_type`),
  CONSTRAINT `message_queue_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_queue_fk_message_transport_type` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `message_transport_types`;

--
-- Table: `message_transport_types`
--
CREATE TABLE `message_transport_types` (
  `message_transport_type` varchar(20) NOT NULL,
  PRIMARY KEY (`message_transport_type`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `message_transports`;

--
-- Table: `message_transports`
--
CREATE TABLE `message_transports` (
  `message_attribute_id` integer NOT NULL,
  `message_transport_type` varchar(20) NOT NULL,
  `is_digest` tinyint NOT NULL DEFAULT 0,
  `letter_module` varchar(20) NOT NULL DEFAULT '',
  `letter_code` varchar(20) NOT NULL DEFAULT '',
  INDEX `message_transports_idx_letter_module_letter_code` (`letter_module`, `letter_code`),
  INDEX `message_transports_idx_message_attribute_id` (`message_attribute_id`),
  INDEX `message_transports_idx_message_transport_type` (`message_transport_type`),
  PRIMARY KEY (`message_attribute_id`, `message_transport_type`, `is_digest`),
  CONSTRAINT `message_transports_fk_letter_module_letter_code` FOREIGN KEY (`letter_module`, `letter_code`) REFERENCES `letter` (`module`, `code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_fk_message_attribute_id` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_fk_message_transport_type` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `messages`;

--
-- Table: `messages`
--
CREATE TABLE `messages` (
  `message_id` integer NOT NULL auto_increment,
  `borrowernumber` integer NOT NULL,
  `branchcode` varchar(10),
  `message_type` varchar(1) NOT NULL,
  `message` text NOT NULL,
  `message_date` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`message_id`)
);

DROP TABLE IF EXISTS `notifys`;

--
-- Table: `notifys`
--
CREATE TABLE `notifys` (
  `notify_id` integer NOT NULL DEFAULT 0,
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `itemnumber` integer NOT NULL DEFAULT 0,
  `notify_date` date,
  `notify_send_date` date,
  `notify_level` integer NOT NULL DEFAULT 0,
  `method` varchar(20) NOT NULL DEFAULT ''
);

DROP TABLE IF EXISTS `nozebra`;

--
-- Table: `nozebra`
--
CREATE TABLE `nozebra` (
  `server` varchar(20) NOT NULL,
  `indexname` varchar(40) NOT NULL,
  `value` varchar(250) NOT NULL,
  `biblionumbers` longtext NOT NULL
);

DROP TABLE IF EXISTS `old_issues`;

--
-- Table: `old_issues`
--
CREATE TABLE `old_issues` (
  `borrowernumber` integer,
  `itemnumber` integer,
  `date_due` date,
  `branchcode` varchar(10),
  `issuingbranch` varchar(18),
  `returndate` date,
  `lastreneweddate` date,
  `return` varchar(4),
  `renewals` tinyint,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `issuedate` date,
  INDEX `old_issues_idx_borrowernumber` (`borrowernumber`),
  INDEX `old_issues_idx_itemnumber` (`itemnumber`),
  CONSTRAINT `old_issues_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `old_issues_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `old_reserves`;

--
-- Table: `old_reserves`
--
CREATE TABLE `old_reserves` (
  `borrowernumber` integer,
  `reservedate` date,
  `biblionumber` integer,
  `constrainttype` varchar(1),
  `branchcode` varchar(10),
  `notificationdate` date,
  `reminderdate` date,
  `cancellationdate` date,
  `reservenotes` mediumtext,
  `priority` smallint,
  `found` varchar(1),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `itemnumber` integer,
  `waitingdate` date,
  `expirationdate` date,
  `lowestpriority` tinyint NOT NULL,
  INDEX `old_reserves_idx_biblionumber` (`biblionumber`),
  INDEX `old_reserves_idx_borrowernumber` (`borrowernumber`),
  INDEX `old_reserves_idx_itemnumber` (`itemnumber`),
  CONSTRAINT `old_reserves_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `old_reserves_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `old_reserves_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `opac_news`;

--
-- Table: `opac_news`
--
CREATE TABLE `opac_news` (
  `idnew` integer unsigned NOT NULL auto_increment,
  `title` varchar(250) NOT NULL DEFAULT '',
  `new` text NOT NULL,
  `lang` varchar(25) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `expirationdate` date,
  `number` integer,
  PRIMARY KEY (`idnew`)
);

DROP TABLE IF EXISTS `overduerules`;

--
-- Table: `overduerules`
--
CREATE TABLE `overduerules` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `delay1` integer,
  `letter1` varchar(20),
  `debarred1` varchar(1) DEFAULT '0',
  `delay2` integer,
  `debarred2` varchar(1) DEFAULT '0',
  `letter2` varchar(20),
  `delay3` integer,
  `letter3` varchar(20),
  `debarred3` integer DEFAULT 0,
  PRIMARY KEY (`branchcode`, `categorycode`)
);

DROP TABLE IF EXISTS `patroncards`;

--
-- Table: `patroncards`
--
CREATE TABLE `patroncards` (
  `cardid` integer NOT NULL auto_increment,
  `batch_id` varchar(10) NOT NULL DEFAULT '1',
  `borrowernumber` integer NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  INDEX `patroncards_idx_borrowernumber` (`borrowernumber`),
  PRIMARY KEY (`cardid`),
  CONSTRAINT `patroncards_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `patronimage`;

--
-- Table: `patronimage`
--
CREATE TABLE `patronimage` (
  `cardnumber` varchar(16) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  PRIMARY KEY (`cardnumber`)
);

DROP TABLE IF EXISTS `permissions`;

--
-- Table: `permissions`
--
CREATE TABLE `permissions` (
  `module_bit` integer NOT NULL DEFAULT 0,
  `code` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255),
  INDEX `permissions_idx_module_bit` (`module_bit`),
  PRIMARY KEY (`module_bit`, `code`),
  CONSTRAINT `permissions_fk_module_bit` FOREIGN KEY (`module_bit`) REFERENCES `userflags` (`bit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `printers`;

--
-- Table: `printers`
--
CREATE TABLE `printers` (
  `printername` varchar(40) NOT NULL DEFAULT '',
  `printqueue` varchar(20),
  `printtype` varchar(20),
  PRIMARY KEY (`printername`)
);

DROP TABLE IF EXISTS `printers_profile`;

--
-- Table: `printers_profile`
--
CREATE TABLE `printers_profile` (
  `profile_id` integer NOT NULL auto_increment,
  `printer_name` varchar(40) NOT NULL DEFAULT 'Default Printer',
  `template_id` integer NOT NULL DEFAULT 0,
  `paper_bin` varchar(20) NOT NULL DEFAULT 'Bypass',
  `offset_horz` float NOT NULL DEFAULT 0,
  `offset_vert` float NOT NULL DEFAULT 0,
  `creep_horz` float NOT NULL DEFAULT 0,
  `creep_vert` float NOT NULL DEFAULT 0,
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`profile_id`),
  UNIQUE `printername` (`printer_name`, `template_id`, `paper_bin`, `creator`)
);

DROP TABLE IF EXISTS `repeatable_holidays`;

--
-- Table: `repeatable_holidays`
--
CREATE TABLE `repeatable_holidays` (
  `id` integer NOT NULL auto_increment,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `weekday` smallint,
  `day` smallint,
  `month` smallint,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `reports_dictionary`;

--
-- Table: `reports_dictionary`
--
CREATE TABLE `reports_dictionary` (
  `id` integer NOT NULL auto_increment,
  `name` varchar(255),
  `description` text,
  `date_created` datetime,
  `date_modified` datetime,
  `saved_sql` text,
  `area` integer,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `reserveconstraints`;

--
-- Table: `reserveconstraints`
--
CREATE TABLE `reserveconstraints` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `reservedate` date,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `biblioitemnumber` integer,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp
);

DROP TABLE IF EXISTS `reserves`;

--
-- Table: `reserves`
--
CREATE TABLE `reserves` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `reservedate` date,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `constrainttype` varchar(1),
  `branchcode` varchar(10),
  `notificationdate` date,
  `reminderdate` date,
  `cancellationdate` date,
  `reservenotes` mediumtext,
  `priority` smallint,
  `found` varchar(1),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp,
  `itemnumber` integer,
  `waitingdate` date,
  `expirationdate` date,
  `lowestpriority` tinyint NOT NULL,
  INDEX `reserves_idx_biblionumber` (`biblionumber`),
  INDEX `reserves_idx_borrowernumber` (`borrowernumber`),
  INDEX `reserves_idx_branchcode` (`branchcode`),
  INDEX `reserves_idx_itemnumber` (`itemnumber`),
  CONSTRAINT `reserves_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_fk_itemnumber` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `reviews`;

--
-- Table: `reviews`
--
CREATE TABLE `reviews` (
  `reviewid` integer NOT NULL auto_increment,
  `borrowernumber` integer,
  `biblionumber` integer,
  `review` text,
  `approved` tinyint,
  `datereviewed` datetime,
  PRIMARY KEY (`reviewid`)
);

DROP TABLE IF EXISTS `roadtype`;

--
-- Table: `roadtype`
--
CREATE TABLE `roadtype` (
  `roadtypeid` integer NOT NULL auto_increment,
  `road_type` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`roadtypeid`)
);

DROP TABLE IF EXISTS `saved_reports`;

--
-- Table: `saved_reports`
--
CREATE TABLE `saved_reports` (
  `id` integer NOT NULL auto_increment,
  `report_id` integer,
  `report` longtext,
  `date_run` datetime,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `saved_sql`;

--
-- Table: `saved_sql`
--
CREATE TABLE `saved_sql` (
  `id` integer NOT NULL auto_increment,
  `borrowernumber` integer,
  `date_created` datetime,
  `last_modified` datetime,
  `savedsql` text,
  `last_run` datetime,
  `report_name` varchar(255),
  `type` varchar(255),
  `notes` text,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `search_history`;

--
-- Table: `search_history`
--
CREATE TABLE `search_history` (
  `userid` integer NOT NULL,
  `sessionid` varchar(32) NOT NULL,
  `query_desc` varchar(255) NOT NULL,
  `query_cgi` varchar(255) NOT NULL,
  `total` integer NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp
);

DROP TABLE IF EXISTS `serial`;

--
-- Table: `serial`
--
CREATE TABLE `serial` (
  `serialid` integer NOT NULL auto_increment,
  `biblionumber` varchar(100) NOT NULL DEFAULT '',
  `subscriptionid` varchar(100) NOT NULL DEFAULT '',
  `serialseq` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint NOT NULL DEFAULT 0,
  `planneddate` date,
  `notes` text,
  `publisheddate` date,
  `itemnumber` text,
  `claimdate` date,
  `routingnotes` text,
  PRIMARY KEY (`serialid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `serialitems`;

--
-- Table: `serialitems`
--
CREATE TABLE `serialitems` (
  `itemnumber` integer NOT NULL,
  `serialid` integer NOT NULL,
  INDEX `serialitems_idx_serialid` (`serialid`),
  UNIQUE `serialitemsidx` (`itemnumber`),
  CONSTRAINT `serialitems_fk_serialid` FOREIGN KEY (`serialid`) REFERENCES `serial` (`serialid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `services_throttle`;

--
-- Table: `services_throttle`
--
CREATE TABLE `services_throttle` (
  `service_type` varchar(10) NOT NULL DEFAULT '',
  `service_count` varchar(45),
  PRIMARY KEY (`service_type`)
);

DROP TABLE IF EXISTS `sessions`;

--
-- Table: `sessions`
--
CREATE TABLE `sessions` (
  `id` varchar(32) NOT NULL,
  `a_session` text NOT NULL,
  UNIQUE `id` (`id`)
);

DROP TABLE IF EXISTS `special_holidays`;

--
-- Table: `special_holidays`
--
CREATE TABLE `special_holidays` (
  `id` integer NOT NULL auto_increment,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `day` smallint NOT NULL DEFAULT 0,
  `month` smallint NOT NULL DEFAULT 0,
  `year` smallint NOT NULL DEFAULT 0,
  `isexception` smallint NOT NULL DEFAULT 1,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `stat_from_marcxml`;

--
-- Table: `stat_from_marcxml`
--
CREATE TABLE `stat_from_marcxml` (
  `biblionumber` integer NOT NULL DEFAULT 0,
  `itemtype` varchar(1),
  `cataloguerm` longtext,
  `cataloguers` longtext,
  `insertdate` varchar(6),
  `modifydate` varchar(8),
  `accessionno` longtext,
  `isbn` longtext,
  `issn` longtext,
  `callnumber` longtext,
  `title` longtext
);

DROP TABLE IF EXISTS `statistics`;

--
-- Table: `statistics`
--
CREATE TABLE `statistics` (
  `datetime` datetime,
  `branch` varchar(10),
  `proccode` varchar(4),
  `value` double precision(16, 4),
  `type` varchar(16),
  `other` mediumtext,
  `usercode` varchar(10),
  `itemnumber` integer,
  `itemtype` varchar(10),
  `borrowernumber` integer,
  `associatedborrower` integer
);

DROP TABLE IF EXISTS `stopwords`;

--
-- Table: `stopwords`
--
CREATE TABLE `stopwords` (
  `word` varchar(255)
);

DROP TABLE IF EXISTS `subscription`;

--
-- Table: `subscription`
--
CREATE TABLE `subscription` (
  `biblionumber` integer NOT NULL DEFAULT 0,
  `subscriptionid` integer NOT NULL auto_increment,
  `librarian` varchar(100) DEFAULT '',
  `startdate` date,
  `aqbooksellerid` integer DEFAULT 0,
  `cost` integer DEFAULT 0,
  `aqbudgetid` integer DEFAULT 0,
  `weeklength` integer DEFAULT 0,
  `monthlength` integer DEFAULT 0,
  `numberlength` integer DEFAULT 0,
  `periodicity` tinyint DEFAULT 0,
  `dow` varchar(100) DEFAULT '',
  `numberingmethod` varchar(100) DEFAULT '',
  `notes` mediumtext,
  `status` varchar(100) NOT NULL DEFAULT '',
  `add1` integer DEFAULT 0,
  `every1` integer DEFAULT 0,
  `whenmorethan1` integer DEFAULT 0,
  `setto1` integer,
  `lastvalue1` integer,
  `add2` integer DEFAULT 0,
  `every2` integer DEFAULT 0,
  `whenmorethan2` integer DEFAULT 0,
  `setto2` integer,
  `lastvalue2` integer,
  `add3` integer DEFAULT 0,
  `every3` integer DEFAULT 0,
  `innerloop1` integer DEFAULT 0,
  `innerloop2` integer DEFAULT 0,
  `innerloop3` integer DEFAULT 0,
  `whenmorethan3` integer DEFAULT 0,
  `setto3` integer,
  `lastvalue3` integer,
  `issuesatonce` tinyint NOT NULL DEFAULT 1,
  `firstacquidate` date,
  `manualhistory` tinyint NOT NULL DEFAULT 0,
  `irregularity` text,
  `letter` varchar(20),
  `numberpattern` tinyint DEFAULT 0,
  `distributedto` text,
  `internalnotes` longtext,
  `callnumber` text,
  `location` varchar(80) DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `hemisphere` tinyint DEFAULT 0,
  `lastbranch` varchar(10),
  `serialsadditems` tinyint NOT NULL DEFAULT 0,
  `staffdisplaycount` varchar(10),
  `opacdisplaycount` varchar(10),
  `graceperiod` integer NOT NULL DEFAULT 0,
  `enddate` date,
  PRIMARY KEY (`subscriptionid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `subscriptionhistory`;

--
-- Table: `subscriptionhistory`
--
CREATE TABLE `subscriptionhistory` (
  `biblionumber` integer NOT NULL DEFAULT 0,
  `subscriptionid` integer NOT NULL DEFAULT 0,
  `histstartdate` date,
  `histenddate` date,
  `missinglist` longtext NOT NULL,
  `recievedlist` longtext NOT NULL,
  `opacnote` varchar(150) NOT NULL DEFAULT '',
  `librariannote` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`subscriptionid`)
);

DROP TABLE IF EXISTS `subscriptionroutinglist`;

--
-- Table: `subscriptionroutinglist`
--
CREATE TABLE `subscriptionroutinglist` (
  `routingid` integer NOT NULL auto_increment,
  `borrowernumber` integer NOT NULL,
  `ranking` integer,
  `subscriptionid` integer NOT NULL,
  INDEX `subscriptionroutinglist_idx_borrowernumber` (`borrowernumber`),
  INDEX `subscriptionroutinglist_idx_subscriptionid` (`subscriptionid`),
  PRIMARY KEY (`routingid`),
  UNIQUE `subscriptionid` (`subscriptionid`, `borrowernumber`),
  CONSTRAINT `subscriptionroutinglist_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptionroutinglist_fk_subscriptionid` FOREIGN KEY (`subscriptionid`) REFERENCES `subscription` (`subscriptionid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `suggestions`;

--
-- Table: `suggestions`
--
CREATE TABLE `suggestions` (
  `suggestionid` integer NOT NULL auto_increment,
  `suggestedby` integer NOT NULL DEFAULT 0,
  `managedby` integer,
  `status` varchar(10) NOT NULL DEFAULT '',
  `note` mediumtext,
  `author` varchar(80),
  `title` varchar(80),
  `copyrightdate` smallint,
  `publishercode` varchar(255),
  `date` timestamp NOT NULL DEFAULT current_timestamp,
  `volumedesc` varchar(255),
  `publicationyear` smallint DEFAULT 0,
  `place` varchar(255),
  `isbn` varchar(30),
  `mailoverseeing` smallint DEFAULT 0,
  `biblionumber` integer,
  `reason` text,
  `budgetid` integer,
  `branchcode` varchar(10),
  `acceptedby` integer,
  `accepteddate` date,
  `suggesteddate` date,
  `manageddate` date,
  `rejectedby` integer,
  `rejecteddate` date,
  `collectiontitle` text,
  `itemtype` varchar(30),
  `quantity` smallint,
  `currency` varchar(3),
  `price` decimal(28, 6),
  `total` decimal(28, 6),
  PRIMARY KEY (`suggestionid`)
);

DROP TABLE IF EXISTS `systempreferences`;

--
-- Table: `systempreferences`
--
CREATE TABLE `systempreferences` (
  `variable` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  `options` mediumtext,
  `explanation` text,
  `type` varchar(20),
  PRIMARY KEY (`variable`)
);

DROP TABLE IF EXISTS `tags`;

--
-- Table: `tags`
--
CREATE TABLE `tags` (
  `entry` varchar(255) NOT NULL DEFAULT '',
  `weight` bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (`entry`)
);

DROP TABLE IF EXISTS `tags_all`;

--
-- Table: `tags_all`
--
CREATE TABLE `tags_all` (
  `tag_id` integer NOT NULL auto_increment,
  `borrowernumber` integer NOT NULL,
  `biblionumber` integer NOT NULL,
  `term` varchar(255) NOT NULL,
  `language` integer,
  `date_created` datetime NOT NULL,
  INDEX `tags_all_idx_biblionumber` (`biblionumber`),
  INDEX `tags_all_idx_borrowernumber` (`borrowernumber`),
  PRIMARY KEY (`tag_id`),
  CONSTRAINT `tags_all_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_all_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `tags_approval`;

--
-- Table: `tags_approval`
--
CREATE TABLE `tags_approval` (
  `term` varchar(255) NOT NULL,
  `approved` integer NOT NULL DEFAULT 0,
  `date_approved` datetime,
  `approved_by` integer,
  `weight_total` integer NOT NULL DEFAULT 1,
  INDEX `tags_approval_idx_approved_by` (`approved_by`),
  PRIMARY KEY (`term`),
  CONSTRAINT `tags_approval_fk_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `tags_index`;

--
-- Table: `tags_index`
--
CREATE TABLE `tags_index` (
  `term` varchar(255) NOT NULL,
  `biblionumber` integer NOT NULL,
  `weight` integer NOT NULL DEFAULT 1,
  INDEX `tags_index_idx_biblionumber` (`biblionumber`),
  INDEX `tags_index_idx_term` (`term`),
  PRIMARY KEY (`term`, `biblionumber`),
  CONSTRAINT `tags_index_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_index_fk_term` FOREIGN KEY (`term`) REFERENCES `tags_approval` (`term`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `tmp_holdsqueue`;

--
-- Table: `tmp_holdsqueue`
--
CREATE TABLE `tmp_holdsqueue` (
  `biblionumber` integer,
  `itemnumber` integer,
  `barcode` varchar(20),
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `phone` text,
  `borrowernumber` integer NOT NULL,
  `cardnumber` varchar(16),
  `reservedate` date,
  `title` mediumtext,
  `itemcallnumber` varchar(255),
  `holdingbranch` varchar(10),
  `pickbranch` varchar(10),
  `notes` text,
  `item_level_request` tinyint NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS `user_permissions`;

--
-- Table: `user_permissions`
--
CREATE TABLE `user_permissions` (
  `borrowernumber` integer NOT NULL DEFAULT 0,
  `module_bit` integer NOT NULL DEFAULT 0,
  `code` varchar(64),
  INDEX `user_permissions_idx_borrowernumber` (`borrowernumber`),
  INDEX `user_permissions_idx_module_bit_code` (`module_bit`, `code`),
  CONSTRAINT `user_permissions_fk_borrowernumber` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_permissions_fk_module_bit_code` FOREIGN KEY (`module_bit`, `code`) REFERENCES `permissions` (`module_bit`, `code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `userflags`;

--
-- Table: `userflags`
--
CREATE TABLE `userflags` (
  `bit` integer NOT NULL DEFAULT 0,
  `flag` varchar(30),
  `flagdesc` varchar(255),
  `defaulton` integer,
  PRIMARY KEY (`bit`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `view_maxbasketno_x_biblio`;

--
-- Table: `view_maxbasketno_x_biblio`
--
CREATE TABLE `view_maxbasketno_x_biblio` (
  `maxbasketno` integer,
  `biblionumber` integer
);

DROP TABLE IF EXISTS `view_maxsubid_x_biblio`;

--
-- Table: `view_maxsubid_x_biblio`
--
CREATE TABLE `view_maxsubid_x_biblio` (
  `maxsubscriptionid` integer,
  `biblionumber` integer NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS `virtualshelfcontents`;

--
-- Table: `virtualshelfcontents`
--
CREATE TABLE `virtualshelfcontents` (
  `shelfnumber` integer NOT NULL DEFAULT 0,
  `biblionumber` integer NOT NULL DEFAULT 0,
  `flags` integer,
  `dateadded` timestamp NOT NULL DEFAULT current_timestamp,
  INDEX `virtualshelfcontents_idx_biblionumber` (`biblionumber`),
  INDEX `virtualshelfcontents_idx_shelfnumber` (`shelfnumber`),
  CONSTRAINT `virtualshelfcontents_fk_biblionumber` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `virtualshelfcontents_fk_shelfnumber` FOREIGN KEY (`shelfnumber`) REFERENCES `virtualshelves` (`shelfnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `virtualshelves`;

--
-- Table: `virtualshelves`
--
CREATE TABLE `virtualshelves` (
  `shelfnumber` integer NOT NULL auto_increment,
  `shelfname` varchar(255),
  `owner` varchar(80),
  `category` varchar(1),
  `sortfield` varchar(16),
  `lastmodified` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`shelfnumber`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `z3950servers`;

--
-- Table: `z3950servers`
--
CREATE TABLE `z3950servers` (
  `host` varchar(255),
  `port` integer,
  `db` varchar(255),
  `userid` varchar(255),
  `password` varchar(255),
  `name` mediumtext,
  `id` integer NOT NULL auto_increment,
  `checked` smallint,
  `rank` integer,
  `syntax` varchar(80),
  `icon` text,
  `position` enum('primary', 'secondary', '') NOT NULL DEFAULT 'primary',
  `type` enum('zed', 'opensearch') NOT NULL DEFAULT 'zed',
  `encoding` text,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `zebraqueue`;

--
-- Table: `zebraqueue`
--
CREATE TABLE `zebraqueue` (
  `id` integer NOT NULL auto_increment,
  `biblio_auth_number` bigint unsigned NOT NULL DEFAULT 0,
  `operation` char(20) NOT NULL DEFAULT '',
  `server` char(20) NOT NULL DEFAULT '',
  `done` integer NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `branches`;

--
-- Table: `branches`
--
CREATE TABLE `branches` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `branchname` mediumtext NOT NULL,
  `branchaddress1` mediumtext,
  `branchaddress2` mediumtext,
  `branchaddress3` mediumtext,
  `branchzip` varchar(25),
  `branchcity` mediumtext,
  `branchstate` mediumtext,
  `branchcountry` text,
  `branchphone` mediumtext,
  `branchfax` mediumtext,
  `branchemail` mediumtext,
  `branchurl` mediumtext,
  `issuing` tinyint,
  `branchip` varchar(15),
  `branchprinter` varchar(100),
  `branchnotes` mediumtext,
  INDEX `branches_idx_branchcode` (`branchcode`),
  UNIQUE `branchcode` (`branchcode`),
  CONSTRAINT `branches_fk_branchcode` FOREIGN KEY (`branchcode`) REFERENCES `default_branch_circ_rules` (`branchcode`)
) ENGINE=InnoDB;

SET foreign_key_checks=1;

