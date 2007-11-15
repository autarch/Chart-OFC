package Chart::OFC::Grid;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC';

has datasets =>
    ( is       => 'ro',
      isa      => 'NonEmptyArrayRefOfTypedDatasets',
      required => 1,
    );

has x_axis =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::XAxis',
      required => 1,
    );

has y_axis =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::YAxis',
      required => 1,
    );


override ofc_data_lines => sub
{
    my $self = shift;

    my $x = 1;
    return
        ( super(),
          $self->x_axis()->ofc_data_lines(),
          $self->y_axis()->ofc_data_lines(),
          map { $_->ofc_data_lines($x++) } @{ $self->datasets() },
        );
};


no Moose;
__PACKAGE__->meta()->make_immutable();


1;
