package Chart::OFC::Dataset::FilledBar;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

has fill_color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#999999',
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type { 'filled_bar' }

sub _bar_parameters
{
    my $self = shift;

    return ( $self->opacity(), $self->fill_color(), $self->outline_color(), $self->label(), $self->size() );
}


1;
