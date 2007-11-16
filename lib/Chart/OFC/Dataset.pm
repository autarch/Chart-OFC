package Chart::OFC::Dataset;

use strict;
use warnings;

use MooseX::StrictConstructor;
use Chart::OFC::Types;

with 'Chart::OFC::Role::OFCDataLines';

has 'values' =>
    ( is         => 'ro',
      isa        => 'NonEmptyArrayRefOfNums',
      required   => 1,
      auto_deref => 1,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub _ofc_data_lines { die 'This is a virtual method' }


1;


__END__

=pod

=head1 NAME

Chart::OFC::Dataset - A set of values to be charted

=head1 SYNOPSIS

  my $dataset = Chart::OFC::Dataset->new( values => \@numbers );

=head1 DESCRIPTION

This class represents a set of values that will be charted along the X
axis of a chart (or as pie slices).

It is a subclass of C<Chart::OFC::Bar> and accepts all of that class's
attributes as well as its own.

=head1 ATTRIBUTES

This class has one attribute which may be passed to the C<new()>
method.

=head2 values

This should be an array reference containing one more numbers for the
X axis of the chart.

This attribute is required, and must contain at least one value.

=head1 ROLES

This class does the C<Chart::OFC::Role::OFCDataLines> role.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
