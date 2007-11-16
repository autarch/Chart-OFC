package Chart::OFC::Dataset::LineWithDots;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Line';

has solid_dots =>
    ( is      => 'ro',
      isa     => 'Bool',
      default => 1,
    );

has dot_size =>
    ( is      => 'ro',
      isa     => 'PosInt',
      default => 5,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    my $self = shift;

    return $self->solid_dots() ? 'line_dot' : 'line_hollow';
}

sub _line_parameters
{
    my $self = shift;

    my @p = ( $self->width(), $self->color() );
    push @p, ( $self->label(), $self->text_size(), $self->dot_size() )
        if $self->_has_label();

    return @p;
}


1;


__END__

=pod

=head1 NAME

Chart::OFC::Dataset::LineWithDots - A dataset represented as a line with dots for each value

=head1 SYNOPSIS

  my $line = Chart::OFC::Dataset::Line->new( values     => \@numbers,
                                             width      => 5,
                                             color      => 'purple',
                                             label      => 'Daily Sales in $',
                                             text_size  => 12,
                                             solid_dots => 1,
                                           );

=head1 DESCRIPTION

This class contains values to be charted as a line on a grid chart.

=head1 ATTRIBUTES

This class has several attributes which may be passed to the C<new()>
method.

It is a subclass of C<Chart::OFC::Dataset::Line> and accepts all of
that class's attributes as well as its own.

=head2 solid_dots

If true, the dots are solid, if not they are hollow.

Defaults to true.

=head2 dot_size

The size of the dots in pixels.

Defaults to 5.

=head1 ROLES

This class does the C<Chart::OFC::Role::OFCDataLines> role.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
