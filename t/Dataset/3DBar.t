use strict;
use warnings;

use Test::More tests => 2;

use Chart::OFC::Dataset::3DBar;


{
    my $bar = Chart::OFC::Dataset::3DBar->new( values    => [ 1, 2 ],
                                               label     => 'Things',
                                               text_size => 10,
                                             );

    my @data = ( '&bar_3d=80,#000000,Things,10&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->ofc_data_lines() ], \@data,
               'check ofc_data_lines output' );
}

{
    my $bar = Chart::OFC::Dataset::3DBar->new( values        => [ 1, 2 ],
                                               label         => 'Things',
                                               outline_color => 'red',
                                               text_size     => 26,
                                               opacity       => 50,
                                             );

    my @data = ( '&bar_3d_2=50,#FF0000,Things,26&',
                 '&values_2=1,2&',
               );

    is_deeply( [ $bar->ofc_data_lines(2) ], \@data,
               'check ofc_data_lines output' );
}
