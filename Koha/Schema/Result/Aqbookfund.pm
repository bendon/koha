package Koha::Schema::Result::Aqbookfund;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Aqbookfund

=cut

__PACKAGE__->table("aqbookfund");

=head1 ACCESSORS

=head2 bookfundid

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 bookfundname

  data_type: 'mediumtext'
  is_nullable: 1

=head2 bookfundgroup

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 branchcode

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "bookfundid",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "bookfundname",
  { data_type => "mediumtext", is_nullable => 1 },
  "bookfundgroup",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "branchcode",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
);
__PACKAGE__->set_primary_key("bookfundid", "branchcode");

=head1 RELATIONS

=head2 aqorderbreakdowns

Type: has_many

Related object: L<Koha::Schema::Result::Aqorderbreakdown>

=cut

__PACKAGE__->has_many(
  "aqorderbreakdowns",
  "Koha::Schema::Result::Aqorderbreakdown",
  { "foreign.bookfundid" => "self.bookfundid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:p7599XIy8VvoDFyIE9m8rA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
