package Koha::Schema::Result::Itemdeletelist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Itemdeletelist

=cut

__PACKAGE__->table("itemdeletelist");

=head1 ACCESSORS

=head2 list_id

  data_type: 'integer'
  is_nullable: 0

=head2 itemnumber

  data_type: 'integer'
  is_nullable: 0

=head2 biblionumber

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "list_id",
  { data_type => "integer", is_nullable => 0 },
  "itemnumber",
  { data_type => "integer", is_nullable => 0 },
  "biblionumber",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("list_id", "itemnumber");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W5nH/dcGKUN+4Ok27+7+Wg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
