package Chart::OFC::AxisLabel;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

with 'Chart::OFC::Role::AsOFCData';

has label =>
    ( is       => 'ro',
      isa      => 'Str',
      required => 1,
    );

has text_color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#000000',
    );

has text_size =>
    ( is      => 'ro',
      isa     => 'Size',
      default => 20,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub ofc_data_lines
{
    my $self = shift;
    my $name = shift;

    return $self->_data_line( $name . '_legend', $self->label(), $self->text_size(), $self->text_color() );
}


1;
