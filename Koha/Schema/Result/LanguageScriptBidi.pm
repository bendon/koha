package Koha::Schema::Result::LanguageScriptBidi;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LanguageScriptBidi

=cut

__PACKAGE__->table("language_script_bidi");

=head1 ACCESSORS

=head2 rfc4646_subtag

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 bidi

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=cut

__PACKAGE__->add_columns(
  "rfc4646_subtag",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "bidi",
  { data_type => "varchar", is_nullable => 1, size => 3 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:U+VIqCIyB8KYfczRm/RYaw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
