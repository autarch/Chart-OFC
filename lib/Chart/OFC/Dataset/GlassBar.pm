package Chart::OFC::Dataset::GlassBar;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::FilledBar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'bar_glass';
}


1;
