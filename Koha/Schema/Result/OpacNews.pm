package Koha::Schema::Result::OpacNews;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::OpacNews

=cut

__PACKAGE__->table("opac_news");

=head1 ACCESSORS

=head2 idnew

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 250

=head2 new

  accessor: undef
  data_type: 'text'
  is_nullable: 0

=head2 lang

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 25

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 expirationdate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 number

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "idnew",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 250 },
  "new",
  { accessor => undef, data_type => "text", is_nullable => 0 },
  "lang",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 25 },
  "timestamp",
  {
    data_type => "timestamp",
    "datetime_undef_if_invalid" => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "expirationdate",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "number",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("idnew");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:45ZBuQMOanVhTlHx5CTzZg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
