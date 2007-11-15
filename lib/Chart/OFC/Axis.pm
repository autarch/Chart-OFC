package Chart::OFC::Axis;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

with 'Chart::OFC::Role::AsOFCData';

has text_size =>
    ( is      => 'ro',
      isa     => 'Int',
      default => 10,
    );

has text_color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#784016'
    );

has grid_color =>
    ( is        => 'ro',
      isa       => 'Color',
      coerce    => 1,
      predicate => 'has_grid_color',
    );

has axis_label =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::AxisLabel',
      coerce   => 1,
      required => 1,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub ofc_data_lines { die 'This is a virtual method' }


1;
