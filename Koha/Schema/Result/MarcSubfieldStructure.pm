package Koha::Schema::Result::MarcSubfieldStructure;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::MarcSubfieldStructure

=cut

__PACKAGE__->table("marc_subfield_structure");

=head1 ACCESSORS

=head2 tagfield

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 3

=head2 tagsubfield

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 1

=head2 liblibrarian

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 libopac

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 repeatable

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 mandatory

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 kohafield

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 tab

  data_type: 'tinyint'
  is_nullable: 1

=head2 authorised_value

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 authtypecode

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 value_builder

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 isurl

  data_type: 'tinyint'
  is_nullable: 1

=head2 hidden

  data_type: 'tinyint'
  is_nullable: 1

=head2 frameworkcode

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 4

=head2 seealso

  data_type: 'varchar'
  is_nullable: 1
  size: 1100

=head2 link

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 defaultvalue

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "tagfield",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 3 },
  "tagsubfield",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 1 },
  "liblibrarian",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "libopac",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "repeatable",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "mandatory",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "kohafield",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "tab",
  { data_type => "tinyint", is_nullable => 1 },
  "authorised_value",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "authtypecode",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "value_builder",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "isurl",
  { data_type => "tinyint", is_nullable => 1 },
  "hidden",
  { data_type => "tinyint", is_nullable => 1 },
  "frameworkcode",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 4 },
  "seealso",
  { data_type => "varchar", is_nullable => 1, size => 1100 },
  "link",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "defaultvalue",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("frameworkcode", "tagfield", "tagsubfield");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+pHRF59Aqi9Xqo7MH7UkOg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
