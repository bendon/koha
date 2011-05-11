package Koha::Schema::Result::Reserveconstraint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Reserveconstraint

=cut

__PACKAGE__->table("reserveconstraints");

=head1 ACCESSORS

=head2 borrowernumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 reservedate

  data_type: 'date'
  is_nullable: 1

=head2 biblionumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 biblioitemnumber

  data_type: 'integer'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "borrowernumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "reservedate",
  { data_type => "date", is_nullable => 1 },
  "biblionumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "biblioitemnumber",
  { data_type => "integer", is_nullable => 1 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0CNK2QqoE2DEp2Xu8GHxPQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
