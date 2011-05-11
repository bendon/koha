package Koha::Schema::Result::CreatorImage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::CreatorImage

=cut

__PACKAGE__->table("creator_images");

=head1 ACCESSORS

=head2 image_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 imagefile

  data_type: 'mediumblob'
  is_nullable: 1

=head2 image_name

  data_type: 'char'
  default_value: 'DEFAULT'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "image_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "imagefile",
  { data_type => "mediumblob", is_nullable => 1 },
  "image_name",
  {
    data_type => "char",
    default_value => "DEFAULT",
    is_nullable => 0,
    size => 20,
  },
);
__PACKAGE__->set_primary_key("image_id");
__PACKAGE__->add_unique_constraint("image_name_index", ["image_name"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7W3qu7asZcAmXdOWbbu8UA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
