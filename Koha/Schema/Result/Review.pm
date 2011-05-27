package Koha::Schema::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Review

=cut

__PACKAGE__->table("reviews");

=head1 ACCESSORS

=head2 reviewid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 borrowernumber

  data_type: 'integer'
  is_nullable: 1

=head2 biblionumber

  data_type: 'integer'
  is_nullable: 1

=head2 review

  data_type: 'text'
  is_nullable: 1

=head2 approved

  data_type: 'tinyint'
  is_nullable: 1

=head2 datereviewed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "reviewid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "borrowernumber",
  { data_type => "integer", is_nullable => 1 },
  "biblionumber",
  { data_type => "integer", is_nullable => 1 },
  "review",
  { data_type => "text", is_nullable => 1 },
  "approved",
  { data_type => "tinyint", is_nullable => 1 },
  "datereviewed",
  {
    data_type => "datetime",
    "datetime_undef_if_invalid" => 1,
    is_nullable => 1,
  },
);
__PACKAGE__->set_primary_key("reviewid");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rvqJg1v2c80PeVRDbeRKNA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
