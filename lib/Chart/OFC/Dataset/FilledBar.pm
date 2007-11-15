package Chart::OFC::Dataset::FilledBar;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

has fill_color =>
    ( is      => 'ro',
      isa     => 'Color',
      coerce  => 1,
      default => '#999999',
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'filled_bar';
}

sub _bar_parameters
{
    my $self = shift;

    my @p = ( $self->opacity(), $self->fill_color(), $self->outline_color() );
    push @p, ( $self->label(), $self->text_size() )
        if $self->has_label();

    return @p;
}


1;
