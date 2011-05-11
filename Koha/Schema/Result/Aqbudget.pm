package Koha::Schema::Result::Aqbudget;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Aqbudget

=cut

__PACKAGE__->table("aqbudgets");

=head1 ACCESSORS

=head2 budget_code

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 budget_amount

  data_type: 'decimal'
  default_value: 0.000000
  is_nullable: 0
  size: [28,6]

=head2 budget_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 budget_branchcode

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 budget_parent_id

  data_type: 'integer'
  is_nullable: 1

=head2 budget_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 budget_encumb

  data_type: 'decimal'
  default_value: 0.000000
  is_nullable: 1
  size: [28,6]

=head2 budget_expend

  data_type: 'decimal'
  default_value: 0.000000
  is_nullable: 1
  size: [28,6]

=head2 budget_notes

  data_type: 'mediumtext'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 budget_period_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 sort1_authcat

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 sort2_authcat

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 budget_owner_id

  data_type: 'integer'
  is_nullable: 1

=head2 budget_permission

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "budget_code",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "budget_amount",
  {
    data_type => "decimal",
    default_value => "0.000000",
    is_nullable => 0,
    size => [28, 6],
  },
  "budget_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "budget_branchcode",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "budget_parent_id",
  { data_type => "integer", is_nullable => 1 },
  "budget_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "budget_encumb",
  {
    data_type => "decimal",
    default_value => "0.000000",
    is_nullable => 1,
    size => [28, 6],
  },
  "budget_expend",
  {
    data_type => "decimal",
    default_value => "0.000000",
    is_nullable => 1,
    size => [28, 6],
  },
  "budget_notes",
  { data_type => "mediumtext", is_nullable => 1 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "budget_period_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "sort1_authcat",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "sort2_authcat",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "budget_owner_id",
  { data_type => "integer", is_nullable => 1 },
  "budget_permission",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("budget_id");

=head1 RELATIONS

=head2 budget_period

Type: belongs_to

Related object: L<Koha::Schema::Result::Aqbudgetperiod>

=cut

__PACKAGE__->belongs_to(
  "budget_period",
  "Koha::Schema::Result::Aqbudgetperiod",
  { budget_period_id => "budget_period_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 aqbudgets_plannings

Type: has_many

Related object: L<Koha::Schema::Result::AqbudgetsPlanning>

=cut

__PACKAGE__->has_many(
  "aqbudgets_plannings",
  "Koha::Schema::Result::AqbudgetsPlanning",
  { "foreign.budget_id" => "self.budget_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:z0zLCwvvRqCHMiMTcR6pNQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
