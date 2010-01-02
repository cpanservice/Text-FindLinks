use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Text::FindLinks',
    license             => 'perl',
    dist_author         => q{Tomáš Znamenáček <zoul@fleuron.cz>},
    dist_version_from   => 'lib/Text/FindLinks.pm',
    requires => {
        'Params::Validate' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Text-FindLinks-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
