package Koha::Schema::Result::SavedSql;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::SavedSql

=cut

__PACKAGE__->table("saved_sql");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 borrowernumber

  data_type: 'integer'
  is_nullable: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 last_modified

  data_type: 'datetime'
  is_nullable: 1

=head2 savedsql

  data_type: 'text'
  is_nullable: 1

=head2 last_run

  data_type: 'datetime'
  is_nullable: 1

=head2 report_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 notes

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "borrowernumber",
  { data_type => "integer", is_nullable => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "last_modified",
  { data_type => "datetime", is_nullable => 1 },
  "savedsql",
  { data_type => "text", is_nullable => 1 },
  "last_run",
  { data_type => "datetime", is_nullable => 1 },
  "report_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "notes",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jR/k6kfG2m1PRJ53tPtX8Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
