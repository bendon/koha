package Koha::Schema::Result::Virtualshelve;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Virtualshelve

=cut

__PACKAGE__->table("virtualshelves");

=head1 ACCESSORS

=head2 shelfnumber

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 shelfname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 owner

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 category

  data_type: 'varchar'
  is_nullable: 1
  size: 1

=head2 sortfield

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 lastmodified

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "shelfnumber",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "shelfname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "owner",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "category",
  { data_type => "varchar", is_nullable => 1, size => 1 },
  "sortfield",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "lastmodified",
  {
    data_type => "timestamp",
    "datetime_undef_if_invalid" => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("shelfnumber");

=head1 RELATIONS

=head2 virtualshelfcontents

Type: has_many

Related object: L<Koha::Schema::Result::Virtualshelfcontent>

=cut

__PACKAGE__->has_many(
  "virtualshelfcontents",
  "Koha::Schema::Result::Virtualshelfcontent",
  { "foreign.shelfnumber" => "self.shelfnumber" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:G7sTgjQe45opmGfrPBPVTg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
