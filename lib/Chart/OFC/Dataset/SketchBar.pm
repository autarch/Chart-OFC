package Chart::OFC::Dataset::SketchBar;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::OutlinedBar';

has randomness =>
    ( is      => 'ro',
      isa     => 'Chart::OFC::Type::PosOrZeroInt',
      default => '3',
    );

sub type
{
    return 'bar_sketch';
}

sub _bar_parameters
{
    my $self = shift;

    my @p = ( $self->opacity(), $self->randomness(),
              $self->fill_color(), $self->outline_color() );
    push @p, ( $self->label(), $self->text_size() )
        if $self->_has_label();

    return @p;
}

no Moose;
__PACKAGE__->meta()->make_immutable();

1;

__END__

=pod

=head1 NAME

Chart::OFC::Dataset::SketchBar - A dataset represented as "sketch" bars

=head1 SYNOPSIS

  my $bars = Chart::OFC::Dataset::SketchBar->new( values     => \@numbers,
                                                  opacity    => 60,
                                                  randomness => 5,
                                                  fill_color => 'purple',
                                                  label      => 'Candy totals',
                                                  text_size  => 12,
                                                );

=head1 DESCRIPTION

This class contains values to be charted as bars on a grid chart. The
bars are filled with the specified color in the style of a child's
crayon drawing.

=head1 ATTRIBUTES

This class is a subclass of C<Chart::OFC::Dataset::OutlinedBar> and
accepts all of that class's attributes. It has one attribute of its own.

=head2 randomness

This is an integer (0 or greater) defining how random the sketch style
is. The greater it is the more random the look. The default value is 3.

=head1 ROLES

This class does the C<Chart::OFC::Role::OFCDataLines> role.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
