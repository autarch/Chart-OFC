package Chart::OFC::Dataset::FadeBar;

use strict;
use warnings;

use Moose;
use MooseX::StrictConstructor;
use Chart::OFC::Types;

extends 'Chart::OFC::Dataset::Bar';

sub type
{
    return 'bar_fade';
}

no Moose;

__PACKAGE__->meta()->make_immutable();

1;


__END__

=pod

=head1 NAME

Chart::OFC::Dataset::FadeBar - A dataset represented as "fade" bars

=head1 SYNOPSIS

  my $bars = Chart::OFC::Dataset::FadeBar->new( values     => \@numbers,
                                                opacity    => 60,
                                                fill_color => 'purple',
                                                label      => 'Daily Sales in $',
                                                text_size  => 12,
                                              );

=head1 DESCRIPTION

This class contains values to be charted as bars on a grid chart. The
bars are filled with the specified color and fade towards their end.

=head1 ATTRIBUTES

This class is a subclass of C<Chart::OFC::Dataset::Bar> and accepts
all of that class's attributes. It has no attributes of its own.

=head1 ROLES

This class does the C<Chart::OFC::Role::OFCDataLines> role.

=head1 COPYRIGHT & LICENSE

Copyright 2007-2008 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
