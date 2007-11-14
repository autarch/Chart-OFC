use strict;
use warnings;

use Test::More tests => 2;

use Chart::OFC::Dataset::FilledBar;


{
    my $bar = Chart::OFC::Dataset::FilledBar->new( values => [ 1,   2 ],
                                                   label  => 'Things',
                                                   size   => 10,
                                                 );

    my @data = ( '&filled_bar=80,#999999,#000000,Things,10&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output' );
}

{
    my $bar = Chart::OFC::Dataset::FilledBar->new( values        => [ 1, 2 ],
                                                   label         => 'Things',
                                                   fill_color    => 'blue',
                                                   outline_color => 'red',
                                                   size          => 26,
                                                   opacity       => 50,
                                                 );

    my @data = ( '&filled_bar_2=50,#0000FF,#FF0000,Things,26&',
                 '&values_2=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines(2) ], \@data,
               'check _ofc_data_lines output' );
}
