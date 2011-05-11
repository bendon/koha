package Koha::Schema::Result::Browser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Browser

=cut

__PACKAGE__->table("browser");

=head1 ACCESSORS

=head2 level

  data_type: 'integer'
  is_nullable: 0

=head2 classification

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 number

  data_type: 'bigint'
  is_nullable: 0

=head2 endnode

  data_type: 'tinyint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "level",
  { data_type => "integer", is_nullable => 0 },
  "classification",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "number",
  { data_type => "bigint", is_nullable => 0 },
  "endnode",
  { data_type => "tinyint", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sPZZTMSbTQLg607wdrsQkw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
