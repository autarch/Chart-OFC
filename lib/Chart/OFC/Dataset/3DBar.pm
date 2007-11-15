package Chart::OFC::Dataset::3DBar;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type { 'bar_3d' }


1;
