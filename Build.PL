use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new
    ( module_name          => 'Chart::OFC',
      license              => 'perl',
      requires             => { 'Graphics::ColorNames',
                                'Moose',
                                'MooseX::Types',
                              },
      build_requires       => { 'Test::More' => 0,
                              },
      create_makefile_pl   => 'passthrough',
      create_readme        => 1,
      sign                 => 1,
      recursive_test_files => 1,
    );

$builder->create_build_script();
