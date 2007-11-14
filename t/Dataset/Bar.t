use strict;
use warnings;

use Test::More tests => 4;

use Chart::OFC::Dataset::Bar;


eval { Chart::OFC::Dataset::Bar->new( values => [ 1, 2 ], labels => [ 'a', 'b' ], size => 0 ) };
like( $@, qr/\Q(size) does not pass the type constraint (BarSize)/,
      'size cannot be 0' );

eval { Chart::OFC::Dataset::Bar->new( values => [ 1, 2 ], labels => [ 'a', 'b' ], size => -2 ) };
like( $@, qr/\Q(size) does not pass the type constraint (BarSize)/,
      'size cannot be -2' );

{
    my $bar = Chart::OFC::Dataset::Bar->new( values => [ 1,   2 ],
                                             label  => 'Things',
                                             size   => 10,
                                           );

    my @data = ( '&bar=80,#000000,Things,10&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines() ], \@data,
               'check _ofc_data_lines output' );
}

{
    my $bar = Chart::OFC::Dataset::Bar->new( values        => [ 1, 2 ],
                                             label         => 'Things',
                                             outline_color => 'red',
                                             size          => 26,
                                             opacity       => 50,
                                           );

    my @data = ( '&bar_2=50,#FF0000,Things,26&',
                 '&values_2=1,2&',
               );

    is_deeply( [ $bar->_ofc_data_lines(2) ], \@data,
               'check _ofc_data_lines output' );
}
