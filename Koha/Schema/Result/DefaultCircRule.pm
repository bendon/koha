package Koha::Schema::Result::DefaultCircRule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::DefaultCircRule

=cut

__PACKAGE__->table("default_circ_rules");

=head1 ACCESSORS

=head2 singleton

  data_type: 'enum'
  default_value: 'singleton'
  extra: {list => ["singleton"]}
  is_nullable: 0

=head2 maxissueqty

  data_type: 'integer'
  is_nullable: 1

=head2 holdallowed

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "singleton",
  {
    data_type => "enum",
    default_value => "singleton",
    extra => { list => ["singleton"] },
    is_nullable => 0,
  },
  "maxissueqty",
  { data_type => "integer", is_nullable => 1 },
  "holdallowed",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("singleton");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iPd0GN3/rwUUhRmMc2rM6g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
