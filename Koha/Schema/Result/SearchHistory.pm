package Koha::Schema::Result::SearchHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::SearchHistory

=cut

__PACKAGE__->table("search_history");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_nullable: 0

=head2 sessionid

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 query_desc

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 query_cgi

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 total

  data_type: 'integer'
  is_nullable: 0

=head2 time

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_nullable => 0 },
  "sessionid",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "query_desc",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "query_cgi",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "total",
  { data_type => "integer", is_nullable => 0 },
  "time",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Q8WiJwJEy+jZIAjTirFRFQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
