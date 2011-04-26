package Koha::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Tag

=cut

__PACKAGE__->table("tags");

=head1 ACCESSORS

=head2 entry

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 weight

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "entry",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "weight",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("entry");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KFpNdB3uSH6azg0RJuyDqw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
