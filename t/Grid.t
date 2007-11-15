use strict;
use warnings;

use Test::More tests => 4;

use Chart::OFC::Grid;
use Chart::OFC::Dataset::Bar;
use Chart::OFC::XAxis;
use Chart::OFC::YAxis;


my @datasets = Chart::OFC::Dataset::Bar->new( values => [ 1 .. 5] );
my $x_axis = Chart::OFC::XAxis->new( axis_label => 'X Axis' );
my $y_axis = Chart::OFC::YAxis->new( axis_label => 'Y Axis', max => 100, tick_steps => 20 );

eval { Chart::OFC::Grid->new( datasets => \@datasets, y_axis => $y_axis ) };
like( $@, qr/\Q(x_axis) is required/, 'x_axis is required for constructor' );

eval { Chart::OFC::Grid->new( datasets => \@datasets, x_axis => $x_axis ) };
like( $@, qr/\Q(y_axis) is required/, 'y_axis is required for constructor' );

eval { Chart::OFC::Grid->new( x_axis => $x_axis, y_axis => $y_axis ) };
like( $@, qr/\Q(datasets) is required/, 'datasets is required for constructor' );

{
    my $chart = Chart::OFC::Grid->new( title    => 'Grid Test',
                                       datasets => \@datasets,
                                       x_axis   => $x_axis,
                                       y_axis   => $y_axis,
                                     );

    my @data = ( '&title=Grid Test&',
                 $x_axis->ofc_data_lines(),
                 $y_axis->ofc_data_lines(),
                 $datasets[0]->ofc_data_lines(1),
               );

    my $data = join '', map { $_ . "\r\n" } @data;
    is( $chart->as_ofc_data(), $data,
        'check as_ofc_data output' );
}
