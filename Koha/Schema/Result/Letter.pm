package Koha::Schema::Result::Letter;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Letter

=cut

__PACKAGE__->table("letter");

=head1 ACCESSORS

=head2 module

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 title

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 content

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "module",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "code",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "title",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 200 },
  "content",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("module", "code");

=head1 RELATIONS

=head2 message_transports

Type: has_many

Related object: L<Koha::Schema::Result::MessageTransport>

=cut

__PACKAGE__->has_many(
  "message_transports",
  "Koha::Schema::Result::MessageTransport",
  {
    "foreign.letter_code"   => "self.code",
    "foreign.letter_module" => "self.module",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5YIfSbtkPzHlPuJPV5PTKA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
