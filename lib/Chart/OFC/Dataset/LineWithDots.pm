package Chart::OFC::Dataset::LineWithDots;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Line';

has is_solid =>
    ( is      => 'ro',
      isa     => 'Bool',
      default => 1,
    );

has dot_size =>
    ( is      => 'ro',
      isa     => 'PosInt',
      default => 5,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    my $self = shift;

    return $self->is_solid() ? 'line_dot' : 'line_hollow';
}

sub _line_parameters
{
    my $self = shift;

    my @p = ( $self->width(), $self->color() );
    push @p, ( $self->label(), $self->text_size(), $self->dot_size() )
        if $self->has_label();

    return @p;
}


1;
