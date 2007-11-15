package Chart::OFC::Dataset::Line;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset';

has width =>
    ( is      => 'ro',
      isa     => 'PosInt',
      default => 1,
    );

has color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#000000',
    );

has label =>
    ( is        => 'ro',
      isa       => 'Str',
      predicate => 'has_label',
    );

has text_size =>
    ( is      => 'ro',
      isa     => 'Size',
      default => -1,
    );


no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'line';
}

sub ofc_data_lines
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
        ( $self->_data_line( $name, $self->_line_parameters() ),
          $self->_data_line( $val_name, $self->values() ),
        );
}

sub _line_parameters
{
    my $self = shift;

    my @p = ( $self->width(), $self->color() );
    push @p, ( $self->label(), $self->text_size() )
        if $self->has_label();

    return @p;
}


1;
