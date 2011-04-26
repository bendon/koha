package Koha::Schema::Result::Serialitem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Serialitem

=cut

__PACKAGE__->table("serialitems");

=head1 ACCESSORS

=head2 itemnumber

  data_type: 'integer'
  is_nullable: 0

=head2 serialid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "itemnumber",
  { data_type => "integer", is_nullable => 0 },
  "serialid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->add_unique_constraint("serialitemsidx", ["itemnumber"]);

=head1 RELATIONS

=head2 serialid

Type: belongs_to

Related object: L<Koha::Schema::Result::Serial>

=cut

__PACKAGE__->belongs_to(
  "serialid",
  "Koha::Schema::Result::Serial",
  { serialid => "serialid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pcKAjwlgHGij67aWKTUfpQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
