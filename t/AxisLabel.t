use strict;
use warnings;

use Test::More tests => 3;

use Chart::OFC::AxisLabel;


eval { Chart::OFC::AxisLabel->new() };
like( $@, qr/\Q(label) is required/, 'label is required for constructor' );

{
    my $legend = Chart::OFC::AxisLabel->new( label => 'Months' );
    is( $legend->ofc_data_lines('x'), '&x_legend=Months,-1,#000000&',
        'data lines with defaults' );
}

{
    my $legend = Chart::OFC::AxisLabel->new( label      => 'Months',
                                             text_color => 'red',
                                             text_size  => 10,
                                           );
    is( $legend->ofc_data_lines('x'), '&x_legend=Months,10,#FF0000&',
        'data lines with all attributes set' );
}
