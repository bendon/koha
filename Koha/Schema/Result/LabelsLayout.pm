package Koha::Schema::Result::LabelsLayout;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LabelsLayout

=cut

__PACKAGE__->table("labels_layouts");

=head1 ACCESSORS

=head2 layout_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 barcode_type

  data_type: 'char'
  default_value: 'CODE39'
  is_nullable: 0
  size: 100

=head2 printing_type

  data_type: 'char'
  default_value: 'BAR'
  is_nullable: 0
  size: 32

=head2 layout_name

  data_type: 'char'
  default_value: 'DEFAULT'
  is_nullable: 0
  size: 20

=head2 guidebox

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 font

  data_type: 'char'
  default_value: 'TR'
  is_nullable: 0
  size: 10

=head2 font_size

  data_type: 'integer'
  default_value: 10
  is_nullable: 0

=head2 callnum_split

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 text_justify

  data_type: 'char'
  default_value: 'L'
  is_nullable: 0
  size: 1

=head2 format_string

  data_type: 'varchar'
  default_value: 'barcode'
  is_nullable: 0
  size: 210

=cut

__PACKAGE__->add_columns(
  "layout_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "barcode_type",
  {
    data_type => "char",
    default_value => "CODE39",
    is_nullable => 0,
    size => 100,
  },
  "printing_type",
  { data_type => "char", default_value => "BAR", is_nullable => 0, size => 32 },
  "layout_name",
  {
    data_type => "char",
    default_value => "DEFAULT",
    is_nullable => 0,
    size => 20,
  },
  "guidebox",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "font",
  { data_type => "char", default_value => "TR", is_nullable => 0, size => 10 },
  "font_size",
  { data_type => "integer", default_value => 10, is_nullable => 0 },
  "callnum_split",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "text_justify",
  { data_type => "char", default_value => "L", is_nullable => 0, size => 1 },
  "format_string",
  {
    data_type => "varchar",
    default_value => "barcode",
    is_nullable => 0,
    size => 210,
  },
);
__PACKAGE__->set_primary_key("layout_id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jOP601wtIRXY2wtEZB1y7g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
