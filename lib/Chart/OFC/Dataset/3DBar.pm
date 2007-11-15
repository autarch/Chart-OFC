# critic is on drugs, I guess
package Chart::OFC::Dataset::3DBar; ## no critic RequireFilenameMatchesPackage

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'bar_3d';
}


1;
