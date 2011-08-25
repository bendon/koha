package Koha::Schema::Result::LanguageSubtagRegistry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LanguageSubtagRegistry

=cut

__PACKAGE__->table("language_subtag_registry");

=head1 ACCESSORS

=head2 subtag

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 added

  data_type: 'date'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "subtag",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "added",
  { data_type => "date", is_nullable => 1 },
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3enXjoRhzkU8soGCo3JHcQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
