use 5.006;
use strict;
use warnings;
use Module::Build::Tiny;

my $builder = Module::Build::Tiny->new(
    module_name         => 'App::fftrim',
    license             => 'artistic_2',
    dist_author         => q{Joel Roth <joelz@pobox.com >},
    dist_version_from   => 'lib/App/fftrim.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => '0',
    },
    build_requires => {
        'Test::More' => '0',
    },
    requires => {
        #'ABC'              => '1.6',
        #'Foo::Bar::Module' => '5.0401',
    },
    add_to_cleanup     => [ 'App-fftrim-*' ],
);

$builder->create_build_script();
