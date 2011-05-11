package Koha::Schema::Result::LanguageRfc4646ToIso639;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LanguageRfc4646ToIso639

=cut

__PACKAGE__->table("language_rfc4646_to_iso639");

=head1 ACCESSORS

=head2 rfc4646_subtag

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 iso639_2_code

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "rfc4646_subtag",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "iso639_2_code",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3/9zPnAfFVXSZ2s73VjpGA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
