package Chart::OFC::Role::AsOFCData;

use strict;
use warnings;

use Moose::Role;


sub _data_line
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
