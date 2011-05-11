package Koha::Schema::Result::Printer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Printer

=cut

__PACKAGE__->table("printers");

=head1 ACCESSORS

=head2 printername

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 40

=head2 printqueue

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 printtype

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "printername",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 40 },
  "printqueue",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "printtype",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);
__PACKAGE__->set_primary_key("printername");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W7QdmjfP23N0A/isrqjryw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
