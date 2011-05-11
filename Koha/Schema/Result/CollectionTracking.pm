package Koha::Schema::Result::CollectionTracking;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::CollectionTracking

=cut

__PACKAGE__->table("collections_tracking");

=head1 ACCESSORS

=head2 ctid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 colid

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 itemnumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ctid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "colid",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "itemnumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("ctid");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rUrjKuXRiegPIFZusW3Awg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
