package Koha::Schema::Result::Branch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Koha::Schema::Result::Branch

=cut

__PACKAGE__->table("branches");

=head1 ACCESSORS

=head2 branchcode

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 branchname

  data_type: 'mediumtext'
  is_nullable: 0

=head2 branchaddress1

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchaddress2

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchaddress3

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchzip

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 branchcity

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchstate

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchcountry

  data_type: 'text'
  is_nullable: 1

=head2 branchphone

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchfax

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchemail

  data_type: 'mediumtext'
  is_nullable: 1

=head2 branchurl

  data_type: 'mediumtext'
  is_nullable: 1

=head2 issuing

  data_type: 'tinyint'
  is_nullable: 1

=head2 branchip

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 branchprinter

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 branchnotes

  data_type: 'mediumtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "branchcode",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "branchname",
  { data_type => "mediumtext", is_nullable => 0 },
  "branchaddress1",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchaddress2",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchaddress3",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchzip",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "branchcity",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchstate",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchcountry",
  { data_type => "text", is_nullable => 1 },
  "branchphone",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchfax",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchemail",
  { data_type => "mediumtext", is_nullable => 1 },
  "branchurl",
  { data_type => "mediumtext", is_nullable => 1 },
  "issuing",
  { data_type => "tinyint", is_nullable => 1 },
  "branchip",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "branchprinter",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "branchnotes",
  { data_type => "mediumtext", is_nullable => 1 },
);
__PACKAGE__->add_unique_constraint("branchcode", ["branchcode"]);

=head1 RELATIONS

=head2 borrowers

Type: has_many

Related object: L<Koha::Schema::Result::Borrower>

=cut

__PACKAGE__->has_many(
  "borrowers",
  "Koha::Schema::Result::Borrower",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 branch_borrower_circ_rules

Type: has_many

Related object: L<Koha::Schema::Result::BranchBorrowerCircRule>

=cut

__PACKAGE__->has_many(
  "branch_borrower_circ_rules",
  "Koha::Schema::Result::BranchBorrowerCircRule",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 branch_item_rules

Type: has_many

Related object: L<Koha::Schema::Result::BranchItemRule>

=cut

__PACKAGE__->has_many(
  "branch_item_rules",
  "Koha::Schema::Result::BranchItemRule",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 branchrelations

Type: has_many

Related object: L<Koha::Schema::Result::Branchrelation>

=cut

__PACKAGE__->has_many(
  "branchrelations",
  "Koha::Schema::Result::Branchrelation",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 branchtransfers_frombranches

Type: has_many

Related object: L<Koha::Schema::Result::Branchtransfer>

=cut

__PACKAGE__->has_many(
  "branchtransfers_frombranches",
  "Koha::Schema::Result::Branchtransfer",
  { "foreign.frombranch" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 branchtransfers_tobranches

Type: has_many

Related object: L<Koha::Schema::Result::Branchtransfer>

=cut

__PACKAGE__->has_many(
  "branchtransfers_tobranches",
  "Koha::Schema::Result::Branchtransfer",
  { "foreign.tobranch" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 creator_batches

Type: has_many

Related object: L<Koha::Schema::Result::CreatorBatch>

=cut

__PACKAGE__->has_many(
  "creator_batches",
  "Koha::Schema::Result::CreatorBatch",
  { "foreign.branch_code" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 default_branch_circ_rule

Type: might_have

Related object: L<Koha::Schema::Result::DefaultBranchCircRule>

=cut

__PACKAGE__->might_have(
  "default_branch_circ_rule",
  "Koha::Schema::Result::DefaultBranchCircRule",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 hold_fill_targets

Type: has_many

Related object: L<Koha::Schema::Result::HoldFillTarget>

=cut

__PACKAGE__->has_many(
  "hold_fill_targets",
  "Koha::Schema::Result::HoldFillTarget",
  { "foreign.source_branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items_homebranches

Type: has_many

Related object: L<Koha::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items_homebranches",
  "Koha::Schema::Result::Item",
  { "foreign.homebranch" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items_holdingbranches

Type: has_many

Related object: L<Koha::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items_holdingbranches",
  "Koha::Schema::Result::Item",
  { "foreign.holdingbranch" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 labels_batches

Type: has_many

Related object: L<Koha::Schema::Result::LabelsBatch>

=cut

__PACKAGE__->has_many(
  "labels_batches",
  "Koha::Schema::Result::LabelsBatch",
  { "foreign.branch_code" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reserves

Type: has_many

Related object: L<Koha::Schema::Result::Reserve>

=cut

__PACKAGE__->has_many(
  "reserves",
  "Koha::Schema::Result::Reserve",
  { "foreign.branchcode" => "self.branchcode" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-04-26 16:38:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bsxLEVbxek6PMgaJ0USk4w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
