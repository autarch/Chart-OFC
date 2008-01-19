use strict;
use warnings;

use Test::More tests => 4;

use Chart::OFC::Dataset::Line;

{
    my $bar = Chart::OFC::Dataset::Line->new( values => [ 1, 2 ],
                                           );
    my @data = ( '&line=2,#000000&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - no label' );
}

{
    my $bar = Chart::OFC::Dataset::Line->new( values    => [ 1, 2 ],
                                              label     => 'Intensity',
                                              text_size => 5,
                                           );
    my @data = ( '&line=2,#000000,Intensity,5&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - labeled' );
}

{
    my $bar = Chart::OFC::Dataset::Line->new( values    => [ 1, 2 ],
                                              width     => 3,
                                              label     => 'Intensity',
                                              text_size => 5,
                                              color     => 'red',
                                           );
    my @data = ( '&line=3,#FF0000,Intensity,5&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output - all parameters' );
}

{
    my $bar = Chart::OFC::Dataset::Line->new( values => [ 1, 2, undef, 3 ],
                                              width  => 2,
                                              color  => 'red',
                                            );
    my @data = ( '&line=2,#FF0000&',
                 '&values=1,2,null,3&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               q{check _ofc_Data_lines output with some values as 'null'} );
}
