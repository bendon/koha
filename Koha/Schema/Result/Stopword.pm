package Koha::Schema::Result::Stopword;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Stopword

=cut

__PACKAGE__->table("stopwords");

=head1 ACCESSORS

=head2 word

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "word",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:D3dB2isAOPJbOMr4o3Boyw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
