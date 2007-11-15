package Chart::OFC::YAxis;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Axis';


has min =>
    ( is      => 'ro',
      isa     => 'Num',
      default => 0,
    );

has max =>
    ( is       => 'ro',
      isa      => 'Num',
      required => 1,
    );

has small_tick_size =>
    ( is      => 'ro',
      isa     => 'Int',
      default => 5,
    );

has large_tick_size =>
    ( is      => 'ro',
      isa     => 'Int',
      default => 10,
    );

has tick_steps =>
    ( is       => 'ro',
      isa      => 'PosInt',
      required => 1,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub ofc_data_lines
{
    my $self = shift;

    my @lines = $self->axis_label()->ofc_data_lines('y');

    push @lines, $self->_data_line( 'y_label_style',
                                    $self->text_size(), $self->text_color(),
                                  );

    push @lines, $self->_data_line( 'y_ticks',
                                    $self->small_tick_size(),
                                    $self->large_tick_size(),
                                    $self->tick_steps(),
                                  );

    push @lines, $self->_data_line( 'y_min', $self->min() );

    push @lines, $self->_data_line( 'y_max', $self->max() );

    push @lines, $self->_data_line( 'y_axis_colour', $self->text_color() );

    push @lines, $self->_data_line( 'y_grid_colour', $self->grid_color() );

    return @lines;
}


1;
