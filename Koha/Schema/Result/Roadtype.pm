package Koha::Schema::Result::Roadtype;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Roadtype

=cut

__PACKAGE__->table("roadtype");

=head1 ACCESSORS

=head2 roadtypeid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 road_type

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=cut

__PACKAGE__->add_columns(
  "roadtypeid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "road_type",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
);
__PACKAGE__->set_primary_key("roadtypeid");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nO8texLGhqMTuJMNKsFIJw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
