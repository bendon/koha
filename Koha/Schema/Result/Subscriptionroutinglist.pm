package Koha::Schema::Result::Subscriptionroutinglist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Subscriptionroutinglist

=cut

__PACKAGE__->table("subscriptionroutinglist");

=head1 ACCESSORS

=head2 routingid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 borrowernumber

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ranking

  data_type: 'integer'
  is_nullable: 1

=head2 subscriptionid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "routingid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "borrowernumber",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ranking",
  { data_type => "integer", is_nullable => 1 },
  "subscriptionid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("routingid");
__PACKAGE__->add_unique_constraint("subscriptionid", ["subscriptionid", "borrowernumber"]);

=head1 RELATIONS

=head2 borrowernumber

Type: belongs_to

Related object: L<Koha::Schema::Result::Borrower>

=cut

__PACKAGE__->belongs_to(
  "borrowernumber",
  "Koha::Schema::Result::Borrower",
  { borrowernumber => "borrowernumber" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 subscriptionid

Type: belongs_to

Related object: L<Koha::Schema::Result::Subscription>

=cut

__PACKAGE__->belongs_to(
  "subscriptionid",
  "Koha::Schema::Result::Subscription",
  { subscriptionid => "subscriptionid" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xV8OFCXxtQZIQ14gYE6Szg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
