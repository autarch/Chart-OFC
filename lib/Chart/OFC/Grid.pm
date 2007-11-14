package Chart::OFC::Grid;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC';


has datasets =>
    ( is       => 'ro',
      isa      => '',
      required => 1,
    );


override _ofc_data_lines => sub
{
    my $self = shift;

    return
        ( super(),
        );
};


no Moose;
__PACKAGE__->meta()->make_immutable();

1;
