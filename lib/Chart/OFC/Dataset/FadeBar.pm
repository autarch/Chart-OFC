package Chart::OFC::Dataset::FadeBar;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type { 'bar_fade' }


1;
