package Chart::OFC::Dataset::Bar;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset';

has opacity =>
    ( is         => 'ro',
      isa        => 'Opacity',
      default    => '80',
    );

has outline_color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#000000',
    );

has label =>
    ( is      => 'ro',
      isa     => 'Str',
      default => '',
    );

has size =>
    ( is      => 'ro',
      isa     => 'BarSize',
      default => -1,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'bar';
}

sub _ofc_data_lines
{
    my $self  = shift;
    my $count = shift;

    my $name = $self->type();
    $name .= q{_} . $count
        if $count && $count > 1;

    my $val_name = 'values';
    $val_name .= q{_} . $count
        if $count && $count > 1;

    return
        ( $self->_data_line( $name, $self->_bar_parameters() ),
          $self->_data_line( $val_name, $self->values() ),
        );
}

sub _bar_parameters
{
    my $self = shift;

    return ( $self->opacity(), $self->outline_color(), $self->label(), $self->size() );
}


1;
