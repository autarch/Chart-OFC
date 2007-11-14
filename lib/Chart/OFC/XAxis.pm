package Chart::OFC::XAxis;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Axis';

has labels =>
    ( is        => 'ro',
      isa       => 'NonEmptyArrayRef',
      predicate => 'has_labels',
    );

has label_steps =>
    ( is      => 'ro',
      isa     => 'PosInt',
      default => 1,
    );

has tick_steps =>
    ( is        => 'ro',
      isa       => 'PosInt',
      predicate => 'has_tick_steps',
    );

has three_d_height =>
    ( is        => 'ro',
      isa       => 'PosInt',
      predicate => 'has_three_d_height',
    );

has orientation =>
    ( is      => 'ro',
      isa     => 'Orientation',
      default => 'horizontal',
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


my %Orientation = ( horizontal => 0,
                    vertical   => 1,
                    diagonal   => 2,
                  );
sub ofc_data_lines
{
    my $self = shift;

    my @lines = $self->legend()->ofc_data_lines('x');

    push @lines, $self->_data_line( 'x_labels', @{ $self->labels() } )
        if $self->has_labels();

    push @lines, $self->_data_line( 'x_label_style',
                                    $self->text_size(),
                                    $self->text_color(),
                                    $Orientation{ $self->orientation() },
                                    $self->label_steps(),
                                    $self->grid_color(),
                                  );

    push @lines, $self->_data_line( 'x_ticks', $self->tick_steps() )
        if $self->has_tick_steps();

    push @lines, $self->_data_line( 'x_axis_3d', $self->three_d_height() )
        if $self->has_three_d_height();

    push @lines, $self->_data_line( 'x_axis_steps', $self->tick_steps() )
        if $self->has_tick_steps();

    return @lines;
}


1;
