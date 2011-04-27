
use strict;
use warnings;
use 5.010;
use C4::Context;

use Test::More tests => 1;                      # last test to print

my $schema = C4::Context->schema;

isa_ok($schema, 'Koha::Schema');

