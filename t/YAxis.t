use strict;
use warnings;

use Test::More tests => 5;

use Chart::OFC::YAxis;
use Chart::OFC::AxisLabel;


eval { Chart::OFC::YAxis->new( tick_steps => 4, max => 20 ) };
like( $@, qr/\Q(legend) is required/, 'legend is required for constructor' );

eval { Chart::OFC::YAxis->new( legend => 'Foo', max => 20 ) };
like( $@, qr/\Q(tick_steps) is required/, 'tick_steps is required for constructor' );

eval { Chart::OFC::YAxis->new( legend => 'Foo', tick_steps => 4 ) };
like( $@, qr/\Q(max) is required/, 'max is required for constructor' );

{
    my $legend = Chart::OFC::AxisLabel->new( label => 'Size' );

    my $axis = Chart::OFC::YAxis->new( legend     => $legend,
                                       max        => 20,
                                       tick_steps => 4,
                                     );

    my @lines = ( '&y_legend=Size,-1,#000000&',
                  '&y_label_style=10,#000000&',
                  '&y_ticks=5,10,4&',
                  '&y_min=0&',
                  '&y_max=20&',
                  '&y_axis_colour=#000000&',
                  '&y_grid_colour=#000000&',
                );
    is_deeply( [ $axis->ofc_data_lines() ], \@lines,
               'data lines with defaults and label-only legend' );
}

{
    my $axis = Chart::OFC::YAxis->new( legend     => 'Size',
                                       min        => -10,
                                       max        => 20.5,
                                       small_tick_size => 2,
                                       large_tick_size => 20,
                                       tick_steps => 3,
                                     );

    my @lines = ( '&y_legend=Size,-1,#000000&',
                  '&y_label_style=10,#000000&',
                  '&y_ticks=2,20,3&',
                  '&y_min=-10&',
                  '&y_max=20.5&',
                  '&y_axis_colour=#000000&',
                  '&y_grid_colour=#000000&',
                );
    is_deeply( [ $axis->ofc_data_lines() ], \@lines,
               'data lines with defaults and label-only legend' );
}
