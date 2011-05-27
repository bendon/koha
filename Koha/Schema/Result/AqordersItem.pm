package Koha::Schema::Result::AqordersItem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::AqordersItem

=cut

__PACKAGE__->table("aqorders_items");

=head1 ACCESSORS

=head2 ordernumber

  data_type: 'integer'
  is_nullable: 0

=head2 itemnumber

  data_type: 'integer'
  is_nullable: 0

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ordernumber",
  { data_type => "integer", is_nullable => 0 },
  "itemnumber",
  { data_type => "integer", is_nullable => 0 },
  "timestamp",
  {
    data_type => "timestamp",
    "datetime_undef_if_invalid" => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("itemnumber");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:v+9tsZOIiGXsGwOLAZ8OOg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
