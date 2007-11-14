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

sub _bar_parameters
{
    my $self = shift;

    return ( $self->opacity(), $self->fill_color(), $self->outline_color(), $self->label(), $self->size() );
}


1;
