package Chart::OFC::Dataset;

use strict;
use warnings;

use Moose;
use Chart::OFC::Types;

with 'Chart::OFC::Role::AsOFCData';

has 'values' =>
    ( is         => 'ro',
      isa        => 'NonEmptyArrayRef',
      required   => 1,
      auto_deref => 1,
    );

no Moose;
__PACKAGE__->meta()->make_immutable();


sub ofc_data_lines { die 'This is a virtual method' }


1;
