package Koha::Schema::Result::AuthHeader;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::AuthHeader

=cut

__PACKAGE__->table("auth_header");

=head1 ACCESSORS

=head2 authid

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 authtypecode

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 datecreated

  data_type: 'date'
  is_nullable: 1

=head2 datemodified

  data_type: 'date'
  is_nullable: 1

=head2 origincode

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 authtrees

  data_type: 'mediumtext'
  is_nullable: 1

=head2 marc

  data_type: 'blob'
  is_nullable: 1

=head2 linkid

  data_type: 'bigint'
  is_nullable: 1

=head2 marcxml

  data_type: 'longtext'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "authid",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "authtypecode",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "datecreated",
  { data_type => "date", is_nullable => 1 },
  "datemodified",
  { data_type => "date", is_nullable => 1 },
  "origincode",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "authtrees",
  { data_type => "mediumtext", is_nullable => 1 },
  "marc",
  { data_type => "blob", is_nullable => 1 },
  "linkid",
  { data_type => "bigint", is_nullable => 1 },
  "marcxml",
  { data_type => "longtext", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("authid");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HWju8pnSUJckix/5H/3sHA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
