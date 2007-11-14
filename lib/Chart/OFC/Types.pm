package Chart::OFC::Types;

use strict;
use warnings;

use Graphics::ColorNames;

use MooseX::Types -declare => [ 'NonEmptyArrayRef' ];
use MooseX::Types::Moose qw( Str Int ArrayRef );

subtype 'NonEmptyArrayRef'
    => as ArrayRef,
    => where { scalar @{ $_ } > 0 }
    => message { 'array reference cannot be empty' };

subtype 'Color'
    => as Str,
    => where { ( uc $_ ) =~ /^\#[0-9A-F]{6}$/ }
    => message { "$_ is not a valid six-digit hex color" };

coerce 'Color'
    => from Str
    => via \&_name_to_hex_color;

{
    my $names = Graphics::ColorNames->new();
    sub _name_to_hex_color
    {
        no warnings 'uninitialized';
        return uc $names->hex( $_, '#' );
    }
}

{
    my $constraint = find_type_constraint('Color');

    subtype 'NonEmptyArrayRefOfColors'
        => as 'NonEmptyArrayRef',
        => where { for my $c ( @{ $_ } )
                   {
                       return 0 unless $constraint->check($c);
                   }
                   return 1; }
        => message { 'array reference cannot be empty and must be a list of colors' };

    coerce 'NonEmptyArrayRefOfColors'
        => from 'ArrayRef'
        => via { [ map { $constraint->coerce($_) } @{ $_ } ] };
}

{
    my $constraint = find_type_constraint('Chart::OFC::Dataset');

    subtype 'NonEmptyArrayRefOfTypedDatasets'
        => as 'NonEmptyArrayRef',
        => where { for my $c ( @{ $_ } )
                   {
                       return 0 unless $constraint->check($c);
                   }
                   return 1; }
        => message { 'array reference cannot be empty and must be a list of colors' };
}

subtype 'Angle'
    => as Int,
    => where  { $_ >= 0 && $_ <= 359 }
    => message { "$_ is not a number from 0-359" };

subtype 'Opacity'
    => as Int,
    => where { $_ >= 0 && $_ <= 100 }
    => message { "$_ is not a number from 0-100" };

subtype 'BarSize'
    => as Int,
    => where  { $_ == -1 || $_ > 0 }
    => message { "bar size must be -1 or greater than 0" };


{
    # Monkey-patch to shut up an annoying warning!

    package Graphics::ColorNames;

    no warnings 'redefine';
    sub hex {
        my $self = shift;
        my $name = shift;
        my $rgb  = $self->FETCH($name);
        return unless defined $rgb;
        my $pre  = shift;
        unless (defined $pre) { $pre = ""; }
        return ($pre.$rgb);
    }
}



1;
