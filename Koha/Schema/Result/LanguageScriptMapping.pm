package Koha::Schema::Result::LanguageScriptMapping;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LanguageScriptMapping

=cut

__PACKAGE__->table("language_script_mapping");

=head1 ACCESSORS

=head2 language_subtag

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 script_subtag

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=cut

__PACKAGE__->add_columns(
  "language_subtag",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "script_subtag",
  { data_type => "varchar", is_nullable => 1, size => 25 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Z2qyo5wCKtUacXloHxA2RQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
