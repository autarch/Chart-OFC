package Chart::OFC::Role::AsOFCData;

use strict;
use warnings;

use Moose::Role;

requires 'ofc_data_lines';


sub _data_line ## no critic RequireArgUnpacking
{
    my $self  = shift;
    my $label = shift;
    my @vals  = @_;

    $label =~ s/color/colour/;

    my $line = q{&} . $label . q{=};
    $line .= join ',', @vals;
    $line .= q{&};

    return $line;
}


1;
