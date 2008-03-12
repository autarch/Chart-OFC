package Chart::OFC::Dataset::OutlinedBar;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

has outline_color =>
    ( is      => 'ro',
      isa     => 'Chart::OFC::Type::Color',
      coerce  => 1,
      default => '#000000',
    );

sub type
{
    return 'filled_bar';
}

sub _bar_parameters
{
    my $self = shift;

    my @p = ( $self->opacity(), $self->fill_color(), $self->outline_color() );
    push @p, ( $self->label(), $self->text_size() )
        if $self->_has_label();

    return @p;
}

no Moose;
__PACKAGE__->meta()->make_immutable();

1;


=pod

=head1 NAME

Chart::OFC::Dataset::OutlinedBar - A dataset represented as outlined bars

=head1 SYNOPSIS

  my $bars = Chart::OFC::Dataset::OutlinedBar->new( values     => \@numbers,
                                                    opacity    => 60,
                                                    fill_color => 'purple',
                                                    label      => 'Daily Sales in $',
                                                    text_size  => 12,
                                                  );

=head1 DESCRIPTION

This class contains values to be charted as bars on a grid chart. The
bars are filled with the specified color and have a separate outline
color. They are styled to give a "glass" look.

=head1 ATTRIBUTES

This class is a subclass of C<Chart::OFC::Dataset::Bar> and accepts
all of that class's attributes. It has one attribute of its own.

=head2 outline_color

This is the color used to outline the bar.

Defaults to #000000 (black).

=head1 ROLES

This class does the C<Chart::OFC::Role::OFCDataLines> role.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
