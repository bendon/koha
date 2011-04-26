package Koha::Schema::Result::Aqorderbreakdown;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Aqorderbreakdown

=cut

__PACKAGE__->table("aqorderbreakdown");

=head1 ACCESSORS

=head2 ordernumber

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 linenumber

  data_type: 'integer'
  is_nullable: 1

=head2 branchcode

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 bookfundid

  data_type: 'varchar'
  default_value: (empty string)
  is_foreign_key: 1
  is_nullable: 0
  size: 10

=head2 allocation

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "ordernumber",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "linenumber",
  { data_type => "integer", is_nullable => 1 },
  "branchcode",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "bookfundid",
  {
    data_type => "varchar",
    default_value => "",
    is_foreign_key => 1,
    is_nullable => 0,
    size => 10,
  },
  "allocation",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 RELATIONS

=head2 ordernumber

Type: belongs_to

Related object: L<Koha::Schema::Result::Aqorder>

=cut

__PACKAGE__->belongs_to(
  "ordernumber",
  "Koha::Schema::Result::Aqorder",
  { ordernumber => "ordernumber" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 bookfundid

Type: belongs_to

Related object: L<Koha::Schema::Result::Aqbookfund>

=cut

__PACKAGE__->belongs_to(
  "bookfundid",
  "Koha::Schema::Result::Aqbookfund",
  { bookfundid => "bookfundid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m5SJFMEMf3tzSgMNcClkVw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
