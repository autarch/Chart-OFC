package Chart::OFC::Dataset;

use strict;
use warnings;

use Moose::Policy 'Chart::OFC::Policy';
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


1;
