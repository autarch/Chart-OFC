use strict;
use warnings;

use Test::More tests => 3;

use Chart::OFC::Dataset::Area;

{
    my $bar = Chart::OFC::Dataset::Area->new( values => [ 1, 2 ],
                                            );
    my @data = ( '&area_hollow=2,5,#000000,80&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - no label' );
}

{
    my $bar = Chart::OFC::Dataset::Area->new( values    => [ 1, 2 ],
                                              label     => 'Intensity',
                                              text_size => 5,
                                            );
    my @data = ( '&area_hollow=2,5,#000000,80,Intensity,5&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - labeled' );
}

{
    my $bar = Chart::OFC::Dataset::Area->new( values     => [ 1, 2 ],
                                              label      => 'Intensity',
                                              text_size  => 5,
                                              color      => 'red',
                                              dot_size   => 8,
                                              opacity    => 60,
                                              fill_color => 'blue',
                                            );
    my @data = ( '&area_hollow=2,8,#FF0000,60,Intensity,5,#0000FF&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - all parameters' );
}
