use strict;
use warnings;

use Test::More tests => 5;

use Chart::OFC::Dataset::Bar;


eval { Chart::OFC::Dataset::Bar->new( values => [ 1, 2 ], labels => [ 'a', 'b' ], text_size => 0 ) };
like( $@, qr/\Q(text_size) does not pass the type constraint (Size)/,
      'text_size cannot be 0' );

eval { Chart::OFC::Dataset::Bar->new( values => [ 1, 2 ], labels => [ 'a', 'b' ], text_size => -2 ) };
like( $@, qr/\Q(text_size) does not pass the type constraint (Size)/,
      'text_size cannot be -2' );

{
    my $bar = Chart::OFC::Dataset::Bar->new( values => [ 1, 2 ],
                                           );
    my @data = ( '&bar=80,#000000&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->ofc_data_lines() ], \@data,
               'check ofc_data_lines output - no label' );
}

{
    my $bar = Chart::OFC::Dataset::Bar->new( values    => [ 1, 2 ],
                                             label     => 'Things',
                                             text_size => 10,
                                           );

    my @data = ( '&bar=80,#000000,Things,10&',
                 '&values=1,2&',
               );

    is_deeply( [ $bar->ofc_data_lines() ], \@data,
               'check ofc_data_lines output - labeled' );
}

{
    my $bar = Chart::OFC::Dataset::Bar->new( values        => [ 1, 2 ],
                                             label         => 'Things',
                                             outline_color => 'red',
                                             text_size     => 26,
                                             opacity       => 50,
                                           );

    my @data = ( '&bar_2=50,#FF0000,Things,26&',
                 '&values_2=1,2&',
               );

    is_deeply( [ $bar->ofc_data_lines(2) ], \@data,
               'check ofc_data_lines output - all parameteres' );
}
