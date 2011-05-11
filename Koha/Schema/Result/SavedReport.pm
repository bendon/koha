package Koha::Schema::Result::SavedReport;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::SavedReport

=cut

__PACKAGE__->table("saved_reports");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 report_id

  data_type: 'integer'
  is_nullable: 1

=head2 report

  data_type: 'longtext'
  is_nullable: 1

=head2 date_run

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "report_id",
  { data_type => "integer", is_nullable => 1 },
  "report",
  { data_type => "longtext", is_nullable => 1 },
  "date_run",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0vray/lJF0pIVkc65wC4zA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
