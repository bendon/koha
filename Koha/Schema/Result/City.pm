package Koha::Schema::Result::City;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::City

=cut

__PACKAGE__->table("cities");

=head1 ACCESSORS

=head2 cityid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 city_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 city_state

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 city_zipcode

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 city_country

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "cityid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "city_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "city_state",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "city_zipcode",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "city_country",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("cityid");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-08-11 09:59:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uo6korP7X4iMLR3CnhyQog


# You can replace this text with custom content, and it will be preserved on regeneration
1;
