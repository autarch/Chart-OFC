package Chart::OFC;

use strict;
use warnings;

our $VERSION = '0.01';

use Moose::Policy 'Chart::OFC::Policy';
use Moose;
use Chart::OFC::Types;

with 'Chart::OFC::Role::AsOFCData';

has title =>
    ( is      => 'ro',
      isa     => 'Str',
      default => '',
    );

has title_style =>
    ( is      => 'ro',
      isa     => 'Str',
      default => '',
    );

has tool_tip =>
    ( is        => 'ro',
      isa       => 'Str',
      optional  => 1,
      predicate => 'has_tool_tip',
    );

has bg_color =>
    ( is        => 'ro',
      isa       => 'Color',
      coerce    => 1,
      optional  => 1,
      predicate => 'has_bg_color',
    );

has inner_bg_color =>
    ( is        => 'ro',
      isa       => 'Color',
      coerce    => 1,
      optional  => 1,
      predicate => 'has_inner_bg_color',
    );

has inner_bg_color2 =>
    ( is        => 'ro',
      isa       => 'Color',
      coerce    => 1,
      optional  => 1,
      predicate => 'has_inner_bg_color2',
    );

has inner_bg_fade_angle =>
    ( is        => 'ro',
      isa       => 'Angle',
      optional  => 1,
      predicate => 'has_inner_bg_fade_angle',
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub BUILD
{
    my $self = shift;
    my $p    = shift;

    die "You cannot set an inner background fade angle unless you set two background colors"
        if $self->has_inner_bg_fade_angle()
           && ! ( $self->has_inner_bg_color() && $self->has_inner_bg_color2() );

    die "You cannot set a second inner background color unless you set a first color and a fade angle"
        if $self->has_inner_bg_color2()
           && ! ( $self->has_inner_bg_color() && $self->has_inner_bg_fade_angle );

    return;
}

{
    my $CRLF = "\r\n";
    sub as_ofc_data
    {
        my $self = shift;

        my @lines = $self->_ofc_data_lines();

        return join '', map { $_ . $CRLF } @lines;
    }
}

sub _ofc_data_lines
{
    my $self = shift;

    my @lines = $self->_data_line( 'title', $self->title(), $self->title_style() );

    for my $key ( qw( tool_tip bg_color ) )
    {
        my $pred = 'has_' . $key;

        push @lines, $self->_data_line( $key, $self->$key() )
            if $self->$pred();
    }

    push @lines, $self->_inner_background_line();

    return @lines;
}

sub _inner_background_line
{
    my $self = shift;

    return unless $self->has_inner_bg_color();

    my @vals = $self->inner_bg_color();

    if ( $self->has_inner_bg_color2() )
    {
        push @vals, $self->inner_bg_color2(), $self->inner_bg_fade_angle();
    }

    return $self->_data_line( 'inner_background', @vals );
}


1;

__END__

=pod

=head1 NAME

Chart::OFC - The fantastic new Chart::OFC!

=head1 SYNOPSIS

XXX - change this!

    use Chart::OFC;

    my $foo = Chart::OFC->new();

    ...

=head1 METHODS

This class provides the following methods

=head1 AUTHOR

Dave Rolsky, C<< <autarch@urth.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-chart-ofc@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
