package Koha::Schema::Result::StatFromMarcxml;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::StatFromMarcxml

=cut

__PACKAGE__->table("stat_from_marcxml");

=head1 ACCESSORS

=head2 biblionumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 itemtype

  data_type: 'varchar'
  is_nullable: 1
  size: 1

=head2 cataloguerm

  data_type: 'longtext'
  is_nullable: 1

=head2 cataloguers

  data_type: 'longtext'
  is_nullable: 1

=head2 insertdate

  data_type: 'varchar'
  is_nullable: 1
  size: 6

=head2 modifydate

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 accessionno

  data_type: 'longtext'
  is_nullable: 1

=head2 isbn

  data_type: 'longtext'
  is_nullable: 1

=head2 issn

  data_type: 'longtext'
  is_nullable: 1

=head2 callnumber

  data_type: 'longtext'
  is_nullable: 1

=head2 title

  data_type: 'longtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "biblionumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "itemtype",
  { data_type => "varchar", is_nullable => 1, size => 1 },
  "cataloguerm",
  { data_type => "longtext", is_nullable => 1 },
  "cataloguers",
  { data_type => "longtext", is_nullable => 1 },
  "insertdate",
  { data_type => "varchar", is_nullable => 1, size => 6 },
  "modifydate",
  { data_type => "varchar", is_nullable => 1, size => 8 },
  "accessionno",
  { data_type => "longtext", is_nullable => 1 },
  "isbn",
  { data_type => "longtext", is_nullable => 1 },
  "issn",
  { data_type => "longtext", is_nullable => 1 },
  "callnumber",
  { data_type => "longtext", is_nullable => 1 },
  "title",
  { data_type => "longtext", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1WetfMvYcGR4GDaCv5U4sQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
