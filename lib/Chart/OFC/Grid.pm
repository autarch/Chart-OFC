package Chart::OFC::Grid;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC';


has datasets =>
    ( is       => 'ro',
      isa      => 'NonEmptyArrayRefOfTypedDatasets',
      required => 1,
    );

has x_axis =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::Axis::X',
      required => 1,
    );

has y_axis =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::Axis::Y',
      required => 1,
    );


override ofc_data_lines => sub
{
    my $self = shift;

    return
        ( super(),
        );
};


no Moose;
__PACKAGE__->meta()->make_immutable();


1;
