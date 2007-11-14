use strict;
use warnings;

use Test::More tests => 3;

use Chart::OFC::Dataset;


eval { Chart::OFC::Dataset->new() };
like( $@, qr/\Q(values) is required/, 'values is required for constructor' );

eval { Chart::OFC::Dataset->new( values => [] ) };
like( $@, qr/\Qpass the type constraint (NonEmptyArrayRef)/, 'values cannot be empty' );

my $ds = Chart::OFC::Dataset->new( values => [ 1, 2 ] );
is_deeply( [ $ds->values() ], [ 1, 2 ], 'check values() attribute' );

