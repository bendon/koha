package Koha::Schema::Result::Ethnicity;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Ethnicity

=cut

__PACKAGE__->table("ethnicity");

=head1 ACCESSORS

=head2 code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "code",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("code");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XA5eB6P2by3lYTsIb0/Jeg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
