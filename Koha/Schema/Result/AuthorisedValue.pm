package Koha::Schema::Result::AuthorisedValue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::AuthorisedValue

=cut

__PACKAGE__->table("authorised_values");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 category

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 authorised_value

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 lib

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 lib_opac

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 imageurl

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "category",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "authorised_value",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "lib",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "lib_opac",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "imageurl",
  { data_type => "varchar", is_nullable => 1, size => 200 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kib/UixsSVjkK2Gx8c1d1Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
