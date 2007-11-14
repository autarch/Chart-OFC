use strict;
use warnings;

use Test::More tests => 6;

use Chart::OFC;


eval { Chart::OFC->new( inner_bg_color2 => 'red' ) };
like( $@, qr/\QYou cannot set a second inner background color unless you set a first color and a fade angle/,
      'cannot set inner_bg_color2 without setting inner_bg_color' );

eval { Chart::OFC->new( inner_bg_color => 'blue', inner_bg_color2 => 'red' ) };
like( $@, qr/\QYou cannot set a second inner background color unless you set a first color and a fade angle/,
      'cannot set inner_bg_color2 without setting inner_bg_color' );

eval { Chart::OFC->new( inner_bg_fade_angle => 90 ) };
like( $@, qr/\QYou cannot set an inner background fade angle unless you set two background colors/,
      'cannot set inner_bg_fade_color without setting two bg colors' );

eval { Chart::OFC->new( inner_bg_color2 => 'red', inner_bg_fade_angle => 90 ) };
like( $@, qr/\QYou cannot set an inner background fade angle unless you set two background colors/,
      'cannot set inner_bg_fade_color without setting two bg colors' );

eval { Chart::OFC->new( inner_bg_color => 'red', inner_bg_fade_angle => 90 ) };
like( $@, qr/\QYou cannot set an inner background fade angle unless you set two background colors/,
      'cannot set inner_bg_fade_color without setting two bg colors' );


my $chart =
    Chart::OFC->new( title               => 'Test Title',
                     title_style         => '{ font-size: 20px }',
                     bg_color            => '#FF0000',
                     inner_bg_color      => '#FFFF00',
                     inner_bg_color2     => '#FFFFFF',
                     inner_bg_fade_angle => 152,
                     tool_tip            => '#key#: #val#',
                   );

{
    my @data = ( '&title=Test Title,{ font-size: 20px }&',
                 '&tool_tip=#key#: #val#&',
                 '&bg_colour=#FF0000&',
                 '&inner_background=#FFFF00,#FFFFFF,152&',
               );

    my $data = join '', map { $_ . "\r\n" } @data;
    is( $chart->as_ofc_data(), $data,
        'check as_ofc_data output' );
}
