package Chart::OFC::Dataset::Area;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Line';

has dot_size =>
    ( is      => 'ro',
      isa     => 'PosInt',
      default => 5,
    );

has opacity =>
    ( is         => 'ro',
      isa        => 'Opacity',
      default    => '80',
    );

has fill_color =>
    ( is        => 'ro',
      isa       => 'Color',
      coerce    => 1,
      predicate => '_has_fill_color',
    );


no Moose;
__PACKAGE__->meta()->make_immutable();


sub type
{
    return 'area_hollow';
}

sub _line_parameters
{
    my $self = shift;

    my @p = ( $self->width(), $self->dot_size(), $self->color(), $self->opacity() );

    push @p, ( $self->label(), $self->text_size() )
        if $self->_has_label();

    push @p, $self->fill_color()
        if $self->_has_fill_color();

    return @p;
}


1;


__END__

=pod

=head1 NAME

Chart::OFC::Dataset::Area - A dataset represented as a line with a filled area

=head1 SYNOPSIS

  my $bars = Chart::OFC::Dataset::Area->new( values     => \@numbers,
                                             dot_size   => 3,
                                             opacity    => 60,
                                             color      => 'blue',
                                             fill_color => 'purple',
                                             label      => 'Daily Sales in $',
                                             text_size  => 12,
                                           );

=head1 DESCRIPTION

This class contains values to be charted as a dotted line with a
filled area between the line and the X axis.

=head1 ATTRIBUTES

This class has several attributes which may be passed to the C<new()>
method.

It is a subclass of C<Chart::OFC::Dataset::Line> and accepts all of
that class's attributes as well as its own.

=head2 opacity

This defines how opaque the bars are. When they are moused over, they
become fully opaque.

Defaults to 80 (percent).

=head2 fill_color

The color used to fill the area between the line and the X axis.

This attribute is optional. If it is not provided, then OFC uses the
color of the line itself (set with the C<color> attribute).

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