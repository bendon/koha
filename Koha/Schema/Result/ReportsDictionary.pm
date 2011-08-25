package Koha::Schema::Result::ReportsDictionary;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::ReportsDictionary

=cut

__PACKAGE__->table("reports_dictionary");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 date_modified

  data_type: 'datetime'
  is_nullable: 1

=head2 saved_sql

  data_type: 'text'
  is_nullable: 1

=head2 area

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "date_modified",
  { data_type => "datetime", is_nullable => 1 },
  "saved_sql",
  { data_type => "text", is_nullable => 1 },
  "area",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yp+A4fAZ+mEHs7rpGQvulA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
