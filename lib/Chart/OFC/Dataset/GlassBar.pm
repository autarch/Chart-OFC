package Chart::OFC::Dataset::GlassBar;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::FilledBar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type { 'bar_glass' }


1;
