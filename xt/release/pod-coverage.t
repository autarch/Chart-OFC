use strict;
use warnings;

use Test::More;

use Test::Requires {
    'Test::Pod::Coverage' => '1.04',
};

all_pod_coverage_ok(
    {
        coverage_class => 'Pod::Coverage::Moose',
        trustme        => [qr/^(?:new|BUILD|type)$/],
    }
);
