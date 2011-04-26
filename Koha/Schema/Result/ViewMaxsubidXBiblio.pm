package Koha::Schema::Result::ViewMaxsubidXBiblio;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::ViewMaxsubidXBiblio

=cut

__PACKAGE__->table("view_maxsubid_x_biblio");

=head1 ACCESSORS

=head2 maxsubscriptionid

  data_type: 'integer'
  is_nullable: 1

=head2 biblionumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "maxsubscriptionid",
  { data_type => "integer", is_nullable => 1 },
  "biblionumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:82NHD85h/hE/jQSj59v8UA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
