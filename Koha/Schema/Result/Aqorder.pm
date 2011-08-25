package Koha::Schema::Result::Aqorder;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Aqorder

=cut

__PACKAGE__->table("aqorders");

=head1 ACCESSORS

=head2 ordernumber

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 biblionumber

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 entrydate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 quantity

  data_type: 'smallint'
  is_nullable: 1

=head2 currency

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 listprice

  data_type: 'decimal'
  is_nullable: 1
  size: [28,6]

=head2 totalamount

  data_type: 'decimal'
  is_nullable: 1
  size: [28,6]

=head2 datereceived

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 booksellerinvoicenumber

  data_type: 'mediumtext'
  is_nullable: 1

=head2 freight

  data_type: 'decimal'
  is_nullable: 1
  size: [28,6]

=head2 unitprice

  data_type: 'decimal'
  is_nullable: 1
  size: [28,6]

=head2 quantityreceived

  data_type: 'smallint'
  default_value: 0
  is_nullable: 0

=head2 cancelledby

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 datecancellationprinted

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 notes

  data_type: 'mediumtext'
  is_nullable: 1

=head2 supplierreference

  data_type: 'mediumtext'
  is_nullable: 1

=head2 purchaseordernumber

  data_type: 'mediumtext'
  is_nullable: 1

=head2 subscription

  data_type: 'tinyint'
  is_nullable: 1

=head2 serialid

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 basketno

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 biblioitemnumber

  data_type: 'integer'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 rrp

  data_type: 'decimal'
  is_nullable: 1
  size: [13,2]

=head2 ecost

  data_type: 'decimal'
  is_nullable: 1
  size: [13,2]

=head2 gst

  data_type: 'decimal'
  is_nullable: 1
  size: [13,2]

=head2 budgetdate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sort1

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 sort2

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 uncertainprice

  data_type: 'tinyint'
  is_nullable: 1

=head2 budget_id

  data_type: 'integer'
  is_nullable: 0

=head2 budgetgroup_id

  data_type: 'integer'
  is_nullable: 0

=head2 sort1_authcat

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 sort2_authcat

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "ordernumber",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "biblionumber",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "entrydate",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "quantity",
  { data_type => "smallint", is_nullable => 1 },
  "currency",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "listprice",
  { data_type => "decimal", is_nullable => 1, size => [28, 6] },
  "totalamount",
  { data_type => "decimal", is_nullable => 1, size => [28, 6] },
  "datereceived",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "booksellerinvoicenumber",
  { data_type => "mediumtext", is_nullable => 1 },
  "freight",
  { data_type => "decimal", is_nullable => 1, size => [28, 6] },
  "unitprice",
  { data_type => "decimal", is_nullable => 1, size => [28, 6] },
  "quantityreceived",
  { data_type => "smallint", default_value => 0, is_nullable => 0 },
  "cancelledby",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "datecancellationprinted",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "notes",
  { data_type => "mediumtext", is_nullable => 1 },
  "supplierreference",
  { data_type => "mediumtext", is_nullable => 1 },
  "purchaseordernumber",
  { data_type => "mediumtext", is_nullable => 1 },
  "subscription",
  { data_type => "tinyint", is_nullable => 1 },
  "serialid",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "basketno",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "biblioitemnumber",
  { data_type => "integer", is_nullable => 1 },
  "timestamp",
  {
    data_type => "timestamp",
    "datetime_undef_if_invalid" => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "rrp",
  { data_type => "decimal", is_nullable => 1, size => [13, 2] },
  "ecost",
  { data_type => "decimal", is_nullable => 1, size => [13, 2] },
  "gst",
  { data_type => "decimal", is_nullable => 1, size => [13, 2] },
  "budgetdate",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "sort1",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "sort2",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "uncertainprice",
  { data_type => "tinyint", is_nullable => 1 },
  "budget_id",
  { data_type => "integer", is_nullable => 0 },
  "budgetgroup_id",
  { data_type => "integer", is_nullable => 0 },
  "sort1_authcat",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "sort2_authcat",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);
__PACKAGE__->set_primary_key("ordernumber");

=head1 RELATIONS

=head2 aqorderbreakdowns

Type: has_many

Related object: L<Koha::Schema::Result::Aqorderbreakdown>

=cut

__PACKAGE__->has_many(
  "aqorderbreakdowns",
  "Koha::Schema::Result::Aqorderbreakdown",
  { "foreign.ordernumber" => "self.ordernumber" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 basketno

Type: belongs_to

Related object: L<Koha::Schema::Result::Aqbasket>

=cut

__PACKAGE__->belongs_to(
  "basketno",
  "Koha::Schema::Result::Aqbasket",
  { basketno => "basketno" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 biblionumber

Type: belongs_to

Related object: L<Koha::Schema::Result::Biblio>

=cut

__PACKAGE__->belongs_to(
  "biblionumber",
  "Koha::Schema::Result::Biblio",
  { biblionumber => "biblionumber" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PZHw78MK8GlmiDAeY11E4Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
