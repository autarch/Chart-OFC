package Chart::OFC::Dataset::FadeBar;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'bar_fade';
}


1;
