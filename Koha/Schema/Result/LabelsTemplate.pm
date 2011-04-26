package Koha::Schema::Result::LabelsTemplate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::LabelsTemplate

=cut

__PACKAGE__->table("labels_templates");

=head1 ACCESSORS

=head2 template_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 profile_id

  data_type: 'integer'
  is_nullable: 1

=head2 template_code

  data_type: 'char'
  default_value: 'DEFAULT TEMPLATE'
  is_nullable: 0
  size: 100

=head2 template_desc

  data_type: 'char'
  default_value: 'Default description'
  is_nullable: 0
  size: 100

=head2 page_width

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 page_height

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 label_width

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 label_height

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 top_text_margin

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 left_text_margin

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 top_margin

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 left_margin

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 cols

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 rows

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 col_gap

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 row_gap

  data_type: 'float'
  default_value: 0
  is_nullable: 0

=head2 units

  data_type: 'char'
  default_value: 'POINT'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "template_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "profile_id",
  { data_type => "integer", is_nullable => 1 },
  "template_code",
  {
    data_type => "char",
    default_value => "DEFAULT TEMPLATE",
    is_nullable => 0,
    size => 100,
  },
  "template_desc",
  {
    data_type => "char",
    default_value => "Default description",
    is_nullable => 0,
    size => 100,
  },
  "page_width",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "page_height",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "label_width",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "label_height",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "top_text_margin",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "left_text_margin",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "top_margin",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "left_margin",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "cols",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "rows",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "col_gap",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "row_gap",
  { data_type => "float", default_value => 0, is_nullable => 0 },
  "units",
  { data_type => "char", default_value => "POINT", is_nullable => 0, size => 20 },
);
__PACKAGE__->set_primary_key("template_id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IocZmsAEhyzrGiU/NtwF7A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
