package Koha::Schema::Result::Subscriptionhistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Subscriptionhistory

=cut

__PACKAGE__->table("subscriptionhistory");

=head1 ACCESSORS

=head2 biblionumber

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 subscriptionid

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 histstartdate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 histenddate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 missinglist

  data_type: 'longtext'
  is_nullable: 0

=head2 recievedlist

  data_type: 'longtext'
  is_nullable: 0

=head2 opacnote

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 150

=head2 librariannote

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 150

=cut

__PACKAGE__->add_columns(
  "biblionumber",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "subscriptionid",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "histstartdate",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "histenddate",
  { data_type => "date", "datetime_undef_if_invalid" => 1, is_nullable => 1 },
  "missinglist",
  { data_type => "longtext", is_nullable => 0 },
  "recievedlist",
  { data_type => "longtext", is_nullable => 0 },
  "opacnote",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 150 },
  "librariannote",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 150 },
);
__PACKAGE__->set_primary_key("subscriptionid");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 14:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eaP/Fsc+3EdUR2cHdpULJw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
