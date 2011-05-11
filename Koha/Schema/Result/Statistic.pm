package Koha::Schema::Result::Statistic;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Statistic

=cut

__PACKAGE__->table("statistics");

=head1 ACCESSORS

=head2 datetime

  data_type: 'datetime'
  is_nullable: 1

=head2 branch

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 proccode

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=head2 value

  data_type: 'double precision'
  is_nullable: 1
  size: [16,4]

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 other

  data_type: 'mediumtext'
  is_nullable: 1

=head2 usercode

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 itemnumber

  data_type: 'integer'
  is_nullable: 1

=head2 itemtype

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 borrowernumber

  data_type: 'integer'
  is_nullable: 1

=head2 associatedborrower

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "datetime",
  { data_type => "datetime", is_nullable => 1 },
  "branch",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "proccode",
  { data_type => "varchar", is_nullable => 1, size => 4 },
  "value",
  { data_type => "double precision", is_nullable => 1, size => [16, 4] },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "other",
  { data_type => "mediumtext", is_nullable => 1 },
  "usercode",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "itemnumber",
  { data_type => "integer", is_nullable => 1 },
  "itemtype",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "borrowernumber",
  { data_type => "integer", is_nullable => 1 },
  "associatedborrower",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s2SVV10q0G/PTo+UfrqqwQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
