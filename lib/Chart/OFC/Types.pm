package Chart::OFC::Types;

use strict;
use warnings;

use Graphics::ColorNames;

use MooseX::Types -declare => [ 'NonEmptyArrayRef' ];
use MooseX::Types::Moose qw( Str Int ArrayRef HashRef Object );

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
        no warnings 'uninitialized'; ## no critic ProhibitNoWarnings
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
    unless ( find_type_constraint('Chart::OFC::Dataset' ) )
    {
        subtype 'Chart::OFC::Dataset'
            => as Object
            => where { $_->isa('Chart::OFC::Dataset') };
    }

    my $constraint = find_type_constraint('Chart::OFC::Dataset');

    subtype 'NonEmptyArrayRefOfTypedDatasets'
        => as 'NonEmptyArrayRef',
        => where { for my $c ( @{ $_ } )
                   {
                       return 0 unless $constraint->check($c);
                       return 0 unless $c->can('type');
                   }
                   return 1; }
        => message { 'array reference cannot be must be a list of typed datasets' };
}

unless ( find_type_constraint('Chart::OFC::AxisLabel' ) )
{
    subtype 'Chart::OFC::AxisLabel'
        => as Object
        => where { $_->isa('Chart::OFC::AxisLabel') };
}

coerce 'Chart::OFC::AxisLabel'
    => from HashRef
    => via { Chart::OFC::AxisLabel->new( %{ $_ } ) }
    => from Str
    => via { Chart::OFC::AxisLabel->new( label => $_ ) };

subtype 'Angle'
    => as Int,
    => where  { $_ >= 0 && $_ <= 359 }
    => message { "$_ is not a number from 0-359" };

subtype 'Opacity'
    => as Int,
    => where { $_ >= 0 && $_ <= 100 }
    => message { "$_ is not a number from 0-100" };

subtype 'Size'
    => as Int,
    => where  { $_ == -1 || $_ > 0 }
    => message { "bar size must be -1 or greater than 0" };

subtype 'PosInt'
    => as Int,
    => where  { $_ > 0 }
    => message { 'must be a positive integer' };

subtype 'PosNum'
    => as Int,
    => where  { $_ > 0 }
    => message { 'must be a positive number' };

enum 'Orientation' => qw( horizontal vertical diagonal );


{
    # Monkey-patch to shut up an annoying warning!

    package Graphics::ColorNames; ## no critic ProhibitMultiplePackages

    no warnings 'redefine'; ## no critic ProhibitNoWarnings
    sub hex { ## no critic ProhibitBuiltinHomonyms
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
