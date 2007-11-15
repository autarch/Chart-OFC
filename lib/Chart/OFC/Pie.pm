package Chart::OFC::Pie;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC';

has dataset =>
    ( is       => 'ro',
      isa      => 'Chart::OFC::Dataset',
      required => 1,
    );

has slice_colors =>
    ( is         => 'ro',
      isa        => 'NonEmptyArrayRefOfColors',
      coerce     => 1,
      lazy       => 1,
      default    => sub { [ qw( red blue green yellow orange purple black ) ] },
    );

has line_color =>
    ( is         => 'ro',
      isa        => 'Color',
      coerce     => 1,
      default    => '#000000',
    );

has 'labels' =>
    ( is         => 'ro',
      isa        => 'NonEmptyArrayRef',
      required   => 1,
      auto_deref => 1,
    );

has label_color =>
    ( is         => 'ro',
      isa        => 'Color',
      coerce     => 1,
      default    => '#000000',
    );

has opacity =>
    ( is         => 'ro',
      isa        => 'Opacity',
      default    => '80',
    );

sub BUILD
{
    my $self = shift;

    my @l = $self->labels();
    my @v = $self->dataset()->values();

    die 'You must have the same number of labels and values.'
        unless @l == @v;

    return;
}

override ofc_data_lines => sub
{
    my $self = shift;

    return
        ( super(),
          $self->_data_line( 'pie', $self->opacity(), $self->line_color(), $self->label_color() ),
          $self->_data_line( 'values', $self->dataset()->values() ),
          $self->_data_line( 'pie_labels', $self->labels() ),
          $self->_data_line( 'colours', @{ $self->slice_colors() } ),
        );
};


no Moose;
__PACKAGE__->meta()->make_immutable();


1;
