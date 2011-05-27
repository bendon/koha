package Koha::Schema::Result::Patronimage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Patronimage

=cut

__PACKAGE__->table("patronimage");

=head1 ACCESSORS

=head2 cardnumber

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 mimetype

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 imagefile

  data_type: 'mediumblob'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cardnumber",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "mimetype",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "imagefile",
  { data_type => "mediumblob", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("cardnumber");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-27 15:18:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aglyQAUNiAp49IaKtxREtA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
