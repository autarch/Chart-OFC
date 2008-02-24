package Chart::OFC::Types;

use strict;
use warnings;

use Graphics::ColorNames;
use List::MoreUtils qw( any );
use Moose::Util::TypeConstraints;

subtype 'Color'
    => as 'Str',
    => where { ( uc $_ ) =~ /^\#[0-9A-F]{6}$/ }
    => message { "$_ is not a valid six-digit hex color" };

coerce 'Color'
    => from 'Str'
    => via \&_name_to_hex_color;

{
    my $names = Graphics::ColorNames->new();
    sub _name_to_hex_color
    {
        no warnings 'uninitialized'; ## no critic ProhibitNoWarnings
        return uc $names->hex( $_, '#' );
    }
}

subtype 'NonEmptyArrayRef'
    => as 'ArrayRef'
    => where { return scalar @{ $_ } > 0 };

{
    my $constraint = find_type_constraint('Num');

    subtype 'NonEmptyArrayRefOfNums'
        => as 'NonEmptyArrayRef',
        => where { return 0 if any { ! $constraint->check($_) } @{ $_ };
                   return 1; }
        => message { 'array reference must contain only numbers and cannot be empty' };

    subtype 'NonEmptyArrayRefOfNumsOrUndefs'
        => as 'NonEmptyArrayRef',
        => where { return 0 if any { defined && ! $constraint->check($_) } @{ $_ };
                   return 1; }
        => message { 'array reference cannot be empty and must contain numbers or undef' };
}

{
    my $constraint = find_type_constraint('Color');

    subtype 'NonEmptyArrayRefOfColors'
        => as 'NonEmptyArrayRef',
        => where { return 0 unless @{ $_ } > 0;
                   return 0 if any { ! $constraint->check($_) } @{ $_ };
                   return 1; }
        => message { 'array reference cannot be empty and must be a list of colors' };

    coerce 'NonEmptyArrayRefOfColors'
        => from 'ArrayRef'
        => via { [ map { $constraint->coerce($_) } @{ $_ } ] };
}

{
    unless ( find_type_constraint('Chart::OFC::Dataset' ) )
    {
        subtype 'Chart::OFC::Dataset'
            => as 'Object'
            => where { $_->isa('Chart::OFC::Dataset') };
    }

    my $constraint = find_type_constraint('Chart::OFC::Dataset');

    subtype 'NonEmptyArrayRefOfTypedDatasets'
        => as 'NonEmptyArrayRef',
        => where { return 0 unless @{ $_ } > 0;
                   return 0 if any { ! ( $constraint->check($_) && $_->can('type') ) } @{ $_ };
                   return 1; }
        => message { 'array reference cannot be must be a list of typed datasets' };
}

unless ( find_type_constraint('Chart::OFC::AxisLabel' ) )
{
    subtype 'Chart::OFC::AxisLabel'
        => as 'Object'
        => where { $_->isa('Chart::OFC::AxisLabel') };
}

coerce 'Chart::OFC::AxisLabel'
    => from 'HashRef'
    => via { Chart::OFC::AxisLabel->new( %{ $_ } ) }
    => from 'Str'
    => via { Chart::OFC::AxisLabel->new( label => $_ ) };

subtype 'Angle'
    => as 'Int'
    => where  { $_ >= 0 && $_ <= 359 }
    => message { "$_ is not a number from 0-359" };

subtype 'Opacity'
    => as 'Int'
    => where { $_ >= 0 && $_ <= 100 }
    => message { "$_ is not a number from 0-100" };

subtype 'PosInt'
    => as 'Int'
    => where  { $_ > 0 }
    => message { 'must be a positive integer' };

subtype 'PosOrZeroInt'
    => as 'Int'
    => where  { $_ >= 0 }
    => message { 'must be an integer greater than or equal to zero' };

subtype 'Size'
    => as 'PosInt';

enum 'Orientation' => qw( horizontal vertical diagonal );


{
    # Monkey-patch to shut up an annoying warning!

    package                   ## no critic ProhibitMultiplePackages
        Graphics::ColorNames;

    no warnings 'redefine'; ## no critic ProhibitNoWarnings
    sub hex { ## no critic ProhibitBuiltinHomonyms
        my $self = shift;
        my $name = shift;
        my $rgb  = $self->FETCH($name);
        return unless defined $rgb; # this is the monkey line
        my $pre  = shift;
        unless (defined $pre) { $pre = ""; }
        return ($pre.$rgb);
    }
}

no Moose::Util::TypeConstraints;

1;


__END__

=pod

=head1 NAME

Chart::OFC::Types - type library for Chart::OFC

=head1 SYNOPSIS

  package Chart::OFC::Thingy;

  use Chart::OFC::Types;

  has opacity =>
      ( is  => 'ro',
        isa => 'Opacity',
      );

=head1 DESCRIPTION

This class provides a library of types for use by other Chart::OFC
classes.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
